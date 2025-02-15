#include <OpenHome/Av/ProviderDebug.h>
#include <OpenHome/Private/Printer.h>
#include <OpenHome/Private/Stream.h>
#include <OpenHome/Optional.h>
#include <OpenHome/Av/Logger.h>
#include <OpenHome/Net/Private/DviStack.h>
#include <OpenHome/Private/Env.h>
#include <OpenHome/Private/Network.h>
#include <OpenHome/Private/NetworkAdapterList.h>
#include <OpenHome/Private/Timer.h>
#include <OpenHome/Net/Private/Discovery.h>
#include <OpenHome/Net/Core/OhNet.h>
#include <OpenHome/Json.h>

#include <utility>
#include <vector>

using namespace OpenHome;
using namespace OpenHome::Av;
using namespace OpenHome::Net;

bool operator==(const TIpAddress& l, const TIpAddress& p)
{
    return l.iFamily == p.iFamily
        && l.iV4 == p.iV4
        && l.iV6 == p.iV6;
}

// MSearchObserver

const TUint MSearchObserver::kMaxAddresses = 10;

MSearchObserver::MSearchObserver(Environment& aEnv)
    : iLock("MObs")
    , iEnv(aEnv)
    , iMulticastListener(nullptr)
    , iMulticastAdapter({0})
{
    iRecentSearchers.reserve(kMaxAddresses);
    iAdapterChangeListenerId = iEnv.NetworkAdapterList().AddCurrentChangeListener(MakeFunctor(*this, &MSearchObserver::CurrentAdapterChanged), "Av::MSearchObserver");
    CurrentAdapterChanged();
}

MSearchObserver::~MSearchObserver()
{
    iEnv.NetworkAdapterList().RemoveCurrentChangeListener(iAdapterChangeListenerId);
    if (iMulticastListener != nullptr) {
        iMulticastListener->RemoveMsearchHandler(iMsearchHandlerId);
        iEnv.MulticastListenerRelease(iMulticastAdapter);
        iMulticastListener = nullptr;
    }
}

std::vector<std::pair<TIpAddress, TUint>> MSearchObserver::RecentSearchers() const
{
    AutoMutex _(iLock);
    return iRecentSearchers;
}

void MSearchObserver::CurrentAdapterChanged()
{
    AutoMutex _(iLock);
    if (iMulticastListener != nullptr) {
        iMulticastListener->RemoveMsearchHandler(iMsearchHandlerId);
        iEnv.MulticastListenerRelease(iMulticastAdapter);
        iMulticastListener = nullptr;
    }
    AutoNetworkAdapterRef adRef(iEnv, "Av::MSearchObserver");
    const auto ad = adRef.Adapter();
    if (ad == nullptr) {
        iMulticastAdapter = {0};
    }
    else {
        iMulticastAdapter = ad->Address();
        iMulticastListener = &iEnv.MulticastListenerClaim(iMulticastAdapter);
        iMsearchHandlerId = iMulticastListener->AddMsearchHandler(this);
    }
}

void MSearchObserver::NotifySearch(const Endpoint& aEndpoint)
{
    AutoMutex _(iLock);
    const auto addr = aEndpoint.Address();
    const auto time = Time::Now(iEnv);

    // is this address alredy stored?  Update it.
    for (auto p : iRecentSearchers) {
        if (p.first == addr) {
            p.second = time;
            return;
        }
    }

    // is the list of recent searches full?  Prune the oldest
    if (iRecentSearchers.size() == kMaxAddresses) {
        TUint oldestIndex = 0;
        TUint oldestTime = 0;
        for (TUint i = 0; i < (TUint)iRecentSearchers.size(); i++) {
            const auto delta = iRecentSearchers[i].second - oldestTime;
            if (delta > oldestTime) {
                oldestTime = delta;
                oldestIndex = i;
            }
        }
        iRecentSearchers.erase(iRecentSearchers.begin() + oldestIndex);
    }

    // new address - add to list
    iRecentSearchers.push_back(std::pair<TIpAddress, TUint>(addr, time));
}

void MSearchObserver::SsdpSearchAll(const Endpoint& aEndpoint, TUint /*aMx*/)
{
    NotifySearch(aEndpoint);
}

void MSearchObserver::SsdpSearchRoot(const Endpoint& aEndpoint, TUint /*aMx*/)
{
    NotifySearch(aEndpoint);
}

void MSearchObserver::SsdpSearchUuid(const Endpoint& aEndpoint, TUint /*aMx*/, const Brx& /*aUuid*/)
{
    NotifySearch(aEndpoint);
}

void MSearchObserver::SsdpSearchDeviceType(const Endpoint& aEndpoint, TUint /*aMx*/, const Brx& /*aDomain*/, const Brx& /*aType*/, TUint /*aVersion*/)
{
    NotifySearch(aEndpoint);
}

void MSearchObserver::SsdpSearchServiceType(const Endpoint& aEndpoint, TUint /*aMx*/, const Brx& /*aDomain*/, const Brx& /*aType*/, TUint /*aVersion*/)
{
    NotifySearch(aEndpoint);
}


// ProviderDebug

ProviderDebug::ProviderDebug(DvDevice& aDevice, RingBufferLogger& aLogger, Optional<ILogPoster> aLogPoster)
    : DvProviderAvOpenhomeOrgDebug2(aDevice)
    , iLogger(aLogger)
    , iLogPoster(aLogPoster)
    , iDvStack(aDevice.Device().GetDvStack())
    , iMSearchObserver(iDvStack.Env())
{
    EnableActionGetLog();
    EnableActionSendLog();
    EnableActionSendDeviceAnnouncements();
    EnableActionGetRecentMSearches();
}

void ProviderDebug::GetLog(IDvInvocation& aInvocation, IDvInvocationResponseString& aLog)
{
    aInvocation.StartResponse();
    iLogger.Read(aLog);
    aLog.WriteFlush();
    aInvocation.EndResponse();
}

void ProviderDebug::SendLog(IDvInvocation& aInvocation, const Brx& aData)
{
    if (!iLogPoster.Ok()) {
        aInvocation.Error(801, Brn("Not supported"));
    }
    iLogPoster.Unwrap().SendLog(iLogger, aData);
    aInvocation.StartResponse();
    aInvocation.EndResponse();
}

void ProviderDebug::SendDeviceAnnouncements(IDvInvocation& aInvocation)
{
    auto deviceMap = iDvStack.DeviceMap().CopyMap();
    for (auto p : deviceMap) {
        p.second->SendAnnouncements();
    }
    iDvStack.DeviceMap().ClearMap(deviceMap);
    aInvocation.StartResponse();
    aInvocation.EndResponse();
}

void ProviderDebug::GetRecentMSearches(IDvInvocation& aInvocation, IDvInvocationResponseString& aJsonArray)
{
    const auto timeNow = Time::Now(iDvStack.Env());
    auto searches = iMSearchObserver.RecentSearchers();
    aInvocation.StartResponse();
    WriterJsonArray writerArray(aJsonArray);
    for (auto p : searches) {
        auto writerObj = writerArray.CreateObject();
        Endpoint::AddressBuf addrBuf;
        Endpoint::AppendAddress(addrBuf, p.first);
        const auto seconds = (timeNow - p.second) / 1000;
        writerObj.WriteString("address", addrBuf);
        writerObj.WriteUint("age_seconds", seconds);
        writerObj.WriteEnd();
    }
    writerArray.WriteEnd();
    aJsonArray.WriteFlush();
    aInvocation.EndResponse();
}
