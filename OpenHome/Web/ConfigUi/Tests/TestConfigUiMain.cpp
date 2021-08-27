#include <OpenHome/Private/TestFramework.h>
#include <OpenHome/Private/Network.h>
#include <OpenHome/Net/Private/CpiStack.h>
#include <OpenHome/Net/Private/DviStack.h>


extern void TestConfigUi(OpenHome::Net::CpStack& aCpStack, OpenHome::Net::DvStack& aDvStack);

void OpenHome::TestFramework::Runner::Main(TInt /*aArgc*/, TChar* /*aArgv*/[], Net::InitialisationParams* aInitParams)
{
    aInitParams->SetUseLoopbackNetworkAdapter();
    aInitParams->SetDvEnableBonjour("TestConfigUi", false);
    Net::Library* lib = new Net::Library(aInitParams);

    // Set a subnet.
    std::vector<NetworkAdapter*>* subnetList = lib->CreateSubnetList();
    ASSERT(subnetList->size() > 0);
    Log::Print ("adapter list:\n");
    for (unsigned i=0; i<subnetList->size(); ++i) {
        uint32_t addr = (*subnetList)[i]->Address().iV4;
        Log::Print ("  %d: %d.%d.%d.%d\n", i, addr&0xff, (addr>>8)&0xff, (addr>>16)&0xff, (addr>>24)&0xff);
    }
    TIpAddress subnet = (*subnetList)[0]->Subnet();
    Net::Library::DestroySubnetList(subnetList);
    lib->SetCurrentSubnet(subnet);
    uint32_t print_subnet = subnet.iV4;
    Log::Print("using print_subnet %d.%d.%d.%d\n", print_subnet&0xff, (print_subnet>>8)&0xff, (print_subnet>>16)&0xff, (print_subnet>>24)&0xff);

    Net::CpStack* cpStack;
    Net::DvStack* dvStack;
    lib->StartCombined(subnet, cpStack, dvStack);
    TestConfigUi(*cpStack, *dvStack);
    delete lib;
}
