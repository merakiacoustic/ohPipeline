#pragma once

#include <OpenHome/Types.h>
#include <OpenHome/Buffer.h>
#include <OpenHome/Private/Thread.h>
#include <OpenHome/Private/Fifo.h>
#include <OpenHome/Media/Pipeline/Msg.h> // for kTrackMetaDataMaxBytes
#include <OpenHome/Av/Songcast/Ohm.h>

#include <atomic>

namespace OpenHome {
namespace Av {

class OhmMsgAudio;
class OhmMsgTrack;
class OhmMsgMetatext;
class OhmMsgFactory;

class IOhmMsgProcessor
{
public:
    virtual ~IOhmMsgProcessor() {}
    virtual void Process(OhmMsgAudio& aMsg) = 0;
    virtual void Process(OhmMsgTrack& aMsg) = 0;
    virtual void Process(OhmMsgMetatext& aMsg) = 0;
};

class OhmMsg
{
public:
    virtual ~OhmMsg();
    void AddRef();
    void RemoveRef();
    virtual void Process(IOhmMsgProcessor& aProcessor) = 0;
    virtual void Externalise(IWriter& aWriter) = 0;
protected:
    OhmMsg(OhmMsgFactory& aFactory);
    void Create();
private:
    OhmMsgFactory* iFactory;
    std::atomic<TUint> iRefCount;
};

class OhmMsgTimestamped : public OhmMsg
{
public:
    virtual ~OhmMsgTimestamped();
    TBool RxTimestamped() const;
    TUint RxTimestamp() const;
    void SetRxTimestamp(TUint aValue);

protected:
    OhmMsgTimestamped(OhmMsgFactory& aFactory);
    void Create();

private:
    TBool iRxTimestamped;
    TUint iRxTimestamp;
};

class OhmMsgAudio : public OhmMsgTimestamped
{
    friend class OhmMsgFactory;
public:
    static const TUint kMaxSampleBytes    = 5760; // 5ms of 192/24 stereo
    static const TUint kMaxCodecBytes     = 30-1;
    static const TUint kFlagHalt          = 1 << 0;
    static const TUint kFlagLossless      = 1 << 1;
    static const TUint kFlagTimestamped   = 1 << 2;
    static const TUint kFlagResent        = 1 << 3;
    static const TUint kFlagTimestamped2  = 1 << 4;
    static const TUint kStreamHeaderBytes = 88; // 8 bytes Ohm header, 50 bytes audio header, 30 bytes codec name
private:
    static const TUint kHeaderBytes = 50; // not including codec name
    static const TUint kReserved    = 0;
public:
    static void GetStreamHeader(Bwx& aBuf, TUint64 aSamplesTotal, TUint aSampleRate, TUint aBitRate,
                                TUint aVolumeOffset, TUint aBitDepth, TUint aChannels, const Brx& aCodec);

    TBool Halt() const;
    TBool Lossless() const;
    TBool Timestamped() const; // NetworkTimestamp is present but may not be accurate until MediaLatency after clock family change
    TBool Timestamped2() const; // NetworkTimestamp is present and accurate one frame after clock family change
    TBool Resent() const;
    TUint Samples() const;
    TUint Frame() const;
    TUint NetworkTimestamp() const;
    TUint MediaLatency() const;
    TUint MediaTimestamp() const;
    TUint64 SampleStart() const;
    TUint64 SamplesTotal() const;
    TUint SampleRate() const;
    TUint BitRate() const;
    TInt VolumeOffset() const;
    TUint BitDepth() const;
    TUint Channels() const;
    const Brx& Codec() const;
    const Brx& Audio() const;
    Bwx& Audio();

    void SetResent(TBool aValue);
    void Serialise();
    Brn SendableBuffer();
public: // from OhmMsg
    void Process(IOhmMsgProcessor& aProcessor) override;
    void Externalise(IWriter& aWriter) override;
    void ReinitialiseFields(TBool aHalt, TBool aLossless, TBool aTimestamped, TBool aResent, TUint aSamples,
                            TUint aFrame, TUint aNetworkTimestamp, TUint aMediaLatency, TUint64 aSampleStart,
                            const Brx& aStreamHeader);
private:
    OhmMsgAudio(OhmMsgFactory& aFactory);
    void Create();
    void Create(IReader& aReader, const OhmHeader& aHeader);
    void Create(TBool aHalt, TBool aLossless, TBool aTimestamped, TBool aResent, TUint aSamples, TUint aFrame,
                TUint aNetworkTimestamp, TUint aMediaLatency, TUint64 aSampleStart, const Brx& aStreamHeader,
                const Brx& aAudio);
private:
    TBool iHalt;
    TBool iLossless;
    TBool iTimestamped;
    TBool iTimestamped2;
    TBool iResent;
    TUint iSamples;
    TUint iFrame;
    TUint iNetworkTimestamp;
    TUint iMediaLatency;
    TUint iMediaTimestamp;
    TUint64 iSampleStart;
    TUint64 iSamplesTotal;
    TUint iSampleRate;
    TUint iBitRate;
    TInt iVolumeOffset;
    TUint iBitDepth;
    TUint iChannels;
    Bws<kMaxCodecBytes> iCodec;
    Bws<kStreamHeaderBytes+kMaxSampleBytes> iUnifiedBuffer;
    Bwn iAudio;
    TUint iStreamHeaderOffset;
    TBool iHeaderSerialised;
};

class OhmMsgTrack : public OhmMsg
{
    friend class OhmMsgFactory;
public:
    static const TUint kMaxUriBytes = 1 * 1024;
    static const TUint kMaxMetadataBytes = Media::kTrackMetaDataMaxBytes;
private:
    static const TUint kHeaderBytes = 12;
public:
    TUint Sequence() const;
    const Brx& Uri() const;
    const Brx& Metadata() const;
public: // from OhmMsg
    void Process(IOhmMsgProcessor& aProcessor) override;
    void Externalise(IWriter& aWriter) override;
private:
    OhmMsgTrack(OhmMsgFactory& aFactory);
    void Create(IReader& aReader, const OhmHeader& aHeader);    
    void Create(TUint aSequence, const Brx& aUri, const Brx& aMetadata);
private:
    TUint iSequence;
    Bws<kMaxUriBytes> iUri;
    Bws<kMaxMetadataBytes> iMetadata;
};

class OhmMsgMetatext : public OhmMsg
{
    friend class OhmMsgFactory;
private:
    static const TUint kHeaderBytes = 8;
public:
    TUint Sequence() const;
    const Brx& Metatext() const;
public: // from OhmMsg
    void Process(IOhmMsgProcessor& aProcessor) override;
    void Externalise(IWriter& aWriter) override;
private:
    OhmMsgMetatext(OhmMsgFactory& aFactory);
    void Create(IReader& aReader, const OhmHeader& aHeader);    
    void Create(TUint aSequence, const Brx& aMetatext);
private:
    TUint iSequence;
    Bws<Ohm::kMaxTrackMetatextBytes> iMetatext;
};

class IOhmMsgFactory
{
public:
    virtual ~IOhmMsgFactory() {}
    virtual OhmMsg* Create(IReader& aReader, const OhmHeader& aHeader) = 0;
    virtual OhmMsgAudio* CreateAudio(IReader& aReader, const OhmHeader& aHeader) = 0;
    virtual OhmMsgTrack* CreateTrack(IReader& aReader, const OhmHeader& aHeader) = 0;
    virtual OhmMsgMetatext* CreateMetatext(IReader& aReader, const OhmHeader& aHeader) = 0;
    virtual OhmMsgAudio* CreateAudio(TBool aHalt, TBool aLossless, TBool aTimestamped, TBool aResent,
                                     TUint aSamples, TUint aFrame, TUint aNetworkTimestamp, TUint aMediaLatency,
                                     TUint64 aSampleStart, const Brx& aStreamHeader, const Brx& aAudio) = 0;
    virtual OhmMsgAudio* CreateAudio() = 0;
    virtual OhmMsgTrack* CreateTrack(TUint aSequence, const Brx& aUri, const Brx& aMetadata) = 0;
    virtual OhmMsgMetatext* CreateMetatext(TUint aSequence, const Brx& aMetatext) = 0;
};

class OhmMsgFactory : public IOhmMsgFactory, public IOhmMsgProcessor
{
    friend class OhmMsg;

public:
    OhmMsgFactory(TUint aAudioCount, TUint aTrackCount, TUint aMetatextCount);
    ~OhmMsgFactory();
public: // from IOhmMsgFactory
    OhmMsg* Create(IReader& aReader, const OhmHeader& aHeader) override;
    OhmMsgAudio* CreateAudio(IReader& aReader, const OhmHeader& aHeader) override;
    OhmMsgTrack* CreateTrack(IReader& aReader, const OhmHeader& aHeader) override;
    OhmMsgMetatext* CreateMetatext(IReader& aReader, const OhmHeader& aHeader) override;
    OhmMsgAudio* CreateAudio(TBool aHalt, TBool aLossless, TBool aTimestamped, TBool aResent, TUint aSamples,
                             TUint aFrame, TUint aNetworkTimestamp, TUint aMediaLatency, TUint64 aSampleStart,
                             const Brx& aStreamHeader, const Brx& aAudio) override;
    OhmMsgAudio* CreateAudio() override;
    OhmMsgTrack* CreateTrack(TUint aSequence, const Brx& aUri, const Brx& aMetadata) override;
    OhmMsgMetatext* CreateMetatext(TUint aSequence, const Brx& aMetatext) override;
private:
    void Destroy(OhmMsg& aMsg);
private: // from IOhmMsgProcessor
    void Process(OhmMsgAudio& aMsg) override;
    void Process(OhmMsgTrack& aMsg) override;
    void Process(OhmMsgMetatext& aMsg) override;
private:
    Mutex iLock;
    FifoLiteDynamic<OhmMsgAudio*> iFifoAudio;
    FifoLiteDynamic<OhmMsgTrack*> iFifoTrack;
    FifoLiteDynamic<OhmMsgMetatext*> iFifoMetatext;
};

} // namespace Av
} // namespace OpenHome
