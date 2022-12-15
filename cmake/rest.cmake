set(ODP_SOURCES
  OpenHome/Net/Odp/Odp.cpp
  OpenHome/Net/Odp/DviOdp.cpp
  OpenHome/Net/Odp/DviProtocolOdp.cpp
  OpenHome/Net/Odp/DviServerOdp.cpp
  OpenHome/Net/Odp/CpiOdp.cpp
  OpenHome/Net/Odp/CpiDeviceOdp.cpp
  OpenHome/Net/Odp/CpDeviceOdp.cpp
)

add_library(Odp STATIC ${ODP_SOURCES})
target_include_directories(Odp PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(Odp PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(Odp PUBLIC ohNet)
target_compile_definitions(Odp PUBLIC ${ENDIANNESS})

set(SOURCEPLAYLIST_SOURCES
  Generated/DvAvOpenhomeOrgPlaylist1.cpp
  Generated/DvAvOpenhomeOrgPlaylist1.h
  Generated/CpAvOpenhomeOrgPlaylist1.cpp
  Generated/CpAvOpenhomeOrgPlaylist1.h
  OpenHome/Av/Playlist/ProviderPlaylist.cpp
  OpenHome/Av/Playlist/SourcePlaylist.cpp
  OpenHome/Av/Playlist/TrackDatabase.cpp
  OpenHome/Av/Playlist/UriProviderPlaylist.cpp
  OpenHome/Av/Tidal/Tidal.cpp
  OpenHome/Av/Tidal/TidalMetadata.cpp
  OpenHome/Av/Tidal/TidalPins.cpp
  OpenHome/Av/Tidal/ProtocolTidal.cpp
  OpenHome/Av/Qobuz/Qobuz.cpp
  OpenHome/Av/Qobuz/QobuzMetadata.cpp
  OpenHome/Av/Qobuz/QobuzPins.cpp
  OpenHome/Av/Qobuz/ProtocolQobuz.cpp
  Generated/CpAvOpenhomeOrgTransport1.cpp
  Generated/CpAvOpenhomeOrgTransport1.h
  OpenHome/Av/Playlist/PinInvokerPlaylist.cpp
  OpenHome/Av/Playlist/PinInvokerKazooServer.cpp
)

add_library(SourcePlaylist STATIC ${SOURCEPLAYLIST_SOURCES})
target_include_directories(SourcePlaylist PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(SourcePlaylist PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(SourcePlaylist PUBLIC ohNet ohMediaPlayer Podcast)
target_compile_definitions(SourcePlaylist PUBLIC ${ENDIANNESS})

set(SOURCERADIO_SOURCES
  OpenHome/Av/Radio/SourceRadio.cpp
  OpenHome/Av/Radio/PresetDatabase.cpp
  OpenHome/Av/Radio/UriProviderRadio.cpp
  OpenHome/Av/Radio/TuneIn.cpp
  OpenHome/Av/CalmRadio/CalmRadio.cpp
  OpenHome/Av/CalmRadio/ProtocolCalmRadio.cpp
  OpenHome/Av/Radio/ContentAsx.cpp
  OpenHome/Av/Radio/ContentM3u.cpp
  OpenHome/Av/Radio/ContentM3uX.cpp
  OpenHome/Av/Radio/ContentOpml.cpp
  OpenHome/Av/Radio/ContentPls.cpp
  Generated/DvAvOpenhomeOrgRadio1.cpp
  Generated/DvAvOpenhomeOrgRadio1.h
  OpenHome/Av/Radio/ProviderRadio.cpp
)

add_library(SourceRadio STATIC ${SOURCERADIO_SOURCES})
target_include_directories(SourceRadio PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(SourceRadio PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(SourceRadio PUBLIC ohNet ohMediaPlayer Podcast)
target_compile_definitions(SourceRadio PUBLIC ${ENDIANNESS})

set(SOURCESONGCAST_SOURCES
  Generated/DvAvOpenhomeOrgSender2.cpp
  Generated/DvAvOpenhomeOrgSender2.h
  OpenHome/Av/Songcast/Ohm.cpp
  OpenHome/Av/Songcast/OhmMsg.cpp
  OpenHome/Av/Songcast/OhmSender.cpp
  OpenHome/Av/Songcast/OhmSocket.cpp
  OpenHome/Av/Songcast/ProtocolOhBase.cpp
  OpenHome/Av/Songcast/ProtocolOhu.cpp
  OpenHome/Av/Songcast/ProtocolOhm.cpp
  Generated/DvAvOpenhomeOrgReceiver1.cpp
  Generated/DvAvOpenhomeOrgReceiver1.h
  OpenHome/Av/Songcast/ProviderReceiver.cpp
  OpenHome/Av/Songcast/ZoneHandler.cpp
  OpenHome/Av/Songcast/SourceReceiver.cpp
  OpenHome/Av/Songcast/Splitter.cpp
  OpenHome/Av/Songcast/Sender.cpp
  OpenHome/Av/Songcast/SenderThread.cpp
  OpenHome/Av/Utils/DriverSongcastSender.cpp
)

add_library(SourceSongcast STATIC ${SOURCESONGCAST_SOURCES})
target_include_directories(SourceSongcast PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(SourceSongcast PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(SourceSongcast PUBLIC ohNet ohMediaPlayer)
target_compile_definitions(SourceSongcast PUBLIC ${ENDIANNESS})

set(SOURCESCD_SOURCES
  OpenHome/Av/Scd/ScdMsg.cpp
  OpenHome/Av/Scd/Receiver/ProtocolScd.cpp
  OpenHome/Av/Scd/Receiver/SupplyScd.cpp
  OpenHome/Av/Scd/Receiver/UriProviderScd.cpp
  OpenHome/Av/Scd/Receiver/SourceScd.cpp
)

add_library(SourceScd STATIC ${SOURCESCD_SOURCES})
target_include_directories(SourceScd PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(SourceScd PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(SourceScd PUBLIC ohNet ohMediaPlayer)
target_compile_definitions(SourceScd PUBLIC ${ENDIANNESS})

set(SOURCERAOP_SOURCES
  OpenHome/Av/Raop/Raop.cpp
  OpenHome/Av/Raop/SourceRaop.cpp
  OpenHome/Av/Raop/ProtocolRaop.cpp
  OpenHome/Av/Raop/UdpServer.cpp
  OpenHome/Av/Raop/CodecRaopApple.cpp
)

add_library(SourceRaop STATIC ${SOURCERAOP_SOURCES})
target_include_directories(SourceRaop PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(SourceRaop PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(SourceRaop PUBLIC ohNet ohMediaPlayer CodecAlacAppleBase)
target_compile_definitions(SourceRaop PUBLIC ${ENDIANNESS})

set(SOURCEUPNPAV_SOURCES
  Generated/DvUpnpOrgAVTransport1.cpp
  Generated/DvUpnpOrgAVTransport1.h
  OpenHome/Av/UpnpAv/ProviderAvTransport.cpp
  Generated/DvUpnpOrgConnectionManager1.cpp
  Generated/DvUpnpOrgConnectionManager1.h
  OpenHome/Av/UpnpAv/ProviderConnectionManager.cpp
  Generated/DvUpnpOrgRenderingControl1.cpp
  Generated/DvUpnpOrgRenderingControl1.h
  OpenHome/Av/UpnpAv/ProviderRenderingControl.cpp
  OpenHome/Av/UpnpAv/UpnpAv.cpp
  OpenHome/Av/UpnpAv/FriendlyNameUpnpAv.cpp
)

add_library(SourceUpnpAv STATIC ${SOURCEUPNPAV_SOURCES})
target_include_directories(SourceUpnpAv PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(SourceUpnpAv PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(SourceUpnpAv PUBLIC ohNet ohMediaPlayer)
target_compile_definitions(SourceUpnpAv PUBLIC ${ENDIANNESS})

set(PODCAST_SOURCES
  OpenHome/Av/Pins/PodcastPins.cpp
  OpenHome/Av/Pins/PodcastPinsITunes.cpp
  OpenHome/Av/Pins/PodcastPinsTuneIn.cpp
)

add_library(Podcast STATIC ${PODCAST_SOURCES})
target_include_directories(Podcast PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(Podcast PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(Podcast PUBLIC ohNet ohMediaPlayer)
target_compile_definitions(Podcast PUBLIC ${ENDIANNESS})

set(CODECWAV_SOURCES
  OpenHome/Media/Codec/Wav.cpp
)

add_library(CodecWav STATIC ${CODECWAV_SOURCES})
target_include_directories(CodecWav PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecWav PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecWav PUBLIC ohNet)
target_compile_definitions(CodecWav PUBLIC ${ENDIANNESS})

set(CODECPCM_SOURCES
  OpenHome/Media/Codec/Pcm.cpp
)

add_library(CodecPcm STATIC ${CODECPCM_SOURCES})
target_include_directories(CodecPcm PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecPcm PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecPcm PUBLIC ohNet)
target_compile_definitions(CodecPcm PUBLIC ${ENDIANNESS})

set(CODECDSDDSF_SOURCES
  OpenHome/Media/Codec/DsdDsf.cpp
)

add_library(CodecDsdDsf STATIC ${CODECDSDDSF_SOURCES})
target_include_directories(CodecDsdDsf PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecDsdDsf PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecDsdDsf PUBLIC ohNet)
target_compile_definitions(CodecDsdDsf PUBLIC ${ENDIANNESS})

set(CODECDSDDFF_SOURCES
  OpenHome/Media/Codec/DsdDff.cpp
)

add_library(CodecDsdDff STATIC ${CODECDSDDFF_SOURCES})
target_include_directories(CodecDsdDff PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecDsdDff PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecDsdDff PUBLIC ohNet)
target_compile_definitions(CodecDsdDff PUBLIC ${ENDIANNESS})

set(CODECDSDRAW_SOURCES
  OpenHome/Media/Codec/DsdRaw.cpp
)

add_library(CodecDsdRaw STATIC ${CODECDSDRAW_SOURCES})
target_include_directories(CodecDsdRaw PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecDsdRaw PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecDsdRaw PUBLIC ohNet)
target_compile_definitions(CodecDsdRaw PUBLIC ${ENDIANNESS})

set(CODECAIFFBASE_SOURCES
  OpenHome/Media/Codec/AiffBase.cpp
)

add_library(CodecAiffBase STATIC ${CODECAIFFBASE_SOURCES})
target_include_directories(CodecAiffBase PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAiffBase PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAiffBase PUBLIC ohNet)
target_compile_definitions(CodecAiffBase PUBLIC ${ENDIANNESS})

set(CODECAIFC_SOURCES
  OpenHome/Media/Codec/Aifc.cpp
)

add_library(CodecAifc STATIC ${CODECAIFC_SOURCES})
target_include_directories(CodecAifc PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAifc PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAifc PUBLIC CodecAiffBase ohNet)
target_compile_definitions(CodecAifc PUBLIC ${ENDIANNESS})

set(CODECAIFF_SOURCES
  OpenHome/Media/Codec/Aiff.cpp
)

add_library(CodecAiff STATIC ${CODECAIFF_SOURCES})
target_include_directories(CodecAiff PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAiff PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAiff PUBLIC CodecAiffBase ohNet)
target_compile_definitions(CodecAiff PUBLIC ${ENDIANNESS})

# set(LIBOGG_SOURCES
# thirdparty/libogg/src/bitwise.c
# thirdparty/libogg/src/framing.c
# )

# add_library(libOgg STATIC ${LIBOGG_SOURCES})
# target_include_directories(libOgg PRIVATE ${CMAKE_SOURCE_DIR})
# target_include_directories(libOgg PUBLIC
# ${OHNET_PATH}/include/ohnet
# ${THIRDPARTY_HEADERS}
# ${CMAKE_BINARY_DIR}
# "${CMAKE_BINARY_DIR}/Generated"
# )
# target_link_libraries(libOgg PUBLIC OGG)
# target_compile_definitions(libOgg PUBLIC ${ENDIANNESS})
set(CODECFLAC_SOURCES
  OpenHome/Media/Codec/Flac.cpp

  # thirdparty/flac-1.2.1/src/libFLAC/bitreader.c
  # thirdparty/flac-1.2.1/src/libFLAC/bitmath.c
  # thirdparty/flac-1.2.1/src/libFLAC/cpu.c
  # thirdparty/flac-1.2.1/src/libFLAC/crc.c
  # thirdparty/flac-1.2.1/src/libFLAC/fixed.c
  # thirdparty/flac-1.2.1/src/libFLAC/format.c
  # thirdparty/flac-1.2.1/src/libFLAC/lpc.c
  # thirdparty/flac-1.2.1/src/libFLAC/md5.c
  # thirdparty/flac-1.2.1/src/libFLAC/memory.c
  # thirdparty/flac-1.2.1/src/libFLAC/stream_decoder.c
  # thirdparty/flac-1.2.1/src/libFLAC/ogg_decoder_aspect.c
  # thirdparty/flac-1.2.1/src/libFLAC/ogg_mapping.c
)

add_library(CodecFlac STATIC ${CODECFLAC_SOURCES})
target_include_directories(CodecFlac PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecFlac PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecFlac PUBLIC FLAC OGG libOgg ohNet)
target_compile_definitions(CodecFlac PUBLIC ${ENDIANNESS})

set(CODECALACAPPLEBASE_SOURCES
  OpenHome/Media/Codec/AlacAppleBase.cpp

  # thirdparty/apple_alac/codec/ag_dec.c
  # thirdparty/apple_alac/codec/ALACDecoder.cpp
  # thirdparty/apple_alac/codec/ALACBitUtilities.c
  # thirdparty/apple_alac/codec/dp_dec.c
  # thirdparty/apple_alac/codec/EndianPortable.c
  # thirdparty/apple_alac/codec/matrix_dec.c
)

add_library(CodecAlacAppleBase STATIC ${CODECALACAPPLEBASE_SOURCES})
target_include_directories(CodecAlacAppleBase PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAlacAppleBase PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAlacAppleBase PUBLIC ALAC_APPLE ohNet ohMediaPlayer)
target_compile_definitions(CodecAlacAppleBase PUBLIC ${ENDIANNESS})

set(CODECALACAPPLE_SOURCES
  OpenHome/Media/Codec/AlacApple.cpp
)

add_library(CodecAlacApple STATIC ${CODECALACAPPLE_SOURCES})
target_include_directories(CodecAlacApple PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAlacApple PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAlacApple PUBLIC CodecAlacAppleBase ohNet)
target_compile_definitions(CodecAlacApple PUBLIC ${ENDIANNESS})

# set(CODECAACFDK_SOURCES
# thirdparty/fdk-aac/libAACdec/src/aacdec_drc.cpp
# thirdparty/fdk-aac/libAACdec/src/aacdec_hcr_bit.cpp
# thirdparty/fdk-aac/libAACdec/src/aacdec_hcr.cpp
# thirdparty/fdk-aac/libAACdec/src/aacdec_hcrs.cpp
# thirdparty/fdk-aac/libAACdec/src/aacdecoder.cpp
# thirdparty/fdk-aac/libAACdec/src/aacdecoder_lib.cpp
# thirdparty/fdk-aac/libAACdec/src/aacdec_pns.cpp
# thirdparty/fdk-aac/libAACdec/src/aacdec_tns.cpp
# thirdparty/fdk-aac/libAACdec/src/aac_ram.cpp
# thirdparty/fdk-aac/libAACdec/src/aac_rom.cpp
# thirdparty/fdk-aac/libAACdec/src/block.cpp
# thirdparty/fdk-aac/libAACdec/src/channel.cpp
# thirdparty/fdk-aac/libAACdec/src/channelinfo.cpp
# thirdparty/fdk-aac/libAACdec/src/conceal.cpp
# thirdparty/fdk-aac/libAACdec/src/ldfiltbank.cpp
# thirdparty/fdk-aac/libAACdec/src/pulsedata.cpp
# thirdparty/fdk-aac/libAACdec/src/rvlcbit.cpp
# thirdparty/fdk-aac/libAACdec/src/rvlcconceal.cpp
# thirdparty/fdk-aac/libAACdec/src/rvlc.cpp
# thirdparty/fdk-aac/libAACdec/src/stereo.cpp
# thirdparty/fdk-aac/libFDK/src/autocorr2nd.cpp
# thirdparty/fdk-aac/libFDK/src/dct.cpp
# thirdparty/fdk-aac/libFDK/src/FDK_bitbuffer.cpp
# thirdparty/fdk-aac/libFDK/src/FDK_core.cpp
# thirdparty/fdk-aac/libFDK/src/FDK_crc.cpp
# thirdparty/fdk-aac/libFDK/src/FDK_hybrid.cpp
# thirdparty/fdk-aac/libFDK/src/FDK_tools_rom.cpp
# thirdparty/fdk-aac/libFDK/src/FDK_trigFcts.cpp
# thirdparty/fdk-aac/libFDK/src/fft.cpp
# thirdparty/fdk-aac/libFDK/src/fft_rad2.cpp
# thirdparty/fdk-aac/libFDK/src/fixpoint_math.cpp
# thirdparty/fdk-aac/libFDK/src/mdct.cpp
# thirdparty/fdk-aac/libFDK/src/qmf.cpp
# thirdparty/fdk-aac/libFDK/src/scale.cpp
# thirdparty/fdk-aac/libMpegTPDec/src/tpdec_adif.cpp
# thirdparty/fdk-aac/libMpegTPDec/src/tpdec_adts.cpp
# thirdparty/fdk-aac/libMpegTPDec/src/tpdec_asc.cpp
# thirdparty/fdk-aac/libMpegTPDec/src/tpdec_drm.cpp
# thirdparty/fdk-aac/libMpegTPDec/src/tpdec_latm.cpp
# thirdparty/fdk-aac/libMpegTPDec/src/tpdec_lib.cpp
# thirdparty/fdk-aac/libPCMutils/src/limiter.cpp
# thirdparty/fdk-aac/libPCMutils/src/pcmutils_lib.cpp
# thirdparty/fdk-aac/libSBRdec/src/env_calc.cpp
# thirdparty/fdk-aac/libSBRdec/src/env_dec.cpp
# thirdparty/fdk-aac/libSBRdec/src/env_extr.cpp
# thirdparty/fdk-aac/libSBRdec/src/huff_dec.cpp
# thirdparty/fdk-aac/libSBRdec/src/lpp_tran.cpp
# thirdparty/fdk-aac/libSBRdec/src/psbitdec.cpp
# thirdparty/fdk-aac/libSBRdec/src/psdec.cpp
# thirdparty/fdk-aac/libSBRdec/src/psdec_hybrid.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbr_crc.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbr_deb.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbr_dec.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbrdec_drc.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbrdec_freq_sca.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbrdecoder.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbr_ram.cpp
# thirdparty/fdk-aac/libSBRdec/src/sbr_rom.cpp
# thirdparty/fdk-aac/libSYS/src/cmdl_parser.cpp
# thirdparty/fdk-aac/libSYS/src/conv_string.cpp
# thirdparty/fdk-aac/libSYS/src/genericStds.cpp
# thirdparty/fdk-aac/libSYS/src/wav_file.cpp
# )

# add_library(CodecAacFdk STATIC ${CODECAACFDK_SOURCES})
# target_include_directories(CodecAacFdk PRIVATE ${CMAKE_SOURCE_DIR})
# target_include_directories(CodecAacFdk PUBLIC
# ${OHNET_PATH}/include/ohnet
# ${THIRDPARTY_HEADERS}
# ${CMAKE_BINARY_DIR}
# "${CMAKE_BINARY_DIR}/Generated"
# )
# target_link_libraries(CodecAacFdk PUBLIC AAC_FDK ohNet)
# target_compile_definitions(CodecAacFdk PUBLIC ${ENDIANNESS})
set(CODECAACFDKBASE_SOURCES
  OpenHome/Media/Codec/AacFdkBase.cpp
)

add_library(CodecAacFdkBase STATIC ${CODECAACFDKBASE_SOURCES})
target_include_directories(CodecAacFdkBase PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAacFdkBase PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAacFdkBase PUBLIC CodecAacFdk ohNet)
target_compile_definitions(CodecAacFdkBase PUBLIC ${ENDIANNESS})

set(CODECAACFDKMP4_SOURCES
  OpenHome/Media/Codec/AacFdkMp4.cpp
)

add_library(CodecAacFdkMp4 STATIC ${CODECAACFDKMP4_SOURCES})
target_include_directories(CodecAacFdkMp4 PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAacFdkMp4 PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAacFdkMp4 PUBLIC CodecAacFdkBase ohNet)
target_compile_definitions(CodecAacFdkMp4 PUBLIC ${ENDIANNESS})

set(CODECAACFDKADTS_SOURCES
  OpenHome/Media/Codec/AacFdkAdts.cpp
)

add_library(CodecAacFdkAdts STATIC ${CODECAACFDKADTS_SOURCES})
target_include_directories(CodecAacFdkAdts PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAacFdkAdts PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAacFdkAdts PUBLIC CodecAacFdkBase ohNet)
target_compile_definitions(CodecAacFdkAdts PUBLIC ${ENDIANNESS})

set(CODECMP3_SOURCES
  OpenHome/Media/Codec/Mp3.cpp

  # thirdparty/libmad-0.15.1b/version.c
  # thirdparty/libmad-0.15.1b/fixed.c
  # thirdparty/libmad-0.15.1b/bit.c
  # thirdparty/libmad-0.15.1b/timer.c
  # thirdparty/libmad-0.15.1b/stream.c
  # thirdparty/libmad-0.15.1b/frame.c
  # thirdparty/libmad-0.15.1b/synth.c
  # thirdparty/libmad-0.15.1b/decoder.c
  # thirdparty/libmad-0.15.1b/layer12.c
  # thirdparty/libmad-0.15.1b/layer3.c
  # thirdparty/libmad-0.15.1b/huffman.c
)

add_library(CodecMp3 STATIC ${CODECMP3_SOURCES})
target_include_directories(CodecMp3 PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecMp3 PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecMp3 PUBLIC MAD OHMEDIAPLAYER ohNet)
target_compile_definitions(CodecMp3 PUBLIC ${ENDIANNESS})

set(CODECVORBIS_SOURCES
  OpenHome/Media/Codec/Vorbis.cpp

  # thirdparty/Tremor/block.c
  # thirdparty/Tremor/codebook.c
  # thirdparty/Tremor/floor0.c
  # thirdparty/Tremor/floor1.c
  # thirdparty/Tremor/info.c
  # thirdparty/Tremor/mapping0.c
  # thirdparty/Tremor/mdct.c
  # thirdparty/Tremor/registry.c
  # thirdparty/Tremor/res012.c
  # thirdparty/Tremor/sharedbook.c
  # thirdparty/Tremor/synthesis.c
  # thirdparty/Tremor/vorbisfile.c
  # thirdparty/Tremor/window.c
)

add_library(CodecVorbis STATIC ${CODECVORBIS_SOURCES})
target_include_directories(CodecVorbis PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(CodecVorbis PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecVorbis PUBLIC VORBIS OGG libOgg ohNet)
target_compile_definitions(CodecVorbis PUBLIC ${ENDIANNESS})

set(WEBAPPFRAMEWORK_SOURCES
  OpenHome/Web/ResourceHandler.cpp
  OpenHome/Web/WebAppFramework.cpp
)

add_library(WebAppFramework STATIC ${WEBAPPFRAMEWORK_SOURCES})
target_include_directories(WebAppFramework PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(WebAppFramework PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(WebAppFramework PUBLIC ohNetCore ohNet OHMEDIAPLAYER PLATFORM WebUiStatic)
target_compile_definitions(WebAppFramework PUBLIC ${ENDIANNESS})

set(WEBAPPFRAMEWORKTESTUTILS_SOURCES
  OpenHome/Web/Tests/TestWebAppFramework.cpp
)

add_library(WebAppFrameworkTestUtils STATIC ${WEBAPPFRAMEWORKTESTUTILS_SOURCES})
target_include_directories(WebAppFrameworkTestUtils PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(WebAppFrameworkTestUtils PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(WebAppFrameworkTestUtils PUBLIC WebAppFramework OHMEDIAPLAYER ohNet PLATFORM)
target_compile_definitions(WebAppFrameworkTestUtils PUBLIC ${ENDIANNESS})

set(CONFIGUI_SOURCES
  OpenHome/Web/ConfigUi/ConfigUi.cpp
  OpenHome/Web/ConfigUi/FileResourceHandler.cpp
  OpenHome/Web/ConfigUi/ConfigUiMediaPlayer.cpp
)

add_library(ConfigUi STATIC ${CONFIGUI_SOURCES})
target_include_directories(ConfigUi PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ConfigUi PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ConfigUi PUBLIC WebAppFramework OHMEDIAPLAYER ohNet PLATFORM)
target_compile_definitions(ConfigUi PUBLIC ${ENDIANNESS})

set(CONFIGUITESTUTILS_SOURCES
  OpenHome/Web/ConfigUi/Tests/TestConfigUi.cpp
)

add_library(ConfigUiTestUtils STATIC ${CONFIGUITESTUTILS_SOURCES})
target_include_directories(ConfigUiTestUtils PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ConfigUiTestUtils PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ConfigUiTestUtils PUBLIC ConfigUi WebAppFramework OHMEDIAPLAYER ohNet PLATFORM)
target_compile_definitions(ConfigUiTestUtils PUBLIC ${ENDIANNESS})

set(OHMEDIAPLAYERTESTUTILS_SOURCES
  OpenHome/Av/Tests/TestStore.cpp
  OpenHome/Av/Tests/RamStore.cpp
  OpenHome/Media/Tests/TestMsg.cpp
  OpenHome/Media/Tests/TestStarvationRamper.cpp
  OpenHome/Media/Tests/TestStreamValidator.cpp
  OpenHome/Media/Tests/TestSeeker.cpp
  OpenHome/Media/Tests/TestSkipper.cpp
  OpenHome/Media/Tests/TestStopper.cpp
  OpenHome/Media/Tests/TestWaiter.cpp
  OpenHome/Media/Tests/TestSupply.cpp
  OpenHome/Media/Tests/TestSupplyAggregator.cpp
  OpenHome/Media/Tests/TestAudioReservoir.cpp
  OpenHome/Media/Tests/TestVariableDelay.cpp
  OpenHome/Media/Tests/TestTrackInspector.cpp
  OpenHome/Media/Tests/TestRamper.cpp
  OpenHome/Media/Tests/TestFlywheelRamper.cpp
  OpenHome/Media/Tests/TestReporter.cpp
  OpenHome/Media/Tests/TestSpotifyReporter.cpp
  OpenHome/Media/Tests/TestPreDriver.cpp
  OpenHome/Media/Tests/TestVolumeRamper.cpp
  OpenHome/Media/Tests/TestMuter.cpp
  OpenHome/Media/Tests/TestMuterVolume.cpp
  OpenHome/Media/Tests/TestDrainer.cpp
  OpenHome/Av/Tests/TestContentProcessor.cpp
  OpenHome/Media/Tests/TestPipeline.cpp
  OpenHome/Media/Tests/TestPipelineConfig.cpp
  OpenHome/Media/Tests/TestProtocolHls.cpp
  OpenHome/Media/Tests/TestProtocolHttp.cpp
  OpenHome/Media/Tests/TestCodec.cpp
  OpenHome/Media/Tests/TestCodecInit.cpp
  OpenHome/Media/Tests/TestCodecController.cpp
  OpenHome/Media/Tests/TestDecodedAudioAggregator.cpp
  OpenHome/Media/Tests/TestContainer.cpp
  OpenHome/Media/Tests/TestSilencer.cpp
  OpenHome/Media/Tests/TestIdProvider.cpp
  OpenHome/Media/Tests/TestFiller.cpp
  OpenHome/Media/Tests/TestToneGenerator.cpp
  OpenHome/Media/Tests/TestMuteManager.cpp
  OpenHome/Media/Tests/TestRewinder.cpp
  OpenHome/Media/Tests/TestShell.cpp
  OpenHome/Media/Tests/TestUriProviderRepeater.cpp
  OpenHome/Av/Tests/TestFriendlyNameManager.cpp
  OpenHome/Av/Tests/TestUdpServer.cpp
  OpenHome/Av/Tests/TestUpnpErrors.cpp
  Generated/CpUpnpOrgAVTransport1.cpp
  Generated/CpUpnpOrgAVTransport1.h
  Generated/CpUpnpOrgConnectionManager1.cpp
  Generated/CpUpnpOrgConnectionManager1.h
  Generated/CpUpnpOrgRenderingControl1.cpp
  Generated/CpUpnpOrgRenderingControl1.h
  OpenHome/Av/Tests/TestTrackDatabase.cpp
  OpenHome/Av/Tests/TestMediaPlayer.cpp
  OpenHome/Av/Tests/TestMediaPlayerOptions.cpp
  OpenHome/Configuration/Tests/ConfigRamStore.cpp
  OpenHome/Configuration/Tests/TestConfigManager.cpp
  OpenHome/Tests/TestPipe.cpp
  OpenHome/Tests/Mock.cpp
  OpenHome/Tests/TestPowerManager.cpp
  OpenHome/Tests/TestSsl.cpp
  OpenHome/Tests/TestSocket.cpp
  OpenHome/Av/Tests/TestCredentials.cpp
  Generated/CpAvOpenhomeOrgCredentials1.cpp
  Generated/CpAvOpenhomeOrgCredentials1.h
  OpenHome/Tests/TestJson.cpp
  OpenHome/Tests/TestThreadPool.cpp
  OpenHome/Av/Tests/TestRaop.cpp
  OpenHome/Av/Tests/TestVolumeManager.cpp
  OpenHome/Av/Tests/TestPins.cpp
  OpenHome/Av/Tests/TestSenderQueue.cpp
  OpenHome/Net/Odp/Tests/TestDvOdp.cpp
)

add_library(ohMediaPlayerTestUtils STATIC ${OHMEDIAPLAYERTESTUTILS_SOURCES})
target_include_directories(ohMediaPlayerTestUtils PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ohMediaPlayerTestUtils PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ohMediaPlayerTestUtils PUBLIC ConfigUi WebAppFramework ohMediaPlayer WebAppFramework CodecFlac CodecWav CodecPcm CodecDsdDsf CodecDsdDff CodecDsdRaw CodecAlac CodecAlacApple CodecAifc CodecAiff CodecAacFdkAdts CodecAacFdkMp4 CodecMp3 CodecVorbis Odp TestFramework ohNet)
target_compile_definitions(ohMediaPlayerTestUtils PUBLIC ${ENDIANNESS})

set(TESTSHELL_SOURCES
  OpenHome/Media/Tests/TestShellMain.cpp
)

add_executable(TestShell ${TESTSHELL_SOURCES})
target_include_directories(TestShell PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestShell PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestShell PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils WebAppFrameworkTestUtils SourcePlaylist SourceRadio SourceRaop SourceSongcast SourceUpnpAv Odp)
target_compile_definitions(TestShell PUBLIC ${ENDIANNESS})

set(TESTMSG_SOURCES
  OpenHome/Media/Tests/TestMsgMain.cpp
)

add_executable(TestMsg ${TESTMSG_SOURCES})
target_include_directories(TestMsg PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestMsg PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMsg PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestMsg PUBLIC ${ENDIANNESS})

set(TESTSTARVATIONRAMPER_SOURCES
  OpenHome/Media/Tests/TestStarvationRamperMain.cpp
)

add_executable(TestStarvationRamper ${TESTSTARVATIONRAMPER_SOURCES})
target_include_directories(TestStarvationRamper PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestStarvationRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStarvationRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestStarvationRamper PUBLIC ${ENDIANNESS})

set(TESTSTREAMVALIDATOR_SOURCES
  OpenHome/Media/Tests/TestStreamValidatorMain.cpp
)

add_executable(TestStreamValidator ${TESTSTREAMVALIDATOR_SOURCES})
target_include_directories(TestStreamValidator PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestStreamValidator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStreamValidator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestStreamValidator PUBLIC ${ENDIANNESS})

set(TESTSEEKER_SOURCES
  OpenHome/Media/Tests/TestSeekerMain.cpp
)

add_executable(TestSeeker ${TESTSEEKER_SOURCES})
target_include_directories(TestSeeker PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSeeker PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSeeker PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSeeker PUBLIC ${ENDIANNESS})

set(TESTSKIPPER_SOURCES
  OpenHome/Media/Tests/TestSkipperMain.cpp
)

add_executable(TestSkipper ${TESTSKIPPER_SOURCES})
target_include_directories(TestSkipper PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSkipper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSkipper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSkipper PUBLIC ${ENDIANNESS})

set(TESTSTOPPER_SOURCES
  OpenHome/Media/Tests/TestStopperMain.cpp
)

add_executable(TestStopper ${TESTSTOPPER_SOURCES})
target_include_directories(TestStopper PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestStopper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStopper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestStopper PUBLIC ${ENDIANNESS})

set(TESTWAITER_SOURCES
  OpenHome/Media/Tests/TestWaiterMain.cpp
)

add_executable(TestWaiter ${TESTWAITER_SOURCES})
target_include_directories(TestWaiter PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestWaiter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestWaiter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestWaiter PUBLIC ${ENDIANNESS})

set(TESTSUPPLY_SOURCES
  OpenHome/Media/Tests/TestSupplyMain.cpp
)

add_executable(TestSupply ${TESTSUPPLY_SOURCES})
target_include_directories(TestSupply PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSupply PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSupply PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSupply PUBLIC ${ENDIANNESS})

set(TESTSUPPLYAGGREGATOR_SOURCES
  OpenHome/Media/Tests/TestSupplyAggregatorMain.cpp
)

add_executable(TestSupplyAggregator ${TESTSUPPLYAGGREGATOR_SOURCES})
target_include_directories(TestSupplyAggregator PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSupplyAggregator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSupplyAggregator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSupplyAggregator PUBLIC ${ENDIANNESS})

set(TESTAUDIORESERVOIR_SOURCES
  OpenHome/Media/Tests/TestAudioReservoirMain.cpp
)

add_executable(TestAudioReservoir ${TESTAUDIORESERVOIR_SOURCES})
target_include_directories(TestAudioReservoir PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestAudioReservoir PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestAudioReservoir PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestAudioReservoir PUBLIC ${ENDIANNESS})

set(TESTVARIABLEDELAY_SOURCES
  OpenHome/Media/Tests/TestVariableDelayMain.cpp
)

add_executable(TestVariableDelay ${TESTVARIABLEDELAY_SOURCES})
target_include_directories(TestVariableDelay PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestVariableDelay PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestVariableDelay PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestVariableDelay PUBLIC ${ENDIANNESS})

set(TESTTRACKINSPECTOR_SOURCES
  OpenHome/Media/Tests/TestTrackInspectorMain.cpp
)

add_executable(TestTrackInspector ${TESTTRACKINSPECTOR_SOURCES})
target_include_directories(TestTrackInspector PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestTrackInspector PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestTrackInspector PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestTrackInspector PUBLIC ${ENDIANNESS})

set(TESTRAMPER_SOURCES
  OpenHome/Media/Tests/TestRamperMain.cpp
)

add_executable(TestRamper ${TESTRAMPER_SOURCES})
target_include_directories(TestRamper PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestRamper PUBLIC ${ENDIANNESS})

set(TESTFLYWHEELRAMPERMANUAL_SOURCES
  OpenHome/Media/Tests/TestFlywheelRamperManualMain.cpp
)

add_executable(TestFlywheelRamperManual ${TESTFLYWHEELRAMPERMANUAL_SOURCES})
target_include_directories(TestFlywheelRamperManual PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestFlywheelRamperManual PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestFlywheelRamperManual PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestFlywheelRamperManual PUBLIC ${ENDIANNESS})

set(TESTFLYWHEELRAMPER_SOURCES
  OpenHome/Media/Tests/TestFlywheelRamperMain.cpp
)

add_executable(TestFlywheelRamper ${TESTFLYWHEELRAMPER_SOURCES})
target_include_directories(TestFlywheelRamper PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestFlywheelRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestFlywheelRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestFlywheelRamper PUBLIC ${ENDIANNESS})

set(TESTREPORTER_SOURCES
  OpenHome/Media/Tests/TestReporterMain.cpp
)

add_executable(TestReporter ${TESTREPORTER_SOURCES})
target_include_directories(TestReporter PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestReporter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestReporter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestReporter PUBLIC ${ENDIANNESS})

set(TESTSPOTIFYREPORTER_SOURCES
  OpenHome/Media/Tests/TestSpotifyReporterMain.cpp
)

add_executable(TestSpotifyReporter ${TESTSPOTIFYREPORTER_SOURCES})
target_include_directories(TestSpotifyReporter PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSpotifyReporter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSpotifyReporter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSpotifyReporter PUBLIC ${ENDIANNESS})

set(TESTPREDRIVER_SOURCES
  OpenHome/Media/Tests/TestPreDriverMain.cpp
)

add_executable(TestPreDriver ${TESTPREDRIVER_SOURCES})
target_include_directories(TestPreDriver PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestPreDriver PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPreDriver PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestPreDriver PUBLIC ${ENDIANNESS})

set(TESTVOLUMERAMPER_SOURCES
  OpenHome/Media/Tests/TestVolumeRamperMain.cpp
)

add_executable(TestVolumeRamper ${TESTVOLUMERAMPER_SOURCES})
target_include_directories(TestVolumeRamper PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestVolumeRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestVolumeRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestVolumeRamper PUBLIC ${ENDIANNESS})

set(TESTMUTER_SOURCES
  OpenHome/Media/Tests/TestMuterMain.cpp
)

add_executable(TestMuter ${TESTMUTER_SOURCES})
target_include_directories(TestMuter PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestMuter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMuter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestMuter PUBLIC ${ENDIANNESS})

set(TESTMUTERVOLUME_SOURCES
  OpenHome/Media/Tests/TestMuterVolumeMain.cpp
)

add_executable(TestMuterVolume ${TESTMUTERVOLUME_SOURCES})
target_include_directories(TestMuterVolume PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestMuterVolume PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMuterVolume PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestMuterVolume PUBLIC ${ENDIANNESS})

set(TESTDRAINER_SOURCES
  OpenHome/Media/Tests/TestDrainerMain.cpp
)

add_executable(TestDrainer ${TESTDRAINER_SOURCES})
target_include_directories(TestDrainer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestDrainer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestDrainer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestDrainer PUBLIC ${ENDIANNESS})

set(TESTCONTENTPROCESSOR_SOURCES
  OpenHome/Av/Tests/TestContentProcessorMain.cpp
)

add_executable(TestContentProcessor ${TESTCONTENTPROCESSOR_SOURCES})
target_include_directories(TestContentProcessor PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestContentProcessor PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestContentProcessor PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceRadio)
target_compile_definitions(TestContentProcessor PUBLIC ${ENDIANNESS})

set(TESTPIPELINE_SOURCES
  OpenHome/Media/Tests/TestPipelineMain.cpp
)

add_executable(TestPipeline ${TESTPIPELINE_SOURCES})
target_include_directories(TestPipeline PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestPipeline PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPipeline PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestPipeline PUBLIC ${ENDIANNESS})

set(TESTPIPELINECONFIG_SOURCES
  OpenHome/Media/Tests/TestPipelineConfigMain.cpp
)

add_executable(TestPipelineConfig ${TESTPIPELINECONFIG_SOURCES})
target_include_directories(TestPipelineConfig PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestPipelineConfig PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPipelineConfig PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestPipelineConfig PUBLIC ${ENDIANNESS})

set(TESTSTORE_SOURCES
  OpenHome/Av/Tests/TestStoreMain.cpp
)

add_executable(TestStore ${TESTSTORE_SOURCES})
target_include_directories(TestStore PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestStore PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStore PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestStore PUBLIC ${ENDIANNESS})

set(TESTPROTOCOLHLS_SOURCES
  OpenHome/Media/Tests/TestProtocolHlsMain.cpp
)

add_executable(TestProtocolHls ${TESTPROTOCOLHLS_SOURCES})
target_include_directories(TestProtocolHls PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestProtocolHls PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestProtocolHls PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestProtocolHls PUBLIC ${ENDIANNESS})

set(TESTPROTOCOLHTTP_SOURCES
  OpenHome/Media/Tests/TestProtocolHttpMain.cpp
)

add_executable(TestProtocolHttp ${TESTPROTOCOLHTTP_SOURCES})
target_include_directories(TestProtocolHttp PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestProtocolHttp PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestProtocolHttp PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestProtocolHttp PUBLIC ${ENDIANNESS})

set(TESTCODEC_SOURCES
  OpenHome/Media/Tests/TestCodecMain.cpp
)

add_executable(TestCodec ${TESTCODEC_SOURCES})
target_include_directories(TestCodec PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestCodec PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCodec PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestCodec PUBLIC ${ENDIANNESS})

set(TESTCODECINTERACTIVE_SOURCES
  OpenHome/Media/Tests/TestCodecInteractiveMain.cpp
)

add_executable(TestCodecInteractive ${TESTCODECINTERACTIVE_SOURCES})
target_include_directories(TestCodecInteractive PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestCodecInteractive PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCodecInteractive PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestCodecInteractive PUBLIC ${ENDIANNESS})

set(TESTCODECCONTROLLER_SOURCES
  OpenHome/Media/Tests/TestCodecControllerMain.cpp
)

add_executable(TestCodecController ${TESTCODECCONTROLLER_SOURCES})
target_include_directories(TestCodecController PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestCodecController PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCodecController PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestCodecController PUBLIC ${ENDIANNESS})

set(TESTDECODEDAUDIOAGGREGATOR_SOURCES
  OpenHome/Media/Tests/TestDecodedAudioAggregatorMain.cpp
)

add_executable(TestDecodedAudioAggregator ${TESTDECODEDAUDIOAGGREGATOR_SOURCES})
target_include_directories(TestDecodedAudioAggregator PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestDecodedAudioAggregator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestDecodedAudioAggregator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestDecodedAudioAggregator PUBLIC ${ENDIANNESS})

set(TESTCONTAINER_SOURCES
  OpenHome/Media/Tests/TestContainerMain.cpp
)

add_executable(TestContainer ${TESTCONTAINER_SOURCES})
target_include_directories(TestContainer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestContainer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestContainer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestContainer PUBLIC ${ENDIANNESS})

set(TESTSILENCER_SOURCES
  OpenHome/Media/Tests/TestSilencerMain.cpp
)

add_executable(TestSilencer ${TESTSILENCER_SOURCES})
target_include_directories(TestSilencer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSilencer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSilencer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSilencer PUBLIC ${ENDIANNESS})

set(TESTIDPROVIDER_SOURCES
  OpenHome/Media/Tests/TestIdProviderMain.cpp
)

add_executable(TestIdProvider ${TESTIDPROVIDER_SOURCES})
target_include_directories(TestIdProvider PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestIdProvider PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestIdProvider PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestIdProvider PUBLIC ${ENDIANNESS})

set(TESTFILLER_SOURCES
  OpenHome/Media/Tests/TestFillerMain.cpp
)

add_executable(TestFiller ${TESTFILLER_SOURCES})
target_include_directories(TestFiller PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestFiller PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestFiller PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestFiller PUBLIC ${ENDIANNESS})

set(TESTTONEGENERATOR_SOURCES
  OpenHome/Media/Tests/TestToneGeneratorMain.cpp
)

add_executable(TestToneGenerator ${TESTTONEGENERATOR_SOURCES})
target_include_directories(TestToneGenerator PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestToneGenerator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestToneGenerator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestToneGenerator PUBLIC ${ENDIANNESS})

set(TESTMUTEMANAGER_SOURCES
  OpenHome/Media/Tests/TestMuteManagerMain.cpp
)

add_executable(TestMuteManager ${TESTMUTEMANAGER_SOURCES})
target_include_directories(TestMuteManager PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestMuteManager PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMuteManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestMuteManager PUBLIC ${ENDIANNESS})

set(TESTREWINDER_SOURCES
  OpenHome/Media/Tests/TestRewinderMain.cpp
)

add_executable(TestRewinder ${TESTREWINDER_SOURCES})
target_include_directories(TestRewinder PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestRewinder PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestRewinder PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestRewinder PUBLIC ${ENDIANNESS})

set(TESTUDPSERVER_SOURCES
  OpenHome/Av/Tests/TestUdpServerMain.cpp
)

add_executable(TestUdpServer ${TESTUDPSERVER_SOURCES})
target_include_directories(TestUdpServer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestUdpServer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestUdpServer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceRaop)
target_compile_definitions(TestUdpServer PUBLIC ${ENDIANNESS})

set(TESTUPNPERRORS_SOURCES
  OpenHome/Av/Tests/TestUpnpErrorsMain.cpp
)

add_executable(TestUpnpErrors ${TESTUPNPERRORS_SOURCES})
target_include_directories(TestUpnpErrors PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestUpnpErrors PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestUpnpErrors PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceUpnpAv)
target_compile_definitions(TestUpnpErrors PUBLIC ${ENDIANNESS})

set(TESTTRACKDATABASE_SOURCES
  OpenHome/Av/Tests/TestTrackDatabaseMain.cpp
)

add_executable(TestTrackDatabase ${TESTTRACKDATABASE_SOURCES})
target_include_directories(TestTrackDatabase PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestTrackDatabase PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestTrackDatabase PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist)
target_compile_definitions(TestTrackDatabase PUBLIC ${ENDIANNESS})

set(TESTURIPROVIDERREPEATER_SOURCES
  OpenHome/Media/Tests/TestUriProviderRepeaterMain.cpp
)

add_executable(TestUriProviderRepeater ${TESTURIPROVIDERREPEATER_SOURCES})
target_include_directories(TestUriProviderRepeater PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestUriProviderRepeater PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestUriProviderRepeater PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceUpnpAv)
target_compile_definitions(TestUriProviderRepeater PUBLIC ${ENDIANNESS})

set(TESTMEDIAPLAYER_SOURCES
  OpenHome/Av/Tests/TestMediaPlayerMain.cpp
)

add_executable(TestMediaPlayer ${TESTMEDIAPLAYER_SOURCES})
target_include_directories(TestMediaPlayer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestMediaPlayer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMediaPlayer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist SourceRadio SourceSongcast SourceScd SourceRaop SourceUpnpAv WebAppFramework ConfigUi)
target_compile_definitions(TestMediaPlayer PUBLIC ${ENDIANNESS})

set(TESTCONFIGMANAGER_SOURCES
  OpenHome/Configuration/Tests/TestConfigManagerMain.cpp
)

add_executable(TestConfigManager ${TESTCONFIGMANAGER_SOURCES})
target_include_directories(TestConfigManager PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestConfigManager PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestConfigManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestConfigManager PUBLIC ${ENDIANNESS})

set(TESTPOWERMANAGER_SOURCES
  OpenHome/Tests/TestPowerManagerMain.cpp
)

add_executable(TestPowerManager ${TESTPOWERMANAGER_SOURCES})
target_include_directories(TestPowerManager PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestPowerManager PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPowerManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestPowerManager PUBLIC ${ENDIANNESS})

set(TESTSSL_SOURCES
  OpenHome/Tests/TestSslMain.cpp
)

add_executable(TestSsl ${TESTSSL_SOURCES})
target_include_directories(TestSsl PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSsl PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSsl PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSsl PUBLIC ${ENDIANNESS})

set(TESTSOCKET_SOURCES
  OpenHome/Tests/TestSocketMain.cpp
)

add_executable(TestSocket ${TESTSOCKET_SOURCES})
target_include_directories(TestSocket PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSocket PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSocket PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestSocket PUBLIC ${ENDIANNESS})

set(TESTCREDENTIALS_SOURCES
  OpenHome/Av/Tests/TestCredentialsMain.cpp
)

add_executable(TestCredentials ${TESTCREDENTIALS_SOURCES})
target_include_directories(TestCredentials PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestCredentials PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCredentials PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestCredentials PUBLIC ${ENDIANNESS})

set(TESTHTTPS_SOURCES
  OpenHome/Tests/TestHttps.cpp
)

add_executable(TestHttps ${TESTHTTPS_SOURCES})
target_include_directories(TestHttps PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestHttps PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestHttps PUBLIC ohNet ohMediaPlayer)
target_compile_definitions(TestHttps PUBLIC ${ENDIANNESS})

set(TESTFRIENDLYNAMEMANAGER_SOURCES
  OpenHome/Av/Tests/TestFriendlyNameManagerMain.cpp
)

add_executable(TestFriendlyNameManager ${TESTFRIENDLYNAMEMANAGER_SOURCES})
target_include_directories(TestFriendlyNameManager PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestFriendlyNameManager PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestFriendlyNameManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestFriendlyNameManager PUBLIC ${ENDIANNESS})

set(TESTTIDAL_SOURCES
  OpenHome/Av/Tidal/TestTidal.cpp
)

add_executable(TestTidal ${TESTTIDAL_SOURCES})
target_include_directories(TestTidal PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestTidal PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestTidal PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist)
target_compile_definitions(TestTidal PUBLIC ${ENDIANNESS})

set(TESTJSON_SOURCES
  OpenHome/Tests/TestJsonMain.cpp
)

add_executable(TestJson ${TESTJSON_SOURCES})
target_include_directories(TestJson PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestJson PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestJson PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestJson PUBLIC ${ENDIANNESS})

set(TESTTHREADPOOL_SOURCES
  OpenHome/Tests/TestThreadPoolMain.cpp
)

add_executable(TestThreadPool ${TESTTHREADPOOL_SOURCES})
target_include_directories(TestThreadPool PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestThreadPool PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestThreadPool PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestThreadPool PUBLIC ${ENDIANNESS})

set(TESTQOBUZ_SOURCES
  OpenHome/Av/Qobuz/TestQobuz.cpp
)

add_executable(TestQobuz ${TESTQOBUZ_SOURCES})
target_include_directories(TestQobuz PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestQobuz PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestQobuz PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist)
target_compile_definitions(TestQobuz PUBLIC ${ENDIANNESS})

set(TESTNTPCLIENT_SOURCES
  OpenHome/Tests/TestNtpClient.cpp
)

add_executable(TestNtpClient ${TESTNTPCLIENT_SOURCES})
target_include_directories(TestNtpClient PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestNtpClient PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestNtpClient PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist)
target_compile_definitions(TestNtpClient PUBLIC ${ENDIANNESS})

set(TESTWEBAPPFRAMEWORK_SOURCES
  OpenHome/Web/Tests/TestWebAppFrameworkMain.cpp
)

add_executable(TestWebAppFramework ${TESTWEBAPPFRAMEWORK_SOURCES})
target_include_directories(TestWebAppFramework PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestWebAppFramework PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestWebAppFramework PUBLIC ohNet PLATFORM WebAppFrameworkTestUtils WebAppFramework ohMediaPlayer)
target_compile_definitions(TestWebAppFramework PUBLIC ${ENDIANNESS})

set(TESTCONFIGUI_SOURCES
  OpenHome/Web/ConfigUi/Tests/TestConfigUiMain.cpp
)

add_executable(TestConfigUi ${TESTCONFIGUI_SOURCES})
target_include_directories(TestConfigUi PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestConfigUi PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestConfigUi PUBLIC ohNet PLATFORM ConfigUiTestUtils WebAppFrameworkTestUtils ConfigUi WebAppFramework ohMediaPlayerTestUtils SourcePlaylist SourceRadio SourceSongcast SourceScd SourceRaop SourceUpnpAv ohMediaPlayer)
target_compile_definitions(TestConfigUi PUBLIC ${ENDIANNESS})

set(TESTRAOP_SOURCES
  OpenHome/Av/Tests/TestRaopMain.cpp
)

add_executable(TestRaop ${TESTRAOP_SOURCES})
target_include_directories(TestRaop PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestRaop PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestRaop PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceRaop)
target_compile_definitions(TestRaop PUBLIC ${ENDIANNESS})

set(TESTVOLUMEMANAGER_SOURCES
  OpenHome/Av/Tests/TestVolumeManagerMain.cpp
)

add_executable(TestVolumeManager ${TESTVOLUMEMANAGER_SOURCES})
target_include_directories(TestVolumeManager PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestVolumeManager PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestVolumeManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestVolumeManager PUBLIC ${ENDIANNESS})

set(TESTPINS_SOURCES
  OpenHome/Av/Tests/TestPinsMain.cpp
)

add_executable(TestPins ${TESTPINS_SOURCES})
target_include_directories(TestPins PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestPins PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPins PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils)
target_compile_definitions(TestPins PUBLIC ${ENDIANNESS})

set(TESTSENDERQUEUE_SOURCES
  OpenHome/Av/Tests/TestSenderQueueMain.cpp
)

add_executable(TestSenderQueue ${TESTSENDERQUEUE_SOURCES})
target_include_directories(TestSenderQueue PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestSenderQueue PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSenderQueue PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceSongcast)
target_compile_definitions(TestSenderQueue PUBLIC ${ENDIANNESS})

set(TESTDVODP_SOURCES
  OpenHome/Net/Odp/Tests/TestDvOdpMain.cpp
)

add_executable(TestDvOdp ${TESTDVODP_SOURCES})
target_include_directories(TestDvOdp PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestDvOdp PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestDvOdp PUBLIC ohNet Odp ohMediaPlayerTestUtils)
target_compile_definitions(TestDvOdp PUBLIC ${ENDIANNESS})

set(TESTCPDEVICELISTODP_SOURCES
  OpenHome/Net/Odp/Tests/TestCpDeviceListOdp.cpp
)

add_executable(TestCpDeviceListOdp ${TESTCPDEVICELISTODP_SOURCES})
target_include_directories(TestCpDeviceListOdp PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(TestCpDeviceListOdp PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCpDeviceListOdp PUBLIC ohNet Odp ohMediaPlayerTestUtils)
target_compile_definitions(TestCpDeviceListOdp PUBLIC ${ENDIANNESS})

set(SCDSENDER_SOURCES
  OpenHome/Av/Scd/ScdMsg.cpp
  OpenHome/Av/Scd/Sender/ScdSupply.cpp
  OpenHome/Av/Scd/Sender/ScdServer.cpp
)

add_library(ScdSender STATIC ${SCDSENDER_SOURCES})
target_include_directories(ScdSender PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ScdSender PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ScdSender PUBLIC ohNet ohMediaPlayer)
target_compile_definitions(ScdSender PUBLIC ${ENDIANNESS})
