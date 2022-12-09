g_output = ""

# TODO: transpile some dependencies,
# TODO: like OHNET into ohNet or SSL into "" (bcs it is loaded by conan)

# TODO: implement executables

def stlib(source: list[str], use: list[str], target: str) -> None:
  global g_output

  src_var_name = target.upper() + "_SOURCES"

  txt = f"set({src_var_name}\n"
  for src in source:
    txt += f"  {src}\n"
  txt += ")\n\n"

  txt += f"""
add_library({target} STATIC ${{{src_var_name}}})
target_include_directories({target} PRIVATE ${{CMAKE_SOURCE_DIR}})
target_include_directories({target} PUBLIC
  ${{OHNET_PATH}}
  ${{THIRDPARTY_HEADERS}}
  ${{CMAKE_BINARY_DIR}}
  "${{CMAKE_BINARY_DIR}}/Generated"
)
target_link_libraries({target} PUBLIC {' '.join(use)})
target_compile_definitions({target} PUBLIC ${{ENDIANNESS}})
  """
  g_output += txt + "\n\n"

# Library
stlib(
        source=[
            'OpenHome/Media/Pipeline/VolumeRamper.cpp',
            'OpenHome/Media/Pipeline/AudioDumper.cpp',
            'OpenHome/Media/Pipeline/AudioReservoir.cpp',
            'OpenHome/Media/Pipeline/DecodedAudioAggregator.cpp',
            'OpenHome/Media/Pipeline/DecodedAudioReservoir.cpp',
            'OpenHome/Media/Pipeline/DecodedAudioValidator.cpp',
            'OpenHome/Media/Pipeline/Drainer.cpp',
            'OpenHome/Media/Pipeline/EncodedAudioReservoir.cpp',
            'OpenHome/Media/Pipeline/Flusher.cpp',
            'OpenHome/Media/Pipeline/Logger.cpp',
            'OpenHome/Media/Pipeline/Msg.cpp',
            'OpenHome/Media/Pipeline/Muter.cpp',
            'OpenHome/Media/Pipeline/MuterVolume.cpp',
            'OpenHome/Media/Pipeline/PreDriver.cpp',
            'OpenHome/Media/Pipeline/Attenuator.cpp',
            'OpenHome/Media/Pipeline/Ramper.cpp',
            'OpenHome/Media/Pipeline/Reporter.cpp',
            'OpenHome/Media/Pipeline/SpotifyReporter.cpp',
            'OpenHome/Media/Pipeline/RampValidator.cpp',
            'OpenHome/Media/Pipeline/Rewinder.cpp',
            'OpenHome/Media/Pipeline/Router.cpp',
            'OpenHome/Media/Pipeline/StreamValidator.cpp',
            'OpenHome/Media/Pipeline/Seeker.cpp',
            'OpenHome/Media/Pipeline/Skipper.cpp',
            'OpenHome/Media/Pipeline/StarvationRamper.cpp',
            'OpenHome/Media/Pipeline/Stopper.cpp',
            'OpenHome/Media/Pipeline/TrackInspector.cpp',
            'OpenHome/Media/Pipeline/VariableDelay.cpp',
            'OpenHome/Media/Pipeline/Waiter.cpp',
            'OpenHome/Media/Pipeline/Pipeline.cpp',
            'OpenHome/Media/Pipeline/ElementObserver.cpp',
            'OpenHome/Media/IdManager.cpp',
            'OpenHome/Media/Filler.cpp',
            'OpenHome/Media/Supply.cpp',
            'OpenHome/Media/SupplyAggregator.cpp',
            'OpenHome/Media/Utils/AnimatorBasic.cpp',
            'OpenHome/Media/Utils/ProcessorAudioUtils.cpp',
            'OpenHome/Media/Utils/ClockPullerManual.cpp',
            'OpenHome/Media/Codec/Mpeg4.cpp',
            'OpenHome/Media/Codec/Container.cpp',
            'OpenHome/Media/Codec/Id3v2.cpp',
            'OpenHome/Media/Codec/MpegTs.cpp',
            'OpenHome/Media/Codec/CodecController.cpp',
            'OpenHome/Media/Protocol/Protocol.cpp',
            'OpenHome/Media/Protocol/ProtocolHls.cpp',
            'OpenHome/Media/Protocol/ProtocolHttp.cpp',
            'OpenHome/Media/Protocol/ProtocolFile.cpp',
            'OpenHome/Media/Protocol/ProtocolTone.cpp',
            'OpenHome/Media/Protocol/Icy.cpp',
            'OpenHome/Media/Protocol/Rtsp.cpp',
            'OpenHome/Media/Protocol/ProtocolRtsp.cpp',
            'OpenHome/Media/Protocol/ContentAudio.cpp',
            'OpenHome/Media/UriProviderRepeater.cpp',
            'OpenHome/Media/UriProviderSingleTrack.cpp',
            'OpenHome/Media/PipelineManager.cpp',
            'OpenHome/Media/PipelineObserver.cpp',
            'OpenHome/Media/MuteManager.cpp',
            'OpenHome/Media/FlywheelRamper.cpp',
            'OpenHome/Media/MimeTypeList.cpp',
            'OpenHome/Media/Utils/AllocatorInfoLogger.cpp', # needed here by MediaPlayer.  Should move back to tests lib
            'OpenHome/Configuration/BufferPtrCmp.cpp',
            'OpenHome/Configuration/ConfigManager.cpp',
            'OpenHome/Media/Utils/Silencer.cpp',
            'OpenHome/SocketHttp.cpp',
            'OpenHome/SocketSsl.cpp',
        ],
        use=['ohNetCore', 'OHNET', 'SSL'],
        target='ohPipeline')

print(g_output)
exit()

# Library
stlib(
        source=[
            'OpenHome/Av/Utils/FaultCode.cpp',
            'OpenHome/Av/KvpStore.cpp',
            'OpenHome/Av/ProviderUtils.cpp',
            'OpenHome/Av/Product.cpp',
            'Generated/DvAvOpenhomeOrgProduct3.cpp',
            'Generated/CpAvOpenhomeOrgProduct3.cpp',
            'OpenHome/Av/ProviderProduct.cpp',
            'Generated/DvAvOpenhomeOrgTime1.cpp',
            'OpenHome/Av/ProviderTime.cpp',
            'Generated/DvAvOpenhomeOrgInfo1.cpp',
            'OpenHome/Av/ProviderInfo.cpp',
            'Generated/DvAvOpenhomeOrgTransport1.cpp',
            'Generated/CpAvOpenhomeOrgTransport1.cpp',
            'OpenHome/Av/TransportControl.cpp',
            'OpenHome/Av/ProviderTransport.cpp',
            'OpenHome/Av/Pins/TransportPins.cpp',
            'OpenHome/Av/Radio/TuneInPins.cpp',
            'OpenHome/Av/Radio/RadioPins.cpp',
            'OpenHome/Av/Pins/UrlPins.cpp',
            'OpenHome/Av/CalmRadio/CalmRadioPins.cpp',
            'Generated/CpAvOpenhomeOrgRadio1.cpp',
            'Generated/DvAvOpenhomeOrgVolume4.cpp',
            'OpenHome/Av/ProviderVolume.cpp',
            'OpenHome/Av/Source.cpp',
            'OpenHome/Av/MediaPlayer.cpp',
            'OpenHome/Av/Logger.cpp',
            'Generated/DvAvOpenhomeOrgConfig2.cpp',
            'OpenHome/Json.cpp',
            'OpenHome/Av/Utils/FormUrl.cpp',
            'OpenHome/NtpClient.cpp',
            'OpenHome/UnixTimestamp.cpp',
            'OpenHome/Configuration/ProviderConfig.cpp',
            'Generated/DvAvOpenhomeOrgConfigApp1.cpp',
            'OpenHome/Configuration/ProviderConfigApp.cpp',
            'OpenHome/PowerManager.cpp',
            'OpenHome/ThreadPool.cpp',
            'OpenHome/FsFlushPeriodic.cpp',
            'OpenHome/Av/Credentials.cpp',
            'Generated/DvAvOpenhomeOrgCredentials1.cpp',
            'OpenHome/Av/ProviderCredentials.cpp',
            'OpenHome/Av/VolumeManager.cpp',
            'OpenHome/Av/FriendlyNameAdapter.cpp',
            'Generated/DvAvOpenhomeOrgDebug2.cpp',
            'OpenHome/Av/ProviderDebug.cpp',
            'OpenHome/Av/Pins/Pins.cpp',
            'Generated/DvAvOpenhomeOrgPins1.cpp',
            'OpenHome/Av/Pins/ProviderPins.cpp',
            'OpenHome/Av/OhMetadata.cpp',
        ],
        use=['OHNET', 'SSL', 'ohPipeline'],
        target='ohMediaPlayer')

stlib(
        source=[
            'OpenHome/Net/Odp/Odp.cpp',
            'OpenHome/Net/Odp/DviOdp.cpp',
            'OpenHome/Net/Odp/DviProtocolOdp.cpp',
            'OpenHome/Net/Odp/DviServerOdp.cpp',
            'OpenHome/Net/Odp/CpiOdp.cpp',
            'OpenHome/Net/Odp/CpiDeviceOdp.cpp',
            'OpenHome/Net/Odp/CpDeviceOdp.cpp',
        ],
        use=['OHNET'],
        target='Odp')


# Library
stlib(
        source=[
            'Generated/DvAvOpenhomeOrgPlaylist1.cpp',
            'Generated/CpAvOpenhomeOrgPlaylist1.cpp',
            'OpenHome/Av/Playlist/ProviderPlaylist.cpp',
            'OpenHome/Av/Playlist/SourcePlaylist.cpp',
            'OpenHome/Av/Playlist/TrackDatabase.cpp',
            'OpenHome/Av/Playlist/UriProviderPlaylist.cpp',
            'OpenHome/Av/Tidal/Tidal.cpp',
            'OpenHome/Av/Tidal/TidalMetadata.cpp',
            'OpenHome/Av/Tidal/TidalPins.cpp',
            'OpenHome/Av/Tidal/ProtocolTidal.cpp',
            'OpenHome/Av/Qobuz/Qobuz.cpp',
            'OpenHome/Av/Qobuz/QobuzMetadata.cpp',
            'OpenHome/Av/Qobuz/QobuzPins.cpp',
            'OpenHome/Av/Qobuz/ProtocolQobuz.cpp',
            'Generated/CpAvOpenhomeOrgTransport1.cpp',
            'OpenHome/Av/Playlist/PinInvokerPlaylist.cpp',
            'OpenHome/Av/Playlist/PinInvokerKazooServer.cpp',
        ],
        use=['OHNET', 'ohMediaPlayer', 'Podcast'],
        target='SourcePlaylist')

# Library
stlib(
        source=[
            'OpenHome/Av/Radio/SourceRadio.cpp',
            'OpenHome/Av/Radio/PresetDatabase.cpp',
            'OpenHome/Av/Radio/UriProviderRadio.cpp',
            'OpenHome/Av/Radio/TuneIn.cpp',
            'OpenHome/Av/CalmRadio/CalmRadio.cpp',
            'OpenHome/Av/CalmRadio/ProtocolCalmRadio.cpp',
            'OpenHome/Av/Radio/ContentAsx.cpp',
            'OpenHome/Av/Radio/ContentM3u.cpp',
            'OpenHome/Av/Radio/ContentM3uX.cpp',
            'OpenHome/Av/Radio/ContentOpml.cpp',
            'OpenHome/Av/Radio/ContentPls.cpp',
            'Generated/DvAvOpenhomeOrgRadio1.cpp',
            'OpenHome/Av/Radio/ProviderRadio.cpp',
        ],
        use=['OHNET', 'ohMediaPlayer', 'Podcast'],
        target='SourceRadio')

# Library
stlib(
        source=[
            'Generated/DvAvOpenhomeOrgSender2.cpp',
            'OpenHome/Av/Songcast/Ohm.cpp',
            'OpenHome/Av/Songcast/OhmMsg.cpp',
            'OpenHome/Av/Songcast/OhmSender.cpp',
            'OpenHome/Av/Songcast/OhmSocket.cpp',
            'OpenHome/Av/Songcast/ProtocolOhBase.cpp',
            'OpenHome/Av/Songcast/ProtocolOhu.cpp',
            'OpenHome/Av/Songcast/ProtocolOhm.cpp',
            'Generated/DvAvOpenhomeOrgReceiver1.cpp',
            'OpenHome/Av/Songcast/ProviderReceiver.cpp',
            'OpenHome/Av/Songcast/ZoneHandler.cpp',
            'OpenHome/Av/Songcast/SourceReceiver.cpp',
            'OpenHome/Av/Songcast/Splitter.cpp',
            'OpenHome/Av/Songcast/Sender.cpp',
            'OpenHome/Av/Songcast/SenderThread.cpp',
            'OpenHome/Av/Utils/DriverSongcastSender.cpp',
        ],
        use=['OHNET', 'ohMediaPlayer'],
        target='SourceSongcast')

# Library
stlib(
        source=[
            'OpenHome/Av/Scd/ScdMsg.cpp',
            'OpenHome/Av/Scd/Receiver/ProtocolScd.cpp',
            'OpenHome/Av/Scd/Receiver/SupplyScd.cpp',
            'OpenHome/Av/Scd/Receiver/UriProviderScd.cpp',
            'OpenHome/Av/Scd/Receiver/SourceScd.cpp'
        ],
        use=['OHNET', 'ohMediaPlayer'],
        target='SourceScd')

# Library
stlib(
        source=[
            'OpenHome/Av/Raop/Raop.cpp',
            'OpenHome/Av/Raop/SourceRaop.cpp',
            'OpenHome/Av/Raop/ProtocolRaop.cpp',
            'OpenHome/Av/Raop/UdpServer.cpp',
            'OpenHome/Av/Raop/CodecRaopApple.cpp',
        ],
        use=['OHNET', 'SSL', 'ohMediaPlayer', 'CodecAlacAppleBase'],
        target='SourceRaop')

# Library
stlib(
        source=[
            'Generated/DvUpnpOrgAVTransport1.cpp',
            'OpenHome/Av/UpnpAv/ProviderAvTransport.cpp',
            'Generated/DvUpnpOrgConnectionManager1.cpp',
            'OpenHome/Av/UpnpAv/ProviderConnectionManager.cpp',
            'Generated/DvUpnpOrgRenderingControl1.cpp',
            'OpenHome/Av/UpnpAv/ProviderRenderingControl.cpp',
            'OpenHome/Av/UpnpAv/UpnpAv.cpp',
            'OpenHome/Av/UpnpAv/FriendlyNameUpnpAv.cpp'
        ],
        use=['OHNET', 'ohMediaPlayer'],
        target='SourceUpnpAv')

# Podcast
stlib(
        source=[
            'OpenHome/Av/Pins/PodcastPins.cpp',
            'OpenHome/Av/Pins/PodcastPinsITunes.cpp',
            'OpenHome/Av/Pins/PodcastPinsTuneIn.cpp'
        ],
        use=['OHNET', 'ohMediaPlayer'],
        target='Podcast')

# Wav
stlib(
        source=['OpenHome/Media/Codec/Wav.cpp'],
        use=['OHNET'],
        target='CodecWav')

# PCM
stlib(
        source=['OpenHome/Media/Codec/Pcm.cpp'],
        use=['OHNET'],
        target='CodecPcm')

# DSD
stlib(
        source=['OpenHome/Media/Codec/DsdDsf.cpp'],
        use=['OHNET'],
        target='CodecDsdDsf')

# DSDDFF
stlib(
        source=['OpenHome/Media/Codec/DsdDff.cpp'],
        use=['OHNET'],
        target='CodecDsdDff')

# DSDDFF
stlib(
        source=['OpenHome/Media/Codec/DsdRaw.cpp'],
        use=['OHNET'],
        target='CodecDsdRaw')

# AiffBase
stlib(
        source=['OpenHome/Media/Codec/AiffBase.cpp'],
        use=['OHNET'],
        target='CodecAiffBase')

# AIFC
stlib(
        source=['OpenHome/Media/Codec/Aifc.cpp'],
        use=['CodecAiffBase', 'OHNET'],
        target='CodecAifc')

# AIFF
stlib(
        source=['OpenHome/Media/Codec/Aiff.cpp'],
        use=['CodecAiffBase', 'OHNET'],
        target='CodecAiff')

# Ogg
stlib(
        source=[
            'thirdparty/libogg/src/bitwise.c',
            'thirdparty/libogg/src/framing.c'
        ],
        use=['OGG'],
        target='libOgg')

# Flac
stlib(
        source=[
            'OpenHome/Media/Codec/Flac.cpp',
            'thirdparty/flac-1.2.1/src/libFLAC/bitreader.c',
            'thirdparty/flac-1.2.1/src/libFLAC/bitmath.c',
            'thirdparty/flac-1.2.1/src/libFLAC/cpu.c',
            'thirdparty/flac-1.2.1/src/libFLAC/crc.c',
            'thirdparty/flac-1.2.1/src/libFLAC/fixed.c',
            'thirdparty/flac-1.2.1/src/libFLAC/format.c',
            'thirdparty/flac-1.2.1/src/libFLAC/lpc.c',
            'thirdparty/flac-1.2.1/src/libFLAC/md5.c',
            'thirdparty/flac-1.2.1/src/libFLAC/memory.c',
            'thirdparty/flac-1.2.1/src/libFLAC/stream_decoder.c',
            'thirdparty/flac-1.2.1/src/libFLAC/ogg_decoder_aspect.c',
            'thirdparty/flac-1.2.1/src/libFLAC/ogg_mapping.c',
        ],
        use=['FLAC', 'OGG', 'libOgg', 'OHNET'],
        shlib=['m'],
        target='CodecFlac')

# AlacAppleBase
stlib(
        source=[
            'OpenHome/Media/Codec/AlacAppleBase.cpp',
            'thirdparty/apple_alac/codec/ag_dec.c',
            'thirdparty/apple_alac/codec/ALACDecoder.cpp',
            'thirdparty/apple_alac/codec/ALACBitUtilities.c',
            'thirdparty/apple_alac/codec/dp_dec.c',
            'thirdparty/apple_alac/codec/EndianPortable.c',
            'thirdparty/apple_alac/codec/matrix_dec.c',
        ],
        use=['ALAC_APPLE', 'OHNET', 'ohMediaPlayer'],
        target='CodecAlacAppleBase')

# AlacApple
stlib(
        source=[
            'OpenHome/Media/Codec/AlacApple.cpp',
        ],
        use=['CodecAlacAppleBase', 'OHNET'],
        target='CodecAlacApple')

# AacFdk (raw decoder only; no codec wrapper).
aac_fdk = stlib(
        source=[
            'thirdparty/fdk-aac/libAACdec/src/aacdec_drc.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aacdec_hcr_bit.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aacdec_hcr.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aacdec_hcrs.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aacdecoder.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aacdecoder_lib.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aacdec_pns.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aacdec_tns.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aac_ram.cpp',
            'thirdparty/fdk-aac/libAACdec/src/aac_rom.cpp',
            'thirdparty/fdk-aac/libAACdec/src/block.cpp',
            'thirdparty/fdk-aac/libAACdec/src/channel.cpp',
            'thirdparty/fdk-aac/libAACdec/src/channelinfo.cpp',
            'thirdparty/fdk-aac/libAACdec/src/conceal.cpp',
            'thirdparty/fdk-aac/libAACdec/src/ldfiltbank.cpp',
            'thirdparty/fdk-aac/libAACdec/src/pulsedata.cpp',
            'thirdparty/fdk-aac/libAACdec/src/rvlcbit.cpp',
            'thirdparty/fdk-aac/libAACdec/src/rvlcconceal.cpp',
            'thirdparty/fdk-aac/libAACdec/src/rvlc.cpp',
            'thirdparty/fdk-aac/libAACdec/src/stereo.cpp',

            'thirdparty/fdk-aac/libFDK/src/autocorr2nd.cpp',
            'thirdparty/fdk-aac/libFDK/src/dct.cpp',
            'thirdparty/fdk-aac/libFDK/src/FDK_bitbuffer.cpp',
            'thirdparty/fdk-aac/libFDK/src/FDK_core.cpp',
            'thirdparty/fdk-aac/libFDK/src/FDK_crc.cpp',
            'thirdparty/fdk-aac/libFDK/src/FDK_hybrid.cpp',
            'thirdparty/fdk-aac/libFDK/src/FDK_tools_rom.cpp',
            'thirdparty/fdk-aac/libFDK/src/FDK_trigFcts.cpp',
            'thirdparty/fdk-aac/libFDK/src/fft.cpp',
            'thirdparty/fdk-aac/libFDK/src/fft_rad2.cpp',
            'thirdparty/fdk-aac/libFDK/src/fixpoint_math.cpp',
            'thirdparty/fdk-aac/libFDK/src/mdct.cpp',
            'thirdparty/fdk-aac/libFDK/src/qmf.cpp',
            'thirdparty/fdk-aac/libFDK/src/scale.cpp',

            'thirdparty/fdk-aac/libMpegTPDec/src/tpdec_adif.cpp',
            'thirdparty/fdk-aac/libMpegTPDec/src/tpdec_adts.cpp',
            'thirdparty/fdk-aac/libMpegTPDec/src/tpdec_asc.cpp',
            'thirdparty/fdk-aac/libMpegTPDec/src/tpdec_drm.cpp',
            'thirdparty/fdk-aac/libMpegTPDec/src/tpdec_latm.cpp',
            'thirdparty/fdk-aac/libMpegTPDec/src/tpdec_lib.cpp',

            'thirdparty/fdk-aac/libPCMutils/src/limiter.cpp',
            'thirdparty/fdk-aac/libPCMutils/src/pcmutils_lib.cpp',

            'thirdparty/fdk-aac/libSBRdec/src/env_calc.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/env_dec.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/env_extr.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/huff_dec.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/lpp_tran.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/psbitdec.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/psdec.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/psdec_hybrid.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbr_crc.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbr_deb.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbr_dec.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbrdec_drc.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbrdec_freq_sca.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbrdecoder.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbr_ram.cpp',
            'thirdparty/fdk-aac/libSBRdec/src/sbr_rom.cpp',

            'thirdparty/fdk-aac/libSYS/src/cmdl_parser.cpp',
            'thirdparty/fdk-aac/libSYS/src/conv_string.cpp',
            'thirdparty/fdk-aac/libSYS/src/genericStds.cpp',
            'thirdparty/fdk-aac/libSYS/src/wav_file.cpp'
        ],
        use=['AAC_FDK', 'OHNET'],
        target='CodecAacFdk')

# AacFdkBase
stlib(
        source=[
            'OpenHome/Media/Codec/AacFdkBase.cpp'
        ],
        use=['CodecAacFdk', 'OHNET'],
        target='CodecAacFdkBase')

# AacFdkMp4
stlib(
        source=[
              'OpenHome/Media/Codec/AacFdkMp4.cpp',
        ],
        use=['CodecAacFdkBase', 'OHNET'],
        target='CodecAacFdkMp4')

# AacFdkAdts
stlib(
        source=[
              'OpenHome/Media/Codec/AacFdkAdts.cpp',
        ],
        use=['CodecAacFdkBase', 'OHNET'],
        target='CodecAacFdkAdts')

# MP3
stlib(
        source=[
            'OpenHome/Media/Codec/Mp3.cpp',
            'thirdparty/libmad-0.15.1b/version.c',
            'thirdparty/libmad-0.15.1b/fixed.c',
            'thirdparty/libmad-0.15.1b/bit.c',
            'thirdparty/libmad-0.15.1b/timer.c',
            'thirdparty/libmad-0.15.1b/stream.c',
            'thirdparty/libmad-0.15.1b/frame.c',
            'thirdparty/libmad-0.15.1b/synth.c',
            'thirdparty/libmad-0.15.1b/decoder.c',
            'thirdparty/libmad-0.15.1b/layer12.c',
            'thirdparty/libmad-0.15.1b/layer3.c',
            'thirdparty/libmad-0.15.1b/huffman.c',
        ],
        use=['MAD', 'OHMEDIAPLAYER', 'OHNET'],
        target='CodecMp3')

# Vorbis
vorbis = stlib(
        source=[
            'OpenHome/Media/Codec/Vorbis.cpp',
            'thirdparty/Tremor/block.c',
            'thirdparty/Tremor/codebook.c',
            'thirdparty/Tremor/floor0.c',
            'thirdparty/Tremor/floor1.c',
            'thirdparty/Tremor/info.c',
            'thirdparty/Tremor/mapping0.c',
            'thirdparty/Tremor/mdct.c',
            'thirdparty/Tremor/registry.c',
            'thirdparty/Tremor/res012.c',
            'thirdparty/Tremor/sharedbook.c',
            'thirdparty/Tremor/synthesis.c',
            'thirdparty/Tremor/vorbisfile.c',
            'thirdparty/Tremor/window.c',
        ],
        use=['VORBIS', 'OGG', 'libOgg', 'OHNET'],
        target='CodecVorbis')

# WebAppFramework
stlib(
    source=[
        'OpenHome/Web/ResourceHandler.cpp',
        'OpenHome/Web/WebAppFramework.cpp',
    ],
    use=['ohNetCore', 'OHNET', 'OHMEDIAPLAYER', 'PLATFORM', 'WebUiStatic'],
    target='WebAppFramework')

# WebAppFramework tests
stlib(
    source=[
        'OpenHome/Web/Tests/TestWebAppFramework.cpp',
    ],
    use=['WebAppFramework', 'OHMEDIAPLAYER', 'OHNET', 'PLATFORM'],
    target='WebAppFrameworkTestUtils')

# ConfigUi
stlib(
    source=[
        'OpenHome/Web/ConfigUi/ConfigUi.cpp',
        'OpenHome/Web/ConfigUi/FileResourceHandler.cpp',
        'OpenHome/Web/ConfigUi/ConfigUiMediaPlayer.cpp',
    ],
    use=['WebAppFramework', 'OHMEDIAPLAYER', 'OHNET', 'PLATFORM'],
    target='ConfigUi')

# ConfigUi tests
stlib(
    source=[
        'OpenHome/Web/ConfigUi/Tests/TestConfigUi.cpp'
    ],
    use=['ConfigUi', 'WebAppFramework', 'OHMEDIAPLAYER', 'OHNET', 'PLATFORM', 'SSL'],
    target='ConfigUiTestUtils')

# Tests
stlib(
        source=[
            'OpenHome/Av/Tests/TestStore.cpp',
            'OpenHome/Av/Tests/RamStore.cpp',
            'OpenHome/Media/Tests/TestMsg.cpp',
            'OpenHome/Media/Tests/TestStarvationRamper.cpp',
            'OpenHome/Media/Tests/TestStreamValidator.cpp',
            'OpenHome/Media/Tests/TestSeeker.cpp',
            'OpenHome/Media/Tests/TestSkipper.cpp',
            'OpenHome/Media/Tests/TestStopper.cpp',
            'OpenHome/Media/Tests/TestWaiter.cpp',
            'OpenHome/Media/Tests/TestSupply.cpp',
            'OpenHome/Media/Tests/TestSupplyAggregator.cpp',
            'OpenHome/Media/Tests/TestAudioReservoir.cpp',
            'OpenHome/Media/Tests/TestVariableDelay.cpp',
            'OpenHome/Media/Tests/TestTrackInspector.cpp',
            'OpenHome/Media/Tests/TestRamper.cpp',
            'OpenHome/Media/Tests/TestFlywheelRamper.cpp',
            'OpenHome/Media/Tests/TestReporter.cpp',
            'OpenHome/Media/Tests/TestSpotifyReporter.cpp',
            'OpenHome/Media/Tests/TestPreDriver.cpp',
            'OpenHome/Media/Tests/TestVolumeRamper.cpp',
            'OpenHome/Media/Tests/TestMuter.cpp',
            'OpenHome/Media/Tests/TestMuterVolume.cpp',
            'OpenHome/Media/Tests/TestDrainer.cpp',
            'OpenHome/Av/Tests/TestContentProcessor.cpp',
            'OpenHome/Media/Tests/TestPipeline.cpp',
            'OpenHome/Media/Tests/TestPipelineConfig.cpp',
            'OpenHome/Media/Tests/TestProtocolHls.cpp',
            'OpenHome/Media/Tests/TestProtocolHttp.cpp',
            'OpenHome/Media/Tests/TestCodec.cpp',
            'OpenHome/Media/Tests/TestCodecInit.cpp',
            'OpenHome/Media/Tests/TestCodecController.cpp',
            'OpenHome/Media/Tests/TestDecodedAudioAggregator.cpp',
            'OpenHome/Media/Tests/TestContainer.cpp',
            'OpenHome/Media/Tests/TestSilencer.cpp',
            'OpenHome/Media/Tests/TestIdProvider.cpp',
            'OpenHome/Media/Tests/TestFiller.cpp',
            'OpenHome/Media/Tests/TestToneGenerator.cpp',
            'OpenHome/Media/Tests/TestMuteManager.cpp',
            'OpenHome/Media/Tests/TestRewinder.cpp',
            'OpenHome/Media/Tests/TestShell.cpp',
            'OpenHome/Media/Tests/TestUriProviderRepeater.cpp',
            'OpenHome/Av/Tests/TestFriendlyNameManager.cpp',
            'OpenHome/Av/Tests/TestUdpServer.cpp',
            'OpenHome/Av/Tests/TestUpnpErrors.cpp',
            'Generated/CpUpnpOrgAVTransport1.cpp',
            'Generated/CpUpnpOrgConnectionManager1.cpp',
            'Generated/CpUpnpOrgRenderingControl1.cpp',
            'OpenHome/Av/Tests/TestTrackDatabase.cpp',
            #'OpenHome/Av/Tests/TestPlaylist.cpp',
            'OpenHome/Av/Tests/TestMediaPlayer.cpp',
            'OpenHome/Av/Tests/TestMediaPlayerOptions.cpp',
            'OpenHome/Configuration/Tests/ConfigRamStore.cpp',
            'OpenHome/Configuration/Tests/TestConfigManager.cpp',
            'OpenHome/Tests/TestPipe.cpp',
            'OpenHome/Tests/Mock.cpp',
            'OpenHome/Tests/TestPowerManager.cpp',
            'OpenHome/Tests/TestSsl.cpp',
            'OpenHome/Tests/TestSocket.cpp',
            'OpenHome/Av/Tests/TestCredentials.cpp',
            'Generated/CpAvOpenhomeOrgCredentials1.cpp',
            'OpenHome/Tests/TestJson.cpp',
            'OpenHome/Tests/TestThreadPool.cpp',
            'OpenHome/Av/Tests/TestRaop.cpp',
            'OpenHome/Av/Tests/TestVolumeManager.cpp',
            'OpenHome/Av/Tests/TestPins.cpp',
            'OpenHome/Av/Tests/TestSenderQueue.cpp',
            'OpenHome/Net/Odp/Tests/TestDvOdp.cpp',
        ],
        use=['ConfigUi', 'WebAppFramework', 'ohMediaPlayer', 'WebAppFramework', 'CodecFlac', 'CodecWav', 'CodecPcm', 'CodecDsdDsf', 'CodecDsdDff', 'CodecDsdRaw',  'CodecAlac', 'CodecAlacApple', 'CodecAifc', 'CodecAiff', 'CodecAacFdkAdts', 'CodecAacFdkMp4', 'CodecMp3', 'CodecVorbis', 'Odp', 'TestFramework', 'OHNET', 'SSL'],
        target='ohMediaPlayerTestUtils')

program(
        source='OpenHome/Media/Tests/TestShellMain.cpp',
        use=['OHNET', 'SSL', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'WebAppFrameworkTestUtils', 'SourcePlaylist', 'SourceRadio', 'SourceRaop', 'SourceSongcast', 'SourceUpnpAv', 'Odp'],
        target='TestShell',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestMsgMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestMsg',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestStarvationRamperMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestStarvationRamper',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestStreamValidatorMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestStreamValidator',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestSeekerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestSeeker',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestSkipperMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestSkipper',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestStopperMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestStopper',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestWaiterMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestWaiter',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestSupplyMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestSupply',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestSupplyAggregatorMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestSupplyAggregator',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestAudioReservoirMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestAudioReservoir',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestVariableDelayMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestVariableDelay',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestTrackInspectorMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestTrackInspector',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestRamperMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestRamper',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestFlywheelRamperManualMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestFlywheelRamperManual',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestFlywheelRamperMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestFlywheelRamper',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestReporterMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestReporter',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestSpotifyReporterMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestSpotifyReporter',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestPreDriverMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestPreDriver',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestVolumeRamperMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestVolumeRamper',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestMuterMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestMuter',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestMuterVolumeMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestMuterVolume',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestDrainerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestDrainer',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestContentProcessorMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourceRadio'],
        target='TestContentProcessor',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestPipelineMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestPipeline',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestPipelineConfigMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestPipelineConfig',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestStoreMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestStore',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestProtocolHlsMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SSL'],
        target='TestProtocolHls',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestProtocolHttpMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SSL'],
        target='TestProtocolHttp',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestCodecMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SSL'],
        target='TestCodec',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestCodecInteractiveMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestCodecInteractive',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestCodecControllerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestCodecController',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestDecodedAudioAggregatorMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestDecodedAudioAggregator',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestContainerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestContainer',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestSilencerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestSilencer',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestIdProviderMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestIdProvider',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestFillerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestFiller',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestToneGeneratorMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestToneGenerator',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestMuteManagerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestMuteManager',
        install_path=None)
program(
        source='OpenHome/Media/Tests/TestRewinderMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestRewinder',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestUdpServerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourceRaop'],
        target='TestUdpServer',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestUpnpErrorsMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourceUpnpAv'],
        target='TestUpnpErrors',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestTrackDatabaseMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourcePlaylist'],
        target='TestTrackDatabase',
        install_path=None)
#program(
#        source='OpenHome/Av/Tests/TestPlaylistMain.cpp',
#        use=['OHNET', 'SSL', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourcePlaylist'],
#        target='TestPlaylist',
#        install_path=None)
program(
        source='OpenHome/Media/Tests/TestUriProviderRepeaterMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourceUpnpAv'],
        target='TestUriProviderRepeater',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestMediaPlayerMain.cpp',
        use=['OHNET', 'SSL', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourcePlaylist', 'SourceRadio', 'SourceSongcast', 'SourceScd', 'SourceRaop', 'SourceUpnpAv', 'WebAppFramework', 'ConfigUi'],
        target='TestMediaPlayer',
        install_path=os.path.join(path.abspath(), 'install', 'bin'))
program(
        source='OpenHome/Configuration/Tests/TestConfigManagerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestConfigManager',
        install_path=None)
program(
        source='OpenHome/Tests/TestPowerManagerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestPowerManager',
        install_path=None)
program(
        source='OpenHome/Tests/TestSslMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SSL'],
        target='TestSsl',
        install_path=None)
program(
        source='OpenHome/Tests/TestSocketMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestSocket',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestCredentialsMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SSL'],
        target='TestCredentials',
        install_path=None)
program(
        source='OpenHome/Tests/TestHttps.cpp',
        use=['OHNET', 'ohMediaPlayer', 'SSL'],
        target='TestHttps',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestFriendlyNameManagerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestFriendlyNameManager',
        install_path=None)
#program(
#        source='OpenHome/Tests/TestKey.cpp',
#        use=['OHNET', 'ohMediaPlayer', 'SSL'],
#        target='TestKey',
#        install_path=None)
#program(
#        source='OpenHome/Tests/TestHttpsBsd.cpp',
#        use=['OHNET', 'ohMediaPlayer', 'SSL'],
#        target='TestHttpsBsd',
#        install_path=None)
program(
        source='OpenHome/Av/Tidal/TestTidal.cpp',
        use=['OHNET', 'SSL', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourcePlaylist'],
        target='TestTidal',
        install_path=None)
program(
        source='OpenHome/Tests/TestJsonMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestJson',
        install_path=None)
program(
        source='OpenHome/Tests/TestThreadPoolMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestThreadPool',
        install_path=None)
program(
        source='OpenHome/Av/Qobuz/TestQobuz.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourcePlaylist'],
        target='TestQobuz',
        install_path=None)
program(
        source='OpenHome/Tests/TestNtpClient.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourcePlaylist'],
        target='TestNtpClient',
        install_path=None)
program(
        source=['OpenHome/Web/Tests/TestWebAppFrameworkMain.cpp'],
        use=['OHNET', 'PLATFORM', 'WebAppFrameworkTestUtils', 'WebAppFramework', 'ohMediaPlayer'],
        target='TestWebAppFramework',
        install_path=None)
program(
        source=['OpenHome/Web/ConfigUi/Tests/TestConfigUiMain.cpp'],
        use=['OHNET', 'PLATFORM', 'SSL', 'ConfigUiTestUtils', 'WebAppFrameworkTestUtils', 'ConfigUi', 'WebAppFramework', 'ohMediaPlayerTestUtils', 'SourcePlaylist', 'SourceRadio', 'SourceSongcast', 'SourceScd', 'SourceRaop', 'SourceUpnpAv', 'ohMediaPlayer'],
        target='TestConfigUi',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestRaopMain.cpp',
        use=['OHNET', 'SSL', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourceRaop'],
        target='TestRaop',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestVolumeManagerMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestVolumeManager',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestPinsMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils'],
        target='TestPins',
        install_path=None)
program(
        source='OpenHome/Av/Tests/TestSenderQueueMain.cpp',
        use=['OHNET', 'ohMediaPlayer', 'ohMediaPlayerTestUtils', 'SourceSongcast'],
        target='TestSenderQueue',
        install_path=None)
program(
        source='OpenHome/Net/Odp/Tests/TestDvOdpMain.cpp',
        use=['OHNET', 'Odp', 'ohMediaPlayerTestUtils'],
        target='TestDvOdp',
        install_path=None)
program(
        source='OpenHome/Net/Odp/Tests/TestCpDeviceListOdp.cpp',
        use=['OHNET', 'Odp', 'ohMediaPlayerTestUtils'],
        target='TestCpDeviceListOdp',
        install_path=None)

stlib(
        source=[
            'OpenHome/Av/Scd/ScdMsg.cpp',
            'OpenHome/Av/Scd/Sender/ScdSupply.cpp',
            'OpenHome/Av/Scd/Sender/ScdServer.cpp'
        ],
        use=['OHNET', 'ohMediaPlayer'],
        target='ScdSender')
