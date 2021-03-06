#pragma once

#include <OpenHome/Types.h>
#include <OpenHome/Private/Standard.h>
#include <OpenHome/Private/Thread.h>
#include <OpenHome/Media/Pipeline/Msg.h>
#include <OpenHome/Media/MuteManager.h>

namespace OpenHome {
namespace Media {


class IVolumeRamper
{
public:
    static const TUint kMultiplierFull = 1u<<15;
    static const TUint kMultiplierZero = 0;
public:
    virtual void ApplyVolumeMultiplier(TUint aValue) = 0;
    virtual ~IVolumeRamper() {}
};

class VolumeRamper : public PipelineElement, public IPipelineElementUpstream, private INonCopyable
{
    static const TUint kSupportedMsgTypes;
public:
    VolumeRamper(MsgFactory& aMsgFactory, IPipelineElementUpstream& aUpstream);
    ~VolumeRamper();
    void SetVolumeRamper(IVolumeRamper& aVolumeRamper);
private: // from IPipelineElementUpstream
    Msg* Pull() override;
private: // IMsgProcessor
    Msg* ProcessMsg(MsgDrain* aMsg) override;
    Msg* ProcessMsg(MsgHalt* aMsg) override;
    Msg* ProcessMsg(MsgDecodedStream* aMsg) override;
    Msg* ProcessMsg(MsgAudioPcm* aMsg) override;
    Msg* ProcessMsg(MsgAudioDsd* aMsg) override;
    Msg* ProcessMsg(MsgSilence* aMsg) override;
private:
    void ProcessAudio(MsgAudioDecoded* aMsg);
    void Drained();
    void Halted();
    void CheckForHalted();
private:
    MsgFactory& iMsgFactory;
    IPipelineElementUpstream& iUpstream;
    Mutex iLock;
    IVolumeRamper* iVolumeRamper;
    MsgDrain* iMsgDrain;
    MsgHalt* iMsgHalt;
    TBool iHalting;
    TBool iHalted;
    TBool iEnabled;
};

} // namespace Media
} // namespace OpenHome

