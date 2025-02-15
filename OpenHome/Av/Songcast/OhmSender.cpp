#include "OhmSender.h"
#include <Generated/DvAvOpenhomeOrgSender2.h>
#include <OpenHome/Private/Ascii.h>
#include <OpenHome/Private/Converter.h>
#include <OpenHome/Private/Stream.h>
#include <OpenHome/Private/Env.h>
#include <OpenHome/Private/Arch.h>
#include <OpenHome/Private/Debug.h>
#include <OpenHome/Av/Debug.h>
#include <OpenHome/Av/Songcast/ZoneHandler.h>
#include <OpenHome/Av/Songcast/OhmTimestamp.h>
#include <OpenHome/Private/NetworkAdapterList.h>
#include <OpenHome/Net/Core/OhNet.h>
#include <OpenHome/Media/Pipeline/Msg.h>
#include <OpenHome/Optional.h>

#include <stdio.h>

namespace OpenHome {
class Environment;
namespace Av {

class ProviderSender : public Net::DvProviderAvOpenhomeOrgSender2
{
    static const TUint kMaxMetadataBytes = 4096;
    static const TUint kTimeoutAudioMs = 1000;
    static const Brn kStatusEnabled;
    static const Brn kStatusSending;
    static const Brn kStatusReady;
    static const Brn kStatusBlocked;
    static const Brn kStatusInactive;
    static const Brn kStatusDisabled;
public:
    ProviderSender(Environment& aEnv, Net::DvDevice& aDevice);
    ~ProviderSender();
    void SetMetadata(const Brx& aValue);
    void SetStatusEnabled(TBool aEnabled);
    void SetStatusBlocked(TBool aBlocked);
    void NotifyAudioPlaying(TBool aPlaying);
    void NotifyListeners(TBool aListeners);
    void NotifyBroadcastAllowed(TBool aAllowed);
private:
    void UpdateStatusEnabledLocked();
    void UpdateStatus2Locked();
    void TimerAudioExpired();
private: // from Net::DvProviderAvOpenhomeOrgSender1
    void PresentationUrl(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue) override;
    void Metadata(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue) override;
    void Audio(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseBool& aValue) override;
    void Status(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue) override;
    void Status2(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue) override;
    void Enabled(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseBool& aValue) override;
    void Attributes(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue) override;
private:
    mutable Mutex iLock;
    Bws<kMaxMetadataBytes> iMetadata;
    Timer* iTimerAudio;
    Brn iStatus;
    Brn iStatus2;
    TBool iEnabled;
    TBool iBlocked;
    TBool iPlaying;
    TBool iListeners;
    TBool iBroadcastAllowed;
};

} // namespace Av
} // namespace OpenHome

using namespace OpenHome;
using namespace OpenHome::Net;
using namespace OpenHome::Av;

// ProviderSender

const Brn ProviderSender::kStatusEnabled("Enabled");
const Brn ProviderSender::kStatusSending("Sending");
const Brn ProviderSender::kStatusReady("Ready");
const Brn ProviderSender::kStatusBlocked("Blocked");
const Brn ProviderSender::kStatusInactive("Inactive");
const Brn ProviderSender::kStatusDisabled("Disabled");

ProviderSender::ProviderSender(Environment& aEnv, Net::DvDevice& aDevice)
    : DvProviderAvOpenhomeOrgSender2(aDevice)
    , iLock("PSND")
    , iEnabled(false)
    , iBlocked(false)
    , iPlaying(false)
    , iListeners(false)
    , iBroadcastAllowed(true)
{
    iTimerAudio = new Timer(aEnv, MakeFunctor(*this, &ProviderSender::TimerAudioExpired), "ProviderSender");

    EnablePropertyPresentationUrl();
    EnablePropertyMetadata();
    EnablePropertyAudio();
    EnablePropertyStatus();
    EnablePropertyAttributes();
    EnablePropertyStatus2();
    EnablePropertyEnabled();

    EnableActionPresentationUrl();
    EnableActionMetadata();
    EnableActionAudio();
    EnableActionStatus();
    EnableActionStatus2();
    EnableActionEnabled();
    EnableActionAttributes();
    
    (void)SetPropertyPresentationUrl(Brx::Empty());
    (void)SetPropertyMetadata(Brx::Empty());
    (void)SetPropertyAudio(false);
    UpdateStatusEnabledLocked(); // no need for lock in ctor
    UpdateStatus2Locked(); // no need for lock in ctor
    (void)SetPropertyAttributes(Brx::Empty());
}

ProviderSender::~ProviderSender()
{
    delete iTimerAudio;
}

void ProviderSender::PresentationUrl(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue)
{
    Brhz value;
    GetPropertyPresentationUrl(value);
    aInvocation.StartResponse();
    aValue.Write(value);
    aValue.WriteFlush();
    aInvocation.EndResponse();
}

void ProviderSender::Metadata(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue)
{
    aInvocation.StartResponse();
    {
        AutoMutex a(iLock);
        aValue.Write(iMetadata);
    }
    aValue.WriteFlush();
    aInvocation.EndResponse();
}

void ProviderSender::Audio(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseBool& aValue)
{
    TBool value;
    GetPropertyAudio(value);
    aInvocation.StartResponse();
    aValue.Write(value);
    aInvocation.EndResponse();
}

void ProviderSender::Status(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue)
{
    aInvocation.StartResponse();
    {
        AutoMutex a(iLock);
        aValue.Write(iStatus);
    }
    aValue.WriteFlush();
    aInvocation.EndResponse();
}

void ProviderSender::Status2(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue)
{
    aInvocation.StartResponse();
    {
        AutoMutex _(iLock);
        aValue.Write(iStatus2);
    }
    aValue.WriteFlush();
    aInvocation.EndResponse();
}

void ProviderSender::Enabled(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseBool& aValue)
{
    TBool enabled;
    GetPropertyEnabled(enabled);
    aInvocation.StartResponse();
    aValue.Write(enabled);
    aInvocation.EndResponse();
}

void ProviderSender::Attributes(Net::IDvInvocation& aInvocation, Net::IDvInvocationResponseString& aValue)
{
    Brhz value;
    GetPropertyAttributes(value);
    aInvocation.StartResponse();
    aValue.Write(value);
    aValue.WriteFlush();
    aInvocation.EndResponse();
}

void ProviderSender::SetMetadata(const Brx& aValue)
{
    iLock.Wait();
    iMetadata.Replace(aValue);
    iLock.Signal();
    SetPropertyMetadata(aValue);
}

void ProviderSender::SetStatusEnabled(TBool aEnabled)
{
    AutoMutex a(iLock);
    iEnabled = aEnabled;
    UpdateStatusEnabledLocked();
    UpdateStatus2Locked();
}

void ProviderSender::SetStatusBlocked(TBool aBlocked)
{
    AutoMutex _(iLock);
    if (iBlocked == aBlocked) {
        return;
    }
    iBlocked = aBlocked;
    UpdateStatusEnabledLocked();
    UpdateStatus2Locked();
}

void ProviderSender::NotifyAudioPlaying(TBool aPlaying)
{
    {
        AutoMutex _(iLock);
        if (iPlaying != aPlaying) {
            (void)SetPropertyAudio(aPlaying);
            iPlaying = aPlaying;
            UpdateStatus2Locked();
        }
    }
    if (iPlaying) {
        iTimerAudio->FireIn(kTimeoutAudioMs);
    }
    else {
        iTimerAudio->Cancel();
    }
}

void ProviderSender::NotifyListeners(TBool aListeners)
{
    AutoMutex _(iLock);
    iListeners = aListeners;
    UpdateStatus2Locked();
}

void ProviderSender::NotifyBroadcastAllowed(TBool aAllowed)
{
    AutoMutex _(iLock);
    iBroadcastAllowed = aAllowed;
    UpdateStatus2Locked();
}

void ProviderSender::UpdateStatusEnabledLocked()
{
    TBool enabled = false;
    if (!iEnabled) {
        iStatus.Set(kStatusDisabled);
    }
    else if (iBlocked) {
        iStatus.Set(kStatusBlocked);
    }
    else {
        iStatus.Set(kStatusEnabled);
        enabled = true;
    }
    (void)SetPropertyStatus(iStatus);
    (void)SetPropertyEnabled(enabled);
}

void ProviderSender::UpdateStatus2Locked()
{
    if (!iEnabled) {
        iStatus2.Set(kStatusDisabled);
    }
    else if (iBlocked) {
        iStatus2.Set(kStatusBlocked);
    }
    else if (!iBroadcastAllowed) {
        iStatus2.Set(kStatusInactive);
    }
    else if (!iListeners || !iPlaying) {
        iStatus2.Set(kStatusReady);
    }
    else {
        iStatus2.Set(kStatusSending);
    }
    (void)SetPropertyStatus2(iStatus2);
}

void ProviderSender::TimerAudioExpired()
{
    NotifyAudioPlaying(false);
}


// OhmSenderDriver

OhmSenderDriver::OhmSenderDriver(Environment& aEnv, Optional<IOhmTimestamper> aTimestamper)
    : iMutex("OHMD")
    , iEnabled(false)
    , iActive(false)
    , iSend(false)
    , iFrame(0)
    , iSampleRate(0)
    , iTimestampMultiplier(0)
    , iBytesPerSample(0)
    , iLossless(false)
    , iSamplesTotal(0)
    , iSampleStart(0)
    , iLatencyMs(0)
    , iLatencyOhm(0)
    , iSocket(aEnv)
    , iFactory(110, 10, 10) // FIXME - rationale for msg counts??
    , iTimestamper(aTimestamper.Ptr())
    , iFirstFrame(true)
{
}

inline void OhmSenderDriver::UpdateLatencyOhm()
{
    iLatencyOhm = iLatencyMs * iTimestampMultiplier / 1000;
}

void OhmSenderDriver::SetAudioFormat(TUint aSampleRate, TUint aBitRate, TUint aChannels, TUint aBitDepth, TBool aLossless, const Brx& aCodecName, TUint64 aSampleStart)
{
    AutoMutex mutex(iMutex);

    iSampleRate = aSampleRate;
    iTimestampMultiplier = Media::Jiffies::SongcastTicksPerSecond(aSampleRate);
    UpdateLatencyOhm();
    iBytesPerSample = aChannels * aBitDepth / 8;
    iLossless = aLossless;
    iSampleStart = aSampleStart;

    iStreamHeader.Replace(Brx::Empty());
    OhmMsgAudio::GetStreamHeader(iStreamHeader, iSamplesTotal, aSampleRate, aBitRate, 0/*VolumeOffset*/, aBitDepth, aChannels, aCodecName);

    if (iTimestamper != nullptr) {
        // ignore return value below - false just implies iTimestamper->Timestamp will throw
        // ...and we already have to deal with this
        (void)iTimestamper->SetSampleRate(iSampleRate);
    }
}

OhmMsgAudio* OhmSenderDriver::CreateAudio()
{
    AutoMutex mutex(iMutex);
    if (iFifoHistory.SlotsUsed() == kMaxHistoryFrames) {
        iFifoHistory.Read()->RemoveRef();
    }
    return iFactory.CreateAudio();
}

void OhmSenderDriver::SendAudio(const TByte* aData, TUint aBytes, TBool aHalt)
{
    AutoMutex mutex(iMutex);

    TUint samples;
    if (iBytesPerSample == 0) {
        samples = 0;
    }
    else {
        samples = aBytes / iBytesPerSample;
    }
    if (!iSend) {
        iSampleStart += samples;
        return;
    }
    if (iSampleRate == 0 || (samples == 0 && !aHalt)) {
        // nothing to usefully communicate to receivers
        return;
    }
    if (iFifoHistory.SlotsUsed() == kMaxHistoryFrames) {
        iFifoHistory.Read()->RemoveRef();
    }

    TBool isTimeStamped = false;
    TUint timeStamp = 0;
    if (iFirstFrame) {
        iFirstFrame = false;
    }
    else if (iTimestamper != nullptr) {
        try {
            timeStamp = iTimestamper->Timestamp(iFrame - 1);
            isTimeStamped = true;
        }
        catch (OhmTimestampNotFound&) {}
    }

    OhmMsgAudio* msg = iFactory.CreateAudio(
        aHalt,
        iLossless,
        isTimeStamped,
        false, // resent
        samples,
        iFrame,
        timeStamp, // network timestamp
        iLatencyOhm,
        iSampleStart,
        iStreamHeader,
        Brn(aData, aBytes)
    );

    msg->Serialise();
    iFifoHistory.Write(msg);
    try {
        iSocket.Send(msg->SendableBuffer(), iEndpoint);
    }
    catch (NetworkError&) {
    }

    msg->SetResent(true);
    iSampleStart += samples;
    iFrame++;
}

void OhmSenderDriver::SendAudio(OhmMsgAudio* aMsg, TBool aHalt)
{
    AutoMutex mutex(iMutex);

    TUint samples;
    if (iBytesPerSample == 0) {
        samples = 0;
    }
    else {
        samples = aMsg->Audio().Bytes() / iBytesPerSample;
    }
    if (!iSend) {
        iSampleStart += samples;
        aMsg->RemoveRef();
        return;
    }
    if (iSampleRate == 0 || (samples == 0 && !aHalt)) {
        // nothing to usefully communicate to receivers
        aMsg->RemoveRef();
        return;
    }
    if (iFifoHistory.SlotsUsed() == kMaxHistoryFrames) {
        iFifoHistory.Read()->RemoveRef();
    }

    TBool isTimeStamped = false;
    TUint timeStamp = 0;
    if (iFirstFrame) {
        iFirstFrame = false;
    }
    else if (iTimestamper != nullptr) {
        try {
            timeStamp = iTimestamper->Timestamp(iFrame - 1);
            isTimeStamped = true;
        }
        catch (OhmTimestampNotFound&) {}
    }

    aMsg->ReinitialiseFields(
        aHalt,
        iLossless,
        isTimeStamped,
        false, // resent
        samples,
        iFrame,
        timeStamp, // network timestamp
        iLatencyOhm,
        iSampleStart,
        iStreamHeader
    );

    aMsg->Serialise();
    iFifoHistory.Write(aMsg);
    try {
        iSocket.Send(aMsg->SendableBuffer(), iEndpoint);
    }
    catch (NetworkError&) {
    }

    aMsg->SetResent(true);
    iSampleStart += samples;
    iFrame++;
}

void OhmSenderDriver::StreamInterrupted()
{
    AutoMutex mutex(iMutex);
    iFrame += 250; /* Any gap in audio frame numbers will cause receivers to retry.
                      A gap larger than their history (retry) buffer should force them to
                      skip retries and move straight to re-syncing instead. */
}

void OhmSenderDriver::SetEnabled(TBool aValue)
{
    AutoMutex mutex(iMutex);

    iEnabled = aValue;
    if (iSend) {
        if (!aValue) { // turning off
            ResetLocked();
        }
    }
    else {
        if (aValue && iActive) { // turning on
            iSend = true;
        }
    }
}

void OhmSenderDriver::SetActive(TBool aValue)
{
    AutoMutex mutex(iMutex);

    iActive = aValue;
    if (iSend) {
        if (!aValue) { // turning off
            ResetLocked();
        }
    }
    else {
        if (aValue && iEnabled) { // turning on
            iSend = true;
            if (iTimestamper != nullptr) {
                iTimestamper->Start(iEndpoint);
            }
        }
    }
}

void OhmSenderDriver::SetEndpoint(const Endpoint& aEndpoint, TIpAddress aAdapter)
{
    AutoMutex mutex(iMutex);
    if ((iTimestamper != nullptr) && iActive && !iEndpoint.Equals(aEndpoint)) {
        iTimestamper->Stop();
        iTimestamper->Start(aEndpoint);
    }
    iEndpoint.Replace(aEndpoint);
    iAdapter = aAdapter;
}

void OhmSenderDriver::SetTtl(TUint aValue)
{
    AutoMutex mutex(iMutex);
    iSocket.SetTtl(aValue);
}

void OhmSenderDriver::SetLatency(TUint aValue)
{
    AutoMutex mutex(iMutex);
    iLatencyMs = aValue;
    UpdateLatencyOhm();
}

void OhmSenderDriver::SetTrackPosition(TUint64 aSamplesTotal, TUint64 aSampleStart)
{
    AutoMutex mutex(iMutex);
    iSamplesTotal = aSamplesTotal;
    iSampleStart = aSampleStart;
}

void OhmSenderDriver::Resend(OhmMsgAudio& aMsg)
{
    try {
        aMsg.Serialise();
        iSocket.Send(aMsg.SendableBuffer(), iEndpoint);
    }
    catch (NetworkError&) {
    }
}

void OhmSenderDriver::Resend(const Brx& aFrames)
{
    AutoMutex mutex(iMutex);
    LOG(kSongcast, "RESEND");

    ReaderBuffer buffer(aFrames);
    ReaderBinary reader(buffer);
    TUint frames = aFrames.Bytes() / 4;
    TUint frame = reader.ReadUintBe(4);
    frames--;
    LOG(kSongcast, " %lu", (unsigned long)frame);
    TBool found = false;
    TUint count = iFifoHistory.SlotsUsed();
    for (TUint i = 0; i < count; i++) {
        OhmMsgAudio* msg = iFifoHistory.Read();
        if (!found) {
            TInt diff = frame - msg->Frame();
            if (diff == 0) {
                Resend(*msg);
                if (frames-- > 0) {
                    frame = reader.ReadUintBe(4);
                }
                else {
                    found = true;
                }
            }
            else {
                while (diff < 0) {
                    if (frames-- > 0) {
                        frame = reader.ReadUintBe(4);
                    }
                    else {
                        found = true;
                        break;
                    }
                    diff = frame - msg->Frame();
                    if (diff == 0) {
                        Resend(*msg);
                        if (frames-- > 0) {
                            frame = reader.ReadUintBe(4);
                        }
                        else {
                            found = true;
                        }
                        break;
                    }
                }
            }
        }

        iFifoHistory.Write(msg);
    }
    LOG(kSongcast, "\n");
}

void OhmSenderDriver::ResetLocked()
{
    iSend = false;
    iFrame = 0;
    iFirstFrame = true;
    if (iTimestamper != nullptr) {
        iTimestamper->Stop();
    }
    const TUint count = iFifoHistory.SlotsUsed();
    for (TUint i = 0; i < count; i++) {
        iFifoHistory.Read()->RemoveRef();
    }
}


// OhmSender

OhmSender::OhmSender(Environment& aEnv, Net::DvDeviceStandard& aDevice, IOhmSenderDriver& aDriver,
                     ZoneHandler& aZoneHandler, TUint aThreadPriority, const Brx& aName,
                     TUint aChannel, TUint aLatency, TBool aMulticast)
    : iEnv(aEnv)
    , iDevice(aDevice)
    , iDriver(aDriver)
    , iZoneHandler(&aZoneHandler)
    , iName(aName)
    , iChannel(aChannel)
    , iInterface(kIpAddressV4AllAdapters )
    , iLatency(aLatency)
    , iMulticast(aMulticast)
    , iEnabled(false)
    , iUnicastOverride(false)
    , iSocketOhm(aEnv)
    , iRxBuffer(iSocketOhm)
    , iMutexStartStop("OHMS")
    , iMutexActive("OHMA")
    , iNetworkDeactivated("OHDN", 0)
    , iZoneDeactivated("OHDZ", 0)
    , iStarted(false)
    , iActive(false)
    , iAliveJoined(false)
    , iAliveBlocked(false)
    , iSequenceTrack(0)
    , iSequenceMetatext(0)
    , iClientControllingTrackMetadata(false)
{
    iProvider = new ProviderSender(aEnv, iDevice);
    CurrentSubnetChanged(); // roundabout way of initialising iInterface
 
    iDriver.SetTtl(kTtl);
    iDriver.SetLatency(iLatency);
    LOG(kSongcast, "OHM SENDER DRIVER LATENCY %d\n", iLatency);
       
    iTimerAliveJoin = new Timer(aEnv, MakeFunctor(*this, &OhmSender::TimerAliveJoinExpired), "OhmSenderAliveJoin");
    iTimerAliveAudio = new Timer(aEnv, MakeFunctor(*this, &OhmSender::TimerAliveAudioExpired), "OhmSenderAliveAudio");
    iTimerExpiry = new Timer(aEnv, MakeFunctor(*this, &OhmSender::TimerExpiryExpired), "OhmSenderExpiry");

    iThreadMulticast = new ThreadFunctor("OhmSenderM", MakeFunctor(*this, &OhmSender::RunMulticast), aThreadPriority, kThreadStackBytesNetwork);
    iThreadMulticast->Start();
    
    iThreadUnicast = new ThreadFunctor("OhmSenderU", MakeFunctor(*this, &OhmSender::RunUnicast), aThreadPriority, kThreadStackBytesNetwork);
    iThreadUnicast->Start();
    
    UpdateChannel();
    iNacnId = iEnv.NetworkAdapterList().AddCurrentChangeListener(MakeFunctor(*this, &OhmSender::CurrentSubnetChanged), "OhmSender", false);
    UpdateMetadata();
}

OhmSender::~OhmSender()
{
    LOG(kSongcast, "OhmSender::~OhmSender\n");
    iEnv.NetworkAdapterList().RemoveCurrentChangeListener(iNacnId);
    iEnabled = false;
    iDriver.SetEnabled(false);
    LOG(kSongcast, "OhmSender::~OhmSender disabled driver\n");

    {
        AutoMutex mutex(iMutexStartStop);
        Stop();
    }

    LOG(kSongcast, "OhmSender::~OhmSender stopped\n");
    delete iThreadUnicast;
    LOG(kSongcast, "OhmSender::~OhmSender deleted unicast thread\n");
    delete iThreadMulticast;
    LOG(kSongcast, "OhmSender::~OhmSender deleted multicast thread\n");
    delete iTimerAliveJoin;
    delete iTimerAliveAudio;
    delete iTimerExpiry;
    LOG(kSongcast, "OhmSender::~OhmSender deleted timers\n");
    delete iProvider;
    LOG(kSongcast, "OhmSender::~OhmSender deleted provider\n");
}

void OhmSender::SetName(const Brx& aValue)
{
    AutoMutex mutex(iMutexStartStop);
    
    if (iName != aValue) {
        iName.Replace(aValue);
        UpdateMetadata();
    }
}

void OhmSender::SetImageUri(const Brx& aUri)
{
    AutoMutex _(iMutexStartStop);
    if (aUri != iImageUri) {
        iImageUri.Replace(aUri);
        UpdateMetadata();
    }
}

void OhmSender::SetChannel(TUint aValue)
{
    AutoMutex mutex(iMutexStartStop);

    if (iChannel != aValue) {
        if (iMulticast) {
            if (iStarted) {
                Stop();
                iChannel = aValue;
                UpdateChannel();
                Start();
            }
            else {
                iChannel = aValue;
                UpdateChannel();
                UpdateUri();
            }
        }
        else {
            iChannel = aValue;
            UpdateChannel();
        }
    }
}

void OhmSender::SetLatency(TUint aValue)
{
    AutoMutex mutex(iMutexStartStop);
    
    if (iLatency != aValue) {
        if (iStarted) {
            Stop();
            iLatency = aValue;
            iDriver.SetLatency(iLatency);
            LOG(kSongcast, "OHM SENDER DRIVER LATENCY %d\n", iLatency);
            Start();
        }
        else {
            iLatency = aValue;
            iDriver.SetLatency(iLatency);
            LOG(kSongcast, "OHM SENDER DRIVER LATENCY %d\n", iLatency);
        }
    }
}

void OhmSender::SetMulticast(TBool aValue)
{
    AutoMutex mutex(iMutexStartStop);

    if (iMulticast != aValue) {
        if (iStarted) {
            Stop();
            iMulticast = aValue;
            UpdateMetadata();
            Start();
        }
        else {
            iMulticast = aValue;
            UpdateMetadata();
        }
    }
}

void OhmSender::SetEnabled(TBool aValue)
{
    AutoMutex mutex(iMutexStartStop);

    if (iEnabled != aValue) {
        iEnabled = aValue;

        iDriver.SetEnabled(iEnabled);

        LOG(kSongcast, "OHM SENDER DRIVER ENABLED %d\n", aValue);
    
        if (iEnabled) {
            iProvider->SetStatusEnabled(true);
            Start();
        }
        else {
            Stop();
            iProvider->SetStatusEnabled(false);
        }
    }
}

void OhmSender::CurrentSubnetChanged()
{
    AutoMutex mutex(iMutexStartStop);

    static const TChar* kNifCookie = "OhmSender";
    NetworkAdapter* current = iEnv.NetworkAdapterList().CurrentAdapter(kNifCookie).Ptr();
    const TIpAddress addr = (current ? current->Address() : kIpAddressV4AllAdapters );
    if (current != nullptr) {
        current->RemoveRef(kNifCookie);
    }
    if (!TIpAddressUtils::Equals(iInterface, addr)) {
        if (iStarted) {
            Stop();
            iInterface = addr;
            // recreate server before UpdateMetadata() as that function requires the server port
            UpdateMetadata();
            Start();
        }
        else {
            iInterface = addr;
        }
    }
}

void OhmSender::Start()
{
    // always called with the start/stop mutex locked
    try {
        if (!iStarted) {
            if (iMulticast && !iUnicastOverride) {
                iSocketOhm.OpenMulticast(iInterface, kTtl, iMulticastEndpoint);
                iTargetEndpoint.Replace(iMulticastEndpoint);
                iTargetInterface = iInterface;
                iThreadMulticast->Signal();
            }
            else {
                iSocketOhm.OpenUnicast(iInterface, kTtl);
                if (Debug::TestLevel(Debug::kSongcast)) {
                    Endpoint::EndpointBuf buf;
                    iSocketOhm.This().AppendEndpoint(buf);
                    Log::Print("OHU sender running on %s\n", buf.Ptr());
                }
                iTargetInterface = iInterface;
                iThreadUnicast->Signal();
            }
            iStarted = true;
            UpdateUri();
        }
    }
    catch (NetworkError&) {
        LOG_ERROR(kSongcast, "OhmSender::Start() failed to open iSocketOhm\n");
    }
}

void OhmSender::Stop()
{
    // always called with the start/stop mutex locked
    if (iStarted) {
        LOG(kSongcast, "STOP INTERRUPT\n");
        iSocketOhm.ReadInterrupt();
        LOG(kSongcast, "STOP WAIT\n");
        iNetworkDeactivated.Wait();
        LOG(kSongcast, "STOP CLOSE\n");
        iSocketOhm.Close();
        iStarted = false;
        LOG(kSongcast, "STOP UPDATE\n");
        UpdateUri();
        LOG(kSongcast, "STOP DONE\n");
    }
}

void OhmSender::SetTrack(const Brx& aUri, const Brx& aMetadata)
{
    AutoMutex mutex(iMutexActive);

    iClientControllingTrackMetadata = true;
    iSequenceTrack++;
    iSequenceMetatext = 0;
    iTrackUri.Replace(aUri);
    iTrackMetadata.Replace(aMetadata);
    iTrackMetatext.Replace(Brx::Empty());
    
    if (iActive) {
        SendTrack();
    }
}

void OhmSender::SetTrackPosition(TUint64 aSamplesTotal, TUint64 aSampleStart)
{
    AutoMutex mutex(iMutexActive);
    iDriver.SetTrackPosition(aSamplesTotal, aSampleStart);
}

void OhmSender::SetMetatext(const Brx& aValue)
{
    AutoMutex mutex(iMutexActive);

    iSequenceMetatext++;
    iTrackMetatext.Replace(aValue);
    
    if (iActive) {
        SendMetatext();
    }
}

void OhmSender::StreamInterrupted()
{
    iDriver.StreamInterrupted();
}

void OhmSender::SetPreset(TUint aValue)
{
    iZoneHandler->SetPreset(aValue);
}

void OhmSender::NotifyAudioPlaying(TBool aPlaying)
{
    iProvider->NotifyAudioPlaying(aPlaying);
}

void OhmSender::NotifyBroadcastAllowed(TBool aAllowed)
{
    iProvider->NotifyBroadcastAllowed(aAllowed);
}

void OhmSender::EnableUnicastOverride(TBool aEnable)
{
    AutoMutex _(iMutexStartStop);
    iUnicastOverride = aEnable;
    if (iEnabled) {
        Stop();
        Start();
    }
}

//  This runs a little state machine where the current state is reflected by:
//
//  iAliveJoined: Indicates that someone is listening to us (we received a join recently)
//  iAliveBlocked: Indicates that someone else is sending on our channel (we received audio recently)
//
//  iActive, when true, causes pipeline audio to be sent out over the network
//
//  The state machine ensures that iActive is only true when iAliveJoined is true and iAliveBlocked is false
//

void OhmSender::RunMulticast()
{
    for (;;) {
        LOG(kSongcast, "OhmSender::RunMulticast wait\n");
        iThreadMulticast->Wait();
        LOG(kSongcast, "OhmSender::RunMulticast go\n");
        iDriver.SetEndpoint(iTargetEndpoint, iTargetInterface);
        LOG(kSongcast, "OHM SENDER DRIVER ENDPOINT %x:%d\n", iTargetEndpoint.Address(), iTargetEndpoint.Port());
        try {
            for (;;) {
                try {
                    OhmHeader header;
                    header.Internalise(iRxBuffer);

                    if (header.MsgType() <= OhmHeader::kMsgTypeListen) {
                        LOG(kSongcast, "OhmSender::RunMulticast join/listen received\n");
                        
                        AutoMutex mutex(iMutexActive);
                        
                        if (header.MsgType() == OhmHeader::kMsgTypeJoin) {
                            SendTrack();
                            SendMetatext();
                        }
                        if (!iActive) {
                            iActive = true;
                            iDriver.SetActive(true);
                            LOG(kSongcast, "OHM SENDER DRIVER ACTIVE %d\n", iActive);
                        }
                        iAliveJoined = true;
                        iTimerAliveJoin->FireIn(kTimerAliveJoinTimeoutMs);
                        iProvider->NotifyListeners(true);
                    }
                    else if (header.MsgType() == OhmHeader::kMsgTypeResend) {
                        LOG(kSongcast, "OhmSender::RunMulticast resend received\n");

                        OhmHeaderResend headerResend;
                        headerResend.Internalise(iRxBuffer, header);

                        TUint frames = headerResend.FramesCount();
                        if (frames > 0) {
                            iDriver.Resend(iRxBuffer.Read(frames * 4));
                        }
                    }
                    else if (header.MsgType() == OhmHeader::kMsgTypeAudio) {
                        // Check sender not us
                        Endpoint sender = iSocketOhm.Sender();
                        if (!TIpAddressUtils::Equals(sender.Address(), iInterface)) {
                            LOG(kSongcast, "OhmSender::RunMulticast audio received\n");
                            // The following randomisation prevents two senders from both sending,
                            // both seeing each other's audio, both backing off for the same amount of time,
                            // then both sending again, then both seeing each other's audio again,
                            // then both backing off for the same amount of time ...
                            TUint delay = iEnv.Random(kTimerAliveAudioTimeoutMs, kTimerAliveAudioTimeoutMs >> 1);
                            { // scope for AutoMutex
                                AutoMutex mutex(iMutexActive);
                                if (iActive) {
                                    iActive = false;
                                    iDriver.SetActive(false);
                                    LOG(kSongcast, "OHM SENDER DRIVER ACTIVE %d\n", iActive);
                                } 
                                iAliveBlocked = true;
                                iProvider->SetStatusBlocked(iAliveBlocked);
                                iTimerAliveAudio->FireIn(delay);
                            }
                            LOG(kSongcast, "OhmSender::RunMulticast blocked\n");
                        }
                    }
                }
                catch (OhmError&) {
                    LOG_ERROR(kSongcast, "OhmSender::RunMulticast OhmError\n");
                }

                iRxBuffer.ReadFlush();
            }
        }
        catch (ReaderError&) {
            LOG(kSongcast, "OhmSender::RunMulticast reader error\n");
        }

        iRxBuffer.ReadFlush();
        iTimerAliveJoin->Cancel();
        iTimerAliveAudio->Cancel();

        { // scope for AutoMutex
            AutoMutex mutex(iMutexActive);
            if (iActive) {
                iActive = false;
                iDriver.SetActive(false);
                LOG(kSongcast, "OHM SENDER DRIVER ACTIVE %d\n", iActive);
            } 
            iAliveJoined = false;
            iAliveBlocked = false;
            iProvider->NotifyListeners(false);
            iProvider->SetStatusBlocked(iAliveBlocked);
        }

        iNetworkDeactivated.Signal();
        LOG(kSongcast, "OhmSender::RunMulticast stop\n");
    }
}

void OhmSender::RunUnicast()
{
    for (;;) {
        LOG(kSongcast, "OhmSender::RunUnicast wait\n");
        iThreadUnicast->Wait();
        LOG(kSongcast, "OhmSender::RunUnicast go\n");
        try {
            for (;;) {
                // wait for first receiver to join
                // if we receive a listen, it's probably from a temporarily physically disconnected receiver
                // so accept them as well
                for (;;) {
                    OhmHeader header;
                    try {
                        header.Internalise(iRxBuffer);
                        
                        if (header.MsgType() <= OhmHeader::kMsgTypeListen) {
                            LOG(kSongcast, "OhmSender::RunUnicast ready/join or listen (%u)\n", header.MsgType());
                            break;                        
                        }
                    }
                    catch (OhmError&) {
                        LOG_ERROR(kSongcast, "OhmSender: waiting for JOIN, caught OhmError, msgType=%u\n", header.MsgType());
                    }
                    iRxBuffer.ReadFlush();  
                }
    
                iRxBuffer.ReadFlush();
                iTargetEndpoint.Replace(iSocketOhm.Sender());
                iDriver.SetEndpoint(iTargetEndpoint, iTargetInterface);
                LOG(kSongcast, "OHM SENDER DRIVER ENDPOINT %x:%d\n", iTargetEndpoint.Address(), iTargetEndpoint.Port());
                SendTrack();
                SendMetatext();
                iSlaveCount = 0;
                { // scope for AutoMutex
                    AutoMutex mutex(iMutexActive);
                    iActive = true;
                    iAliveJoined = true;
                    iDriver.SetActive(true);
                    iProvider->NotifyListeners(true);
                    LOG(kSongcast, "OHM SENDER DRIVER ACTIVE %d\n", true);
                }
                iTimerExpiry->FireIn(kTimerExpiryTimeoutMs);
                
                for (;;) {
                    try {
                        OhmHeader header;
                        header.Internalise(iRxBuffer);
                        
                        if (header.MsgType() == OhmHeader::kMsgTypeJoin) {
                            Endpoint sender(iSocketOhm.Sender());
                            if (Debug::TestLevel(Debug::kSongcast)) {
                                Endpoint::EndpointBuf endptBuf;
                                sender.AppendEndpoint(endptBuf);
                                LOG(kSongcast, "OhmSender::RunUnicast sending/join from %s\n", endptBuf.Ptr());
                            }
                            if (sender.Equals(iTargetEndpoint)) {
                                iTimerExpiry->FireIn(kTimerExpiryTimeoutMs);
                            }
                            else {
                                TUint slave = FindSlave(sender);
                                if (slave < iSlaveCount) {
                                    iSlaveExpiry[slave] = Time::Now(iEnv) + kTimerExpiryTimeoutMs;
                                }
                                else {
                                    if (slave >= kMaxSlaveCount) {
                                        LOG(kSongcast, "OhmSender::RunUnicast ignoring join request - already have %u slaves\n", slave-1);
                                    }
                                    else {
                                        iSlaveList[slave].Replace(sender);
                                        iSlaveExpiry[slave] = Time::Now(iEnv) + kTimerExpiryTimeoutMs;
                                        iSlaveCount++;
                                        if (Debug::TestLevel(Debug::kSongcast)) {
                                            Endpoint::EndpointBuf buf;
                                            sender.AppendEndpoint(buf);
                                            LOG(kSongcast, "OhmSender::RunUnicast new slave: %s (#%u)\n", buf.Ptr(), iSlaveCount);
                                        }
                                        AutoMutex mutex(iMutexActive);
                                        SendListen(sender);
                                    }
                                }
                            }

                            AutoMutex mutex(iMutexActive);
                            SendSlaveList();
                            SendTrack();
                            SendMetatext();
                        }
                        else if (header.MsgType() == OhmHeader::kMsgTypeListen) {
                            Endpoint sender(iSocketOhm.Sender());
                            if (sender.Equals(iTargetEndpoint)) {
                                iTimerExpiry->FireIn(kTimerExpiryTimeoutMs);
                                if (CheckSlaveExpiry()) {
                                    AutoMutex mutex(iMutexActive);
                                    SendSlaveList();
                                }
                            }
                            else {
                                TUint slave = FindSlave(sender);
                                if (slave < iSlaveCount) {
                                    iSlaveExpiry[slave] = Time::Now(iEnv) + kTimerExpiryTimeoutMs;
                                }
                                else {
                                    // unknown slave, probably temporarily physically disconnected receiver
                                    if (slave < kMaxSlaveCount) {
                                        iSlaveList[slave].Replace(sender);
                                        iSlaveExpiry[slave] = Time::Now(iEnv) + kTimerExpiryTimeoutMs;
                                        iSlaveCount++;

                                        if (Debug::TestLevel(Debug::kSongcast)) {
                                            Endpoint::EndpointBuf endptBuf;
                                            sender.AppendEndpoint(endptBuf);
                                            LOG(kSongcast, "OhmSender::RunUnicast new slave: %s (#%u)\n", endptBuf.Ptr(), iSlaveCount);
                                        }

                                        AutoMutex mutex(iMutexActive);
                                        SendListen(sender);
                                        SendSlaveList();
                                        SendTrack();
                                        SendMetatext();
                                    }
                                }
                            }
                        }
                        else if (header.MsgType() == OhmHeader::kMsgTypeLeave) {
                            Endpoint sender(iSocketOhm.Sender());
                            Endpoint::EndpointBuf endptBuf;
                            sender.AppendEndpoint(endptBuf);
                            LOG(kSongcast, "OhmSender::RunUnicast LEAVE from %s\n", endptBuf.Ptr());
                            if (sender.Equals(iTargetEndpoint) || sender.Equals(iSocketOhm.This())) {
                                iTimerExpiry->Cancel();
                                if (iSlaveCount == 0) {
                                    break;
                                }
                                else {
                                    AutoMutex mutex(iMutexActive);
                                    iTargetEndpoint.Replace(iSlaveList[--iSlaveCount]);
                                    iTimerExpiry->FireAt(iSlaveExpiry[iSlaveCount]);
                                    if (iSlaveCount > 0) {
                                        SendSlaveList();
                                    }
                                    iDriver.SetEndpoint(iTargetEndpoint, iTargetInterface);
                                    LOG(kSongcast, "OHM SENDER DRIVER ENDPOINT %x:%d\n", iTargetEndpoint.Address(), iTargetEndpoint.Port());
                                }
                            }
                            else {
                                TUint slave = FindSlave(sender);
                                if (slave < iSlaveCount) {
                                    RemoveSlave(slave);
                                    AutoMutex mutex(iMutexActive);
                                    SendLeave(sender);
                                    SendSlaveList();
                                }
                            }
                        }
                        else if (header.MsgType() == OhmHeader::kMsgTypeResend) {
                            LOG(kSongcast, "OhmSender::RunUnicast resend received\n");
                            OhmHeaderResend headerResend;
                            headerResend.Internalise(iRxBuffer, header);
                            TUint frames = headerResend.FramesCount();
                            if (frames > 0) {
                                iDriver.Resend(iRxBuffer.Read(frames * 4));
                            }
                        }
                    }
                    catch (OhmError&) {
                        LOG_ERROR(kSongcast, "OhmSender::RunUnicast OhmError\n");
                    }
                    
                    iRxBuffer.ReadFlush();
                }

                iRxBuffer.ReadFlush();
                AutoMutex mutex(iMutexActive);
                iActive = false;
                iAliveJoined = false;               
                iDriver.SetActive(false);
                iProvider->NotifyListeners(false);
                LOG(kSongcast, "OHM SENDER DRIVER ACTIVE %d\n", iActive);
            }
        }
        catch (ReaderError&) {
            LOG(kSongcast, "OhmSender::RunUnicast reader error\n");
        }

        iRxBuffer.ReadFlush();
        iTimerExpiry->Cancel();

        { // scope for AutoMutex
            AutoMutex mutex(iMutexActive);
            if (iActive) {
                iActive = false;
                iDriver.SetActive(false);
                LOG(kSongcast, "OHM SENDER DRIVER ACTIVE %d\n", iActive);
            } 
            iAliveJoined = false;
            iAliveBlocked = false;
            iProvider->NotifyListeners(false);
            iProvider->SetStatusBlocked(iAliveBlocked);
        }

        iNetworkDeactivated.Signal();
        LOG(kSongcast, "OhmSender::RunUnicast stop\n");
    }
}

void OhmSender::TimerAliveJoinExpired()
{
    LOG(kSongcast, "AliveJoin timer expired\n");
    AutoMutex mutex(iMutexActive);
    iActive = false;
    iAliveJoined = false;
    iProvider->NotifyListeners(false);
}

void OhmSender::TimerAliveAudioExpired()
{
    { // scope for AutoMutex
        AutoMutex mutex(iMutexActive);
        TBool joined = iAliveBlocked;
        iActive = joined;
        iAliveBlocked = false;
        iProvider->SetStatusBlocked(iAliveBlocked);
    }

    iProvider->SetStatusEnabled(true);
}

void OhmSender::TimerExpiryExpired()
{
    // Send a Leave to ourselves, which is interpreted as a Leave from the receiver
    LOG(kSongcast, "OhmSender::TimerExpiryExpired TIMEOUT\n");
    Bws<OhmHeader::kHeaderBytes> buffer;
    WriterBuffer writer(buffer);
    OhmHeader leave(OhmHeader::kMsgTypeLeave, 0);
    leave.Externalise(writer);
    AutoMutex mutex(iMutexActive);
    try {
        iSocketOhm.Send(buffer, iSocketOhm.This());
    }
    catch (NetworkError&) {
    }
}

void OhmSender::UpdateChannel()
{
    TIpAddress address = kIpAddressV4AllAdapters;
    address.iV4 = Arch::BigEndian4((iChannel & 0xffff) | 0xeffd0000); // 239.253.x.x
    iMulticastEndpoint.SetAddress(address);
    iMulticastEndpoint.SetPort(Ohm::kPort);
}

void OhmSender::UpdateUri()
{
    // access to iUri is protected by iStartStopMutex which is locked in all callers
    if (iStarted) {
        if (iMulticast && !iUnicastOverride) {
            iUri.Replace("ohm://");
            iMulticastEndpoint.AppendEndpoint(iUri);
        }
        else {
            iUri.Replace("ohu://");
            iSocketOhm.This().AppendEndpoint(iUri);
        }
    }
    else {
        iUri.Replace("ohu://0.0.0.0:0");
    }

    iZoneHandler->SetHomeSenderUri(iUri);
}

void OhmSender::UpdateMetadata()
{
    iSenderMetadata.Replace("<DIDL-Lite xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:upnp=\"urn:schemas-upnp-org:metadata-1-0/upnp/\" xmlns=\"urn:schemas-upnp-org:metadata-1-0/DIDL-Lite/\">");
    iSenderMetadata.Append("<item id=\"0\" restricted=\"True\">");
    iSenderMetadata.Append("<dc:title>");
    WriterBuffer writer(iSenderMetadata);
    Converter::ToXmlEscaped(writer, iName);
    iSenderMetadata.Append("</dc:title>");
    
    if (iMulticast) {
        iSenderMetadata.Append("<res protocolInfo=\"ohz:*:*:m\">");
    }
    else {
        iSenderMetadata.Append("<res protocolInfo=\"ohz:*:*:u\">");
    }

    iSenderUri.Replace(Brn("ohz://239.255.255.250:51972/"), iDevice.Udn());
    iSenderMetadata.Append(iSenderUri.AbsoluteUri());
    iSenderMetadata.Append("</res>");
    
    if (iImageUri.Bytes() > 0) {
        iSenderMetadata.Append("<upnp:albumArtURI>");
        iSenderMetadata.Append(iImageUri);
        iSenderMetadata.Append("</upnp:albumArtURI>");
    }
        
    iSenderMetadata.Append("<upnp:class>object.item.audioItem</upnp:class>");
    iSenderMetadata.Append("</item>");
    iSenderMetadata.Append("</DIDL-Lite>");

    if (!iClientControllingTrackMetadata) {
        AutoMutex mutex(iMutexActive);
        iTrackMetadata.Replace(iSenderMetadata);
        iSequenceTrack++;
        iSequenceMetatext = 0;
        if (iActive) {
            SendTrack();
        }
    }

    iProvider->SetMetadata(iSenderMetadata);
    iZoneHandler->SetSenderMetadata(iSenderMetadata);
}

void OhmSender::Send()
{
    try {
        iSocketOhm.Send(iTxBuffer, iTargetEndpoint);
    }
    catch (NetworkError&) {
    }
}

void OhmSender::SendTrack()
{
    // called with alive mutex locked;
    OhmHeaderTrack headerTrack(iSequenceTrack, iTrackUri, iTrackMetadata);
    OhmHeader header(OhmHeader::kMsgTypeTrack, headerTrack.MsgBytes());
    WriterBuffer writer(iTxBuffer);
    writer.Flush();
    header.Externalise(writer);
    headerTrack.Externalise(writer);
    writer.Write(iTrackUri);
    writer.Write(iTrackMetadata);

    Send();
}

void OhmSender::SendMetatext()
{
    // called with alive mutex locked;
    OhmHeaderMetatext headerMetatext(iSequenceMetatext, iTrackMetatext);
    OhmHeader header(OhmHeader::kMsgTypeMetatext, headerMetatext.MsgBytes());
    WriterBuffer writer(iTxBuffer);
    writer.Flush();
    header.Externalise(writer);
    headerMetatext.Externalise(writer);
    writer.Write(iTrackMetatext);
    
    Send();
}

void OhmSender::SendSlaveList()
{
    // called with alive mutex locked;
    OhmHeaderSlave headerSlave(iSlaveCount);
    OhmHeader header(OhmHeader::kMsgTypeSlave, headerSlave.MsgBytes());
    WriterBuffer writer(iTxBuffer);
    writer.Flush();
    header.Externalise(writer);
    headerSlave.Externalise(writer);
    for (TUint i = 0; i < iSlaveCount; i++) {
        iSlaveList[i].Externalise(writer);
    }
    Send();
}

void OhmSender::SendListen(const Endpoint& aEndpoint)
{
    // Listen message is ignored by slaves, but this is sent to populate my arp tables
    // in case the slave needs to be quickly changed to master receiver.
    // Called with alive mutex locked;
    OhmHeader header(OhmHeader::kMsgTypeListen, 0);
    WriterBuffer writer(iTxBuffer);
    writer.Flush();
    header.Externalise(writer);
    try {
        iSocketOhm.Send(iTxBuffer, aEndpoint);
    }
    catch (NetworkError&) {
    }
}

void OhmSender::SendLeave(const Endpoint& aEndpoint)
{
    // Leave message is sent to acknowledge a Leave sent from a receiver or slave
    Endpoint::EndpointBuf buf;
    aEndpoint.AppendEndpoint(buf);
    LOG(kSongcast, "OhmSender::SendLeave to %s\n", buf.Ptr());

    OhmHeader header(OhmHeader::kMsgTypeLeave, 0);
    WriterBuffer writer(iTxBuffer);
    writer.Flush();
    header.Externalise(writer);
    try {
        iSocketOhm.Send(iTxBuffer, aEndpoint);
    }
    catch (NetworkError&) {
    }
}

TBool OhmSender::CheckSlaveExpiry()
{
    TBool changed = false;
    for (TUint i = 0; i < iSlaveCount;) {
        if (Time::IsInPastOrNow(iEnv, iSlaveExpiry[i])) {
            RemoveSlave(i);
            changed = true;
            continue;
        }
        i++;
    }
    
    return changed;
}

void OhmSender::RemoveSlave(TUint aIndex)
{
    iSlaveCount--;
    for (TUint i = aIndex; i < iSlaveCount; i++) {
        iSlaveList[i].Replace(iSlaveList[i + 1]);
        iSlaveExpiry[i] = iSlaveExpiry[i + 1];
    }
}

// Returns index of supplied endpoint, or index of empty slot if not found
// distinguish between the two by comparing returned value with iSlaveCount
  
TUint OhmSender::FindSlave(const Endpoint& aEndpoint)
{
    for (TUint i = 0; i < iSlaveCount; i++) {
        if (aEndpoint.Equals(iSlaveList[i])) {
            return i;
        }
    }
    return iSlaveCount;
}
