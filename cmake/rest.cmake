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
target_include_directories(Odp PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(SourcePlaylist PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(SourceRadio PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(SourceSongcast PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(SourceScd PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(SourceRaop PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(SourceRaop PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(SourceRaop PUBLIC ohNet ohMediaPlayer CodecAlacAppleBase ${CONAN_LIBS})
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
target_include_directories(SourceUpnpAv PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(Podcast PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecWav PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecPcm PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecDsdDsf PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecDsdDff PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecDsdRaw PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecAiffBase PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecAifc PUBLIC ${CMAKE_SOURCE_DIR})
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
target_include_directories(CodecAiff PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAiff PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAiff PUBLIC CodecAiffBase ohNet)
target_compile_definitions(CodecAiff PUBLIC ${ENDIANNESS})

set(CODECFLAC_SOURCES
  OpenHome/Media/Codec/Flac.cpp
)

add_library(CodecFlac STATIC ${CODECFLAC_SOURCES})
target_include_directories(CodecFlac PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecFlac PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecFlac PUBLIC ${CONAN_LIBS} ohNet) # libFlac libOgg
target_compile_definitions(CodecFlac PUBLIC ${ENDIANNESS})

set(CODECALACAPPLEBASE_SOURCES
  OpenHome/Media/Codec/AlacAppleBase.cpp
)

add_library(CodecAlacAppleBase STATIC ${CODECALACAPPLEBASE_SOURCES})
target_include_directories(CodecAlacAppleBase PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAlacAppleBase PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAlacAppleBase PUBLIC ${CONAN_LIBS} ohNet ohMediaPlayer) # apple_alac
target_compile_definitions(CodecAlacAppleBase PUBLIC ${ENDIANNESS})

set(CODECALACAPPLE_SOURCES
  OpenHome/Media/Codec/AlacApple.cpp
)

add_library(CodecAlacApple STATIC ${CODECALACAPPLE_SOURCES})
target_include_directories(CodecAlacApple PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAlacApple PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAlacApple PUBLIC CodecAlacAppleBase ohNet)
target_compile_definitions(CodecAlacApple PUBLIC ${ENDIANNESS})

set(CODECAACFDKBASE_SOURCES
  OpenHome/Media/Codec/AacFdkBase.cpp
)

add_library(CodecAacFdkBase STATIC ${CODECAACFDKBASE_SOURCES})
target_include_directories(CodecAacFdkBase PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAacFdkBase PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAacFdkBase PUBLIC ${CONAN_LIBS} ohNet) # libAacFdk
target_compile_definitions(CodecAacFdkBase PUBLIC ${ENDIANNESS})

set(CODECAACFDKMP4_SOURCES
  OpenHome/Media/Codec/AacFdkMp4.cpp
)

add_library(CodecAacFdkMp4 STATIC ${CODECAACFDKMP4_SOURCES})
target_include_directories(CodecAacFdkMp4 PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecAacFdkMp4 PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecAacFdkMp4 PUBLIC ohNetCore ohNet CodecAacFdkBase)
target_compile_definitions(CodecAacFdkMp4 PUBLIC ${ENDIANNESS})

set(CODECAACFDKADTS_SOURCES
  OpenHome/Media/Codec/AacFdkAdts.cpp
)

add_library(CodecAacFdkAdts STATIC ${CODECAACFDKADTS_SOURCES})
target_include_directories(CodecAacFdkAdts PUBLIC ${CMAKE_SOURCE_DIR})
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
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/version.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/fixed.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/bit.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/timer.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/stream.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/frame.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/synth.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/decoder.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/layer12.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/layer3.c.99.o
  ${PRECOMPILED_3RD_PARTY}/libmad-0.15.1b/huffman.c.99.o
)

add_library(CodecMp3 STATIC ${CODECMP3_SOURCES})
target_include_directories(CodecMp3 PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecMp3 PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecMp3 PUBLIC ohNet)
target_compile_definitions(CodecMp3 PUBLIC ${ENDIANNESS})

set(CODECVORBIS_SOURCES
  OpenHome/Media/Codec/Vorbis.cpp
  ${PRECOMPILED_3RD_PARTY}/Tremor/block.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/codebook.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/floor0.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/floor1.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/info.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/mapping0.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/mdct.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/registry.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/res012.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/sharedbook.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/synthesis.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/vorbisfile.c.100.o
  ${PRECOMPILED_3RD_PARTY}/Tremor/window.c.100.o
)

add_library(CodecVorbis STATIC ${CODECVORBIS_SOURCES})
target_include_directories(CodecVorbis PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(CodecVorbis PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(CodecVorbis PUBLIC ${CONAN_LIBS} ohNet) #libOgg
target_compile_definitions(CodecVorbis PUBLIC ${ENDIANNESS})

set(WEBAPPFRAMEWORK_SOURCES
  OpenHome/Web/ResourceHandler.cpp
  OpenHome/Web/WebAppFramework.cpp
)

add_library(WebAppFramework STATIC ${WEBAPPFRAMEWORK_SOURCES})
target_include_directories(WebAppFramework PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(WebAppFramework PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
# target_link_libraries(WebAppFramework PUBLIC ohNetCore ohNet)
target_link_libraries(WebAppFramework PUBLIC ohNet)
target_compile_definitions(WebAppFramework PUBLIC ${ENDIANNESS})

# Copy ConfigUi resources to 'build' and 'install/bin'.
# file(
#   COPY ${CMAKE_SOURCE_DIR}/OpenHome/Web/ConfigUi/res
#   DESTINATION ${CMAKE_BINARY_DIR}
# )

set(WEBAPPFRAMEWORKTESTUTILS_SOURCES
  OpenHome/Web/Tests/TestWebAppFramework.cpp
)

add_library(WebAppFrameworkTestUtils STATIC ${WEBAPPFRAMEWORKTESTUTILS_SOURCES})
target_include_directories(WebAppFrameworkTestUtils PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(WebAppFrameworkTestUtils PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(WebAppFrameworkTestUtils PUBLIC WebAppFramework ohNet)
target_compile_definitions(WebAppFrameworkTestUtils PUBLIC ${ENDIANNESS})

set(CONFIGUI_SOURCES
  OpenHome/Web/ConfigUi/ConfigUi.cpp
  OpenHome/Web/ConfigUi/FileResourceHandler.cpp
  OpenHome/Web/ConfigUi/ConfigUiMediaPlayer.cpp
)

add_library(ConfigUi STATIC ${CONFIGUI_SOURCES})
target_include_directories(ConfigUi PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(ConfigUi PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ConfigUi PUBLIC WebAppFramework ohNet)
target_compile_definitions(ConfigUi PUBLIC ${ENDIANNESS})

set(CONFIGUITESTUTILS_SOURCES
  OpenHome/Web/ConfigUi/Tests/TestConfigUi.cpp
)

add_library(ConfigUiTestUtils STATIC ${CONFIGUITESTUTILS_SOURCES})
target_include_directories(ConfigUiTestUtils PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(ConfigUiTestUtils PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ConfigUiTestUtils PUBLIC ConfigUi WebAppFramework ohNet ${CONAN_LIBS})
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
target_include_directories(ohMediaPlayerTestUtils PRIVATE
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ohMediaPlayerTestUtils PRIVATE ConfigUi WebAppFramework ohMediaPlayer WebAppFramework
  CodecFlac CodecWav CodecPcm CodecDsdDsf CodecDsdDff CodecDsdRaw CodecAlacApple CodecAifc CodecAiff CodecAacFdkAdts
  CodecAacFdkMp4 CodecMp3 CodecVorbis Odp TestFramework ohNet ${CONAN_LIBS})
target_compile_definitions(ohMediaPlayerTestUtils PRIVATE ${ENDIANNESS})

set(TESTSHELL_SOURCES
  OpenHome/Media/Tests/TestShellMain.cpp
)

add_executable(TestShell ${TESTSHELL_SOURCES})
target_include_directories(TestShell PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestShell PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)

target_link_libraries(TestShell PUBLIC
  ohMediaPlayer ohMediaPlayerTestUtils WebAppFrameworkTestUtils SourcePlaylist SourceRadio SourceRaop
  SourceSongcast SourceUpnpAv Odp ohNetCore ohMediaPlayer ohPipeline)
target_compile_definitions(TestShell PUBLIC ${ENDIANNESS})

set(TESTMSG_SOURCES
  OpenHome/Media/Tests/TestMsgMain.cpp
)

add_executable(TestMsg ${TESTMSG_SOURCES})
target_include_directories(TestMsg PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestMsg PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMsg PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestMsg PUBLIC ${ENDIANNESS})

set(TESTSTARVATIONRAMPER_SOURCES
  OpenHome/Media/Tests/TestStarvationRamperMain.cpp
)

add_executable(TestStarvationRamper ${TESTSTARVATIONRAMPER_SOURCES})
target_include_directories(TestStarvationRamper PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestStarvationRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStarvationRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestStarvationRamper PUBLIC ${ENDIANNESS})

set(TESTSTREAMVALIDATOR_SOURCES
  OpenHome/Media/Tests/TestStreamValidatorMain.cpp
)

add_executable(TestStreamValidator ${TESTSTREAMVALIDATOR_SOURCES})
target_include_directories(TestStreamValidator PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestStreamValidator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStreamValidator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestStreamValidator PUBLIC ${ENDIANNESS})

set(TESTSEEKER_SOURCES
  OpenHome/Media/Tests/TestSeekerMain.cpp
)

add_executable(TestSeeker ${TESTSEEKER_SOURCES})
target_include_directories(TestSeeker PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSeeker PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSeeker PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSeeker PUBLIC ${ENDIANNESS})

set(TESTSKIPPER_SOURCES
  OpenHome/Media/Tests/TestSkipperMain.cpp
)

add_executable(TestSkipper ${TESTSKIPPER_SOURCES})
target_include_directories(TestSkipper PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSkipper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSkipper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSkipper PUBLIC ${ENDIANNESS})

set(TESTSTOPPER_SOURCES
  OpenHome/Media/Tests/TestStopperMain.cpp
)

add_executable(TestStopper ${TESTSTOPPER_SOURCES})
target_include_directories(TestStopper PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestStopper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStopper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestStopper PUBLIC ${ENDIANNESS})

set(TESTWAITER_SOURCES
  OpenHome/Media/Tests/TestWaiterMain.cpp
)

add_executable(TestWaiter ${TESTWAITER_SOURCES})
target_include_directories(TestWaiter PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestWaiter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestWaiter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestWaiter PUBLIC ${ENDIANNESS})

set(TESTSUPPLY_SOURCES
  OpenHome/Media/Tests/TestSupplyMain.cpp
)

add_executable(TestSupply ${TESTSUPPLY_SOURCES})
target_include_directories(TestSupply PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSupply PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSupply PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSupply PUBLIC ${ENDIANNESS})

set(TESTSUPPLYAGGREGATOR_SOURCES
  OpenHome/Media/Tests/TestSupplyAggregatorMain.cpp
)

add_executable(TestSupplyAggregator ${TESTSUPPLYAGGREGATOR_SOURCES})
target_include_directories(TestSupplyAggregator PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSupplyAggregator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSupplyAggregator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSupplyAggregator PUBLIC ${ENDIANNESS})

set(TESTAUDIORESERVOIR_SOURCES
  OpenHome/Media/Tests/TestAudioReservoirMain.cpp
)

add_executable(TestAudioReservoir ${TESTAUDIORESERVOIR_SOURCES})
target_include_directories(TestAudioReservoir PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestAudioReservoir PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestAudioReservoir PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestAudioReservoir PUBLIC ${ENDIANNESS})

set(TESTVARIABLEDELAY_SOURCES
  OpenHome/Media/Tests/TestVariableDelayMain.cpp
)

add_executable(TestVariableDelay ${TESTVARIABLEDELAY_SOURCES})
target_include_directories(TestVariableDelay PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestVariableDelay PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestVariableDelay PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestVariableDelay PUBLIC ${ENDIANNESS})

set(TESTTRACKINSPECTOR_SOURCES
  OpenHome/Media/Tests/TestTrackInspectorMain.cpp
)

add_executable(TestTrackInspector ${TESTTRACKINSPECTOR_SOURCES})
target_include_directories(TestTrackInspector PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestTrackInspector PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestTrackInspector PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestTrackInspector PUBLIC ${ENDIANNESS})

set(TESTRAMPER_SOURCES
  OpenHome/Media/Tests/TestRamperMain.cpp
)

add_executable(TestRamper ${TESTRAMPER_SOURCES})
target_include_directories(TestRamper PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestRamper PUBLIC ${ENDIANNESS})

set(TESTFLYWHEELRAMPERMANUAL_SOURCES
  OpenHome/Media/Tests/TestFlywheelRamperManualMain.cpp
)

add_executable(TestFlywheelRamperManual ${TESTFLYWHEELRAMPERMANUAL_SOURCES})
target_include_directories(TestFlywheelRamperManual PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestFlywheelRamperManual PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestFlywheelRamperManual PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestFlywheelRamperManual PUBLIC ${ENDIANNESS})

set(TESTFLYWHEELRAMPER_SOURCES
  OpenHome/Media/Tests/TestFlywheelRamperMain.cpp
)

add_executable(TestFlywheelRamper ${TESTFLYWHEELRAMPER_SOURCES})
target_include_directories(TestFlywheelRamper PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestFlywheelRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestFlywheelRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestFlywheelRamper PUBLIC ${ENDIANNESS})

set(TESTREPORTER_SOURCES
  OpenHome/Media/Tests/TestReporterMain.cpp
)

add_executable(TestReporter ${TESTREPORTER_SOURCES})
target_include_directories(TestReporter PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestReporter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestReporter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestReporter PUBLIC ${ENDIANNESS})

set(TESTSPOTIFYREPORTER_SOURCES
  OpenHome/Media/Tests/TestSpotifyReporterMain.cpp
)

add_executable(TestSpotifyReporter ${TESTSPOTIFYREPORTER_SOURCES})
target_include_directories(TestSpotifyReporter PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSpotifyReporter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSpotifyReporter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSpotifyReporter PUBLIC ${ENDIANNESS})

set(TESTPREDRIVER_SOURCES
  OpenHome/Media/Tests/TestPreDriverMain.cpp
)

add_executable(TestPreDriver ${TESTPREDRIVER_SOURCES})
target_include_directories(TestPreDriver PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestPreDriver PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPreDriver PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestPreDriver PUBLIC ${ENDIANNESS})

set(TESTVOLUMERAMPER_SOURCES
  OpenHome/Media/Tests/TestVolumeRamperMain.cpp
)

add_executable(TestVolumeRamper ${TESTVOLUMERAMPER_SOURCES})
target_include_directories(TestVolumeRamper PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestVolumeRamper PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestVolumeRamper PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestVolumeRamper PUBLIC ${ENDIANNESS})

set(TESTMUTER_SOURCES
  OpenHome/Media/Tests/TestMuterMain.cpp
)

add_executable(TestMuter ${TESTMUTER_SOURCES})
target_include_directories(TestMuter PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestMuter PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMuter PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestMuter PUBLIC ${ENDIANNESS})

set(TESTMUTERVOLUME_SOURCES
  OpenHome/Media/Tests/TestMuterVolumeMain.cpp
)

add_executable(TestMuterVolume ${TESTMUTERVOLUME_SOURCES})
target_include_directories(TestMuterVolume PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestMuterVolume PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMuterVolume PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestMuterVolume PUBLIC ${ENDIANNESS})

set(TESTDRAINER_SOURCES
  OpenHome/Media/Tests/TestDrainerMain.cpp
)

add_executable(TestDrainer ${TESTDRAINER_SOURCES})
target_include_directories(TestDrainer PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestDrainer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestDrainer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestDrainer PUBLIC ${ENDIANNESS})

set(TESTCONTENTPROCESSOR_SOURCES
  OpenHome/Av/Tests/TestContentProcessorMain.cpp
)

add_executable(TestContentProcessor ${TESTCONTENTPROCESSOR_SOURCES})
target_include_directories(TestContentProcessor PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestContentProcessor PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestContentProcessor PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceRadio ohPipeline)
target_compile_definitions(TestContentProcessor PUBLIC ${ENDIANNESS})

set(TESTPIPELINE_SOURCES
  OpenHome/Media/Tests/TestPipelineMain.cpp
)

add_executable(TestPipeline ${TESTPIPELINE_SOURCES})
target_include_directories(TestPipeline PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestPipeline PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPipeline PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestPipeline PUBLIC ${ENDIANNESS})

set(TESTPIPELINECONFIG_SOURCES
  OpenHome/Media/Tests/TestPipelineConfigMain.cpp
)

add_executable(TestPipelineConfig ${TESTPIPELINECONFIG_SOURCES})
target_include_directories(TestPipelineConfig PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestPipelineConfig PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPipelineConfig PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestPipelineConfig PUBLIC ${ENDIANNESS})

set(TESTSTORE_SOURCES
  OpenHome/Av/Tests/TestStoreMain.cpp
)

add_executable(TestStore ${TESTSTORE_SOURCES})
target_include_directories(TestStore PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestStore PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestStore PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestStore PUBLIC ${ENDIANNESS})

set(TESTPROTOCOLHLS_SOURCES
  OpenHome/Media/Tests/TestProtocolHlsMain.cpp
)

add_executable(TestProtocolHls ${TESTPROTOCOLHLS_SOURCES})
target_include_directories(TestProtocolHls PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestProtocolHls PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestProtocolHls PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestProtocolHls PUBLIC ${ENDIANNESS})

set(TESTPROTOCOLHTTP_SOURCES
  OpenHome/Media/Tests/TestProtocolHttpMain.cpp
)

add_executable(TestProtocolHttp ${TESTPROTOCOLHTTP_SOURCES})
target_include_directories(TestProtocolHttp PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestProtocolHttp PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestProtocolHttp PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestProtocolHttp PUBLIC ${ENDIANNESS})

set(TESTCODEC_SOURCES
  OpenHome/Media/Tests/TestCodecMain.cpp
)

add_executable(TestCodec ${TESTCODEC_SOURCES})
target_include_directories(TestCodec PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestCodec PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCodec PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestCodec PUBLIC ${ENDIANNESS})

set(TESTCODECINTERACTIVE_SOURCES
  OpenHome/Media/Tests/TestCodecInteractiveMain.cpp
)

add_executable(TestCodecInteractive ${TESTCODECINTERACTIVE_SOURCES})
target_include_directories(TestCodecInteractive PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestCodecInteractive PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCodecInteractive PUBLIC CodecAacFdkMp4 ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestCodecInteractive PUBLIC ${ENDIANNESS})

set(TESTCODECCONTROLLER_SOURCES
  OpenHome/Media/Tests/TestCodecControllerMain.cpp
)

add_executable(TestCodecController ${TESTCODECCONTROLLER_SOURCES})
target_include_directories(TestCodecController PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestCodecController PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCodecController PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestCodecController PUBLIC ${ENDIANNESS})

set(TESTDECODEDAUDIOAGGREGATOR_SOURCES
  OpenHome/Media/Tests/TestDecodedAudioAggregatorMain.cpp
)

add_executable(TestDecodedAudioAggregator ${TESTDECODEDAUDIOAGGREGATOR_SOURCES})
target_include_directories(TestDecodedAudioAggregator PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestDecodedAudioAggregator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestDecodedAudioAggregator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestDecodedAudioAggregator PUBLIC ${ENDIANNESS})

set(TESTCONTAINER_SOURCES
  OpenHome/Media/Tests/TestContainerMain.cpp
)

add_executable(TestContainer ${TESTCONTAINER_SOURCES})
target_include_directories(TestContainer PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestContainer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestContainer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestContainer PUBLIC ${ENDIANNESS})

set(TESTSILENCER_SOURCES
  OpenHome/Media/Tests/TestSilencerMain.cpp
)

add_executable(TestSilencer ${TESTSILENCER_SOURCES})
target_include_directories(TestSilencer PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSilencer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSilencer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSilencer PUBLIC ${ENDIANNESS})

set(TESTIDPROVIDER_SOURCES
  OpenHome/Media/Tests/TestIdProviderMain.cpp
)

add_executable(TestIdProvider ${TESTIDPROVIDER_SOURCES})
target_include_directories(TestIdProvider PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestIdProvider PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestIdProvider PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestIdProvider PUBLIC ${ENDIANNESS})

set(TESTFILLER_SOURCES
  OpenHome/Media/Tests/TestFillerMain.cpp
)

add_executable(TestFiller ${TESTFILLER_SOURCES})
target_include_directories(TestFiller PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestFiller PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestFiller PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestFiller PUBLIC ${ENDIANNESS})

set(TESTTONEGENERATOR_SOURCES
  OpenHome/Media/Tests/TestToneGeneratorMain.cpp
)

add_executable(TestToneGenerator ${TESTTONEGENERATOR_SOURCES})
target_include_directories(TestToneGenerator PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestToneGenerator PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestToneGenerator PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestToneGenerator PUBLIC ${ENDIANNESS})

set(TESTMUTEMANAGER_SOURCES
  OpenHome/Media/Tests/TestMuteManagerMain.cpp
)

add_executable(TestMuteManager ${TESTMUTEMANAGER_SOURCES})
target_include_directories(TestMuteManager PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestMuteManager PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMuteManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestMuteManager PUBLIC ${ENDIANNESS})

set(TESTREWINDER_SOURCES
  OpenHome/Media/Tests/TestRewinderMain.cpp
)

add_executable(TestRewinder ${TESTREWINDER_SOURCES})
target_include_directories(TestRewinder PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestRewinder PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestRewinder PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestRewinder PUBLIC ${ENDIANNESS})

set(TESTUDPSERVER_SOURCES
  OpenHome/Av/Tests/TestUdpServerMain.cpp
)

add_executable(TestUdpServer ${TESTUDPSERVER_SOURCES})
target_include_directories(TestUdpServer PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestUdpServer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestUdpServer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceRaop ohPipeline)
target_compile_definitions(TestUdpServer PUBLIC ${ENDIANNESS})

set(TESTUPNPERRORS_SOURCES
  OpenHome/Av/Tests/TestUpnpErrorsMain.cpp
)

add_executable(TestUpnpErrors ${TESTUPNPERRORS_SOURCES})
target_include_directories(TestUpnpErrors PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestUpnpErrors PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestUpnpErrors PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceUpnpAv ohPipeline)
target_compile_definitions(TestUpnpErrors PUBLIC ${ENDIANNESS})

set(TESTTRACKDATABASE_SOURCES
  OpenHome/Av/Tests/TestTrackDatabaseMain.cpp
)

add_executable(TestTrackDatabase ${TESTTRACKDATABASE_SOURCES})
target_include_directories(TestTrackDatabase PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestTrackDatabase PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestTrackDatabase PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist ohPipeline)
target_compile_definitions(TestTrackDatabase PUBLIC ${ENDIANNESS})

set(TESTURIPROVIDERREPEATER_SOURCES
  OpenHome/Media/Tests/TestUriProviderRepeaterMain.cpp
)

add_executable(TestUriProviderRepeater ${TESTURIPROVIDERREPEATER_SOURCES})
target_include_directories(TestUriProviderRepeater PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestUriProviderRepeater PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestUriProviderRepeater PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceUpnpAv ohPipeline)
target_compile_definitions(TestUriProviderRepeater PUBLIC ${ENDIANNESS})

set(TESTMEDIAPLAYER_SOURCES
  OpenHome/Av/Tests/TestMediaPlayerMain.cpp
)

add_executable(TestMediaPlayer ${TESTMEDIAPLAYER_SOURCES})
target_include_directories(TestMediaPlayer PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestMediaPlayer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestMediaPlayer PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist SourceRadio SourceSongcast SourceScd SourceRaop SourceUpnpAv WebAppFramework ConfigUi ohPipeline)
target_compile_definitions(TestMediaPlayer PUBLIC ${ENDIANNESS})

set(TESTCONFIGMANAGER_SOURCES
  OpenHome/Configuration/Tests/TestConfigManagerMain.cpp
)

add_executable(TestConfigManager ${TESTCONFIGMANAGER_SOURCES})
target_include_directories(TestConfigManager PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestConfigManager PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestConfigManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestConfigManager PUBLIC ${ENDIANNESS})

set(TESTPOWERMANAGER_SOURCES
  OpenHome/Tests/TestPowerManagerMain.cpp
)

# add_executable(TestPowerManager ${TESTPOWERMANAGER_SOURCES})
# target_include_directories(TestPowerManager PUBLIC ${CMAKE_SOURCE_DIR})
# target_include_directories(TestPowerManager PUBLIC
#   ${OHNET_PATH}/include/ohnet
#   ${THIRDPARTY_HEADERS}
#   ${CMAKE_BINARY_DIR}
#   "${CMAKE_BINARY_DIR}/Generated"
# )
# target_link_libraries(TestPowerManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
# target_compile_definitions(TestPowerManager PUBLIC ${ENDIANNESS})
# # target_link_options(TestPowerManager PUBLIC "-lohPipeline")
# set_property(TARGET TestPowerManager APPEND PROPERTY LINK_INTERFACE_MULTIPLICITY "-Llib -lohPipeline -lDUUUUUUUUUUUUPAAAAAAAAAAA")
# # target_link_directories(TestPowerManager PRIVATE ${CMAKE_BINARY_DIR}/lib)
# # target_link_libraries(TestPowerManager PRIVATE "-lohPipeline") # don't ask me

set(TESTSSL_SOURCES
  OpenHome/Tests/TestSslMain.cpp
)

add_executable(TestSsl ${TESTSSL_SOURCES})
target_include_directories(TestSsl PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSsl PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSsl PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSsl PUBLIC ${ENDIANNESS})

set(TESTSOCKET_SOURCES
  OpenHome/Tests/TestSocketMain.cpp
)

add_executable(TestSocket ${TESTSOCKET_SOURCES})
target_include_directories(TestSocket PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSocket PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSocket PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestSocket PUBLIC ${ENDIANNESS})

set(TESTCREDENTIALS_SOURCES
  OpenHome/Av/Tests/TestCredentialsMain.cpp
)

add_executable(TestCredentials ${TESTCREDENTIALS_SOURCES})
target_include_directories(TestCredentials PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestCredentials PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestCredentials PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestCredentials PUBLIC ${ENDIANNESS})

set(TESTHTTPS_SOURCES
  OpenHome/Tests/TestHttps.cpp
)

add_executable(TestHttps ${TESTHTTPS_SOURCES})
target_include_directories(TestHttps PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestHttps PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestHttps PUBLIC ohNet ohMediaPlayer ohPipeline)
target_compile_definitions(TestHttps PUBLIC ${ENDIANNESS})

# set(TESTFRIENDLYNAMEMANAGER_SOURCES
#   OpenHome/Av/Tests/TestFriendlyNameManagerMain.cpp
# )

# add_executable(TestFriendlyNameManager ${TESTFRIENDLYNAMEMANAGER_SOURCES})
# target_include_directories(TestFriendlyNameManager PUBLIC ${CMAKE_SOURCE_DIR})
# target_include_directories(TestFriendlyNameManager PUBLIC
#   ${OHNET_PATH}/include/ohnet
#   ${THIRDPARTY_HEADERS}
#   ${CMAKE_BINARY_DIR}
#   "${CMAKE_BINARY_DIR}/Generated"
# )
# target_link_libraries(TestFriendlyNameManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
# target_compile_definitions(TestFriendlyNameManager PUBLIC ${ENDIANNESS})

set(TESTTIDAL_SOURCES
  OpenHome/Av/Tidal/TestTidal.cpp
)

add_executable(TestTidal ${TESTTIDAL_SOURCES})
target_include_directories(TestTidal PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestTidal PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestTidal PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist ohPipeline)
target_compile_definitions(TestTidal PUBLIC ${ENDIANNESS})

set(TESTJSON_SOURCES
  OpenHome/Tests/TestJsonMain.cpp
)

add_executable(TestJson ${TESTJSON_SOURCES})
target_include_directories(TestJson PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestJson PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestJson PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestJson PUBLIC ${ENDIANNESS})

set(TESTTHREADPOOL_SOURCES
  OpenHome/Tests/TestThreadPoolMain.cpp
)

add_executable(TestThreadPool ${TESTTHREADPOOL_SOURCES})
target_include_directories(TestThreadPool PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestThreadPool PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestThreadPool PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestThreadPool PUBLIC ${ENDIANNESS})

set(TESTQOBUZ_SOURCES
  OpenHome/Av/Qobuz/TestQobuz.cpp
)

add_executable(TestQobuz ${TESTQOBUZ_SOURCES})
target_include_directories(TestQobuz PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestQobuz PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestQobuz PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist ohPipeline)
target_compile_definitions(TestQobuz PUBLIC ${ENDIANNESS})

set(TESTNTPCLIENT_SOURCES
  OpenHome/Tests/TestNtpClient.cpp
)

add_executable(TestNtpClient ${TESTNTPCLIENT_SOURCES})
target_include_directories(TestNtpClient PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestNtpClient PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestNtpClient PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourcePlaylist ohPipeline)
target_compile_definitions(TestNtpClient PUBLIC ${ENDIANNESS})

set(TESTWEBAPPFRAMEWORK_SOURCES
  OpenHome/Web/Tests/TestWebAppFrameworkMain.cpp
)

add_executable(TestWebAppFramework ${TESTWEBAPPFRAMEWORK_SOURCES})
target_include_directories(TestWebAppFramework PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestWebAppFramework PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestWebAppFramework PUBLIC ohNet WebAppFrameworkTestUtils WebAppFramework ohMediaPlayer ohPipeline)
target_compile_definitions(TestWebAppFramework PUBLIC ${ENDIANNESS})

set(TESTCONFIGUI_SOURCES
  OpenHome/Web/ConfigUi/Tests/TestConfigUiMain.cpp
)

add_executable(TestConfigUi ${TESTCONFIGUI_SOURCES})
target_include_directories(TestConfigUi PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestConfigUi PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestConfigUi PUBLIC ohNet ConfigUiTestUtils WebAppFrameworkTestUtils ConfigUi WebAppFramework ohMediaPlayerTestUtils SourcePlaylist SourceRadio SourceSongcast SourceScd SourceRaop SourceUpnpAv ohMediaPlayer ohPipeline)
target_compile_definitions(TestConfigUi PUBLIC ${ENDIANNESS})

set(TESTRAOP_SOURCES
  OpenHome/Av/Tests/TestRaopMain.cpp
)

add_executable(TestRaop ${TESTRAOP_SOURCES})
target_include_directories(TestRaop PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestRaop PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestRaop PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceRaop ohPipeline)
target_compile_definitions(TestRaop PUBLIC ${ENDIANNESS})

# set(TESTVOLUMEMANAGER_SOURCES
#   OpenHome/Av/Tests/TestVolumeManagerMain.cpp
# )

# add_executable(TestVolumeManager ${TESTVOLUMEMANAGER_SOURCES})
# target_include_directories(TestVolumeManager PUBLIC ${CMAKE_SOURCE_DIR})
# target_include_directories(TestVolumeManager PUBLIC
#   ${OHNET_PATH}/include/ohnet
#   ${THIRDPARTY_HEADERS}
#   ${CMAKE_BINARY_DIR}
#   "${CMAKE_BINARY_DIR}/Generated"
# )
# target_link_libraries(TestVolumeManager PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
# target_compile_definitions(TestVolumeManager PUBLIC ${ENDIANNESS})

set(TESTPINS_SOURCES
  OpenHome/Av/Tests/TestPinsMain.cpp
)

add_executable(TestPins ${TESTPINS_SOURCES})
target_include_directories(TestPins PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestPins PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestPins PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils ohPipeline)
target_compile_definitions(TestPins PUBLIC ${ENDIANNESS})

set(TESTSENDERQUEUE_SOURCES
  OpenHome/Av/Tests/TestSenderQueueMain.cpp
)

add_executable(TestSenderQueue ${TESTSENDERQUEUE_SOURCES})
target_include_directories(TestSenderQueue PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(TestSenderQueue PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(TestSenderQueue PUBLIC ohNet ohMediaPlayer ohMediaPlayerTestUtils SourceSongcast ohPipeline)
target_compile_definitions(TestSenderQueue PUBLIC ${ENDIANNESS})

# set(TESTDVODP_SOURCES
#   OpenHome/Net/Odp/Tests/TestDvOdpMain.cpp
# )

# add_executable(TestDvOdp ${TESTDVODP_SOURCES})
# target_include_directories(TestDvOdp PUBLIC ${CMAKE_SOURCE_DIR})
# target_include_directories(TestDvOdp PUBLIC
#   ${OHNET_PATH}/include/ohnet
#   ${THIRDPARTY_HEADERS}
#   ${CMAKE_BINARY_DIR}
#   "${CMAKE_BINARY_DIR}/Generated"
# )
# target_link_libraries(TestDvOdp PUBLIC ohNet Odp ohMediaPlayerTestUtils ohPipeline)
# target_compile_definitions(TestDvOdp PUBLIC ${ENDIANNESS})

# set(TESTCPDEVICELISTODP_SOURCES
#   OpenHome/Net/Odp/Tests/TestCpDeviceListOdp.cpp
# )

# add_executable(TestCpDeviceListOdp ${TESTCPDEVICELISTODP_SOURCES})
# target_include_directories(TestCpDeviceListOdp PUBLIC ${CMAKE_SOURCE_DIR})
# target_include_directories(TestCpDeviceListOdp PUBLIC
#   ${OHNET_PATH}/include/ohnet
#   ${THIRDPARTY_HEADERS}
#   ${CMAKE_BINARY_DIR}
#   "${CMAKE_BINARY_DIR}/Generated"
# )
# target_link_libraries(TestCpDeviceListOdp PUBLIC ohNet Odp ohMediaPlayerTestUtils ohPipeline)
# target_compile_definitions(TestCpDeviceListOdp PUBLIC ${ENDIANNESS})

set(SCDSENDER_SOURCES
  OpenHome/Av/Scd/ScdMsg.cpp
  OpenHome/Av/Scd/Sender/ScdSupply.cpp
  OpenHome/Av/Scd/Sender/ScdServer.cpp
)

add_library(ScdSender STATIC ${SCDSENDER_SOURCES})
target_include_directories(ScdSender PUBLIC ${CMAKE_SOURCE_DIR})
target_include_directories(ScdSender PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_libraries(ScdSender PUBLIC ohNet ohMediaPlayer)
target_compile_definitions(ScdSender PUBLIC ${ENDIANNESS})
