cmake_minimum_required(VERSION 3.4.1)
project(ohPipeline LANGUAGES CXX C)

if(NOT DEFINED OHNET_PATH)
  message(FATAL_ERROR "You need to provide -DOHNET_PATH that points to built headers")
endif()

set(ENDIANNESS DEFINE_LITTLE_ENDIAN)
set(THIRDPARTY_HEADERS
  thirdparty/libogg/include
  thirdparty/flac-1.2.1/src/plugin_winamp2/include
  thirdparty/flac-1.2.1/src/share/replaygain_synthesis/include
  thirdparty/flac-1.2.1/src/libFLAC/include
  thirdparty/flac-1.2.1/include
  thirdparty/fdk-aac/libMpegTPDec/include
  thirdparty/fdk-aac/libFDK/include
  thirdparty/fdk-aac/libAACenc/include
  thirdparty/fdk-aac/libPCMutils/include
  thirdparty/fdk-aac/libSBRenc/include
  thirdparty/fdk-aac/libAACdec/include
  thirdparty/fdk-aac/libMpegTPEnc/include
  thirdparty/fdk-aac/libSYS/include
  thirdparty/fdk-aac/libSBRdec/include
)

set(OHPIPELINE_SOURCES
  OpenHome/Media/Pipeline/VolumeRamper.cpp
  OpenHome/Media/Pipeline/AudioDumper.cpp
  OpenHome/Media/Pipeline/AudioReservoir.cpp
  OpenHome/Media/Pipeline/DecodedAudioAggregator.cpp
  OpenHome/Media/Pipeline/DecodedAudioReservoir.cpp
  OpenHome/Media/Pipeline/DecodedAudioValidator.cpp
  OpenHome/Media/Pipeline/Drainer.cpp
  OpenHome/Media/Pipeline/EncodedAudioReservoir.cpp
  OpenHome/Media/Pipeline/Flusher.cpp
  OpenHome/Media/Pipeline/Logger.cpp
  OpenHome/Media/Pipeline/Msg.cpp
  OpenHome/Media/Pipeline/Muter.cpp
  OpenHome/Media/Pipeline/MuterVolume.cpp
  OpenHome/Media/Pipeline/PreDriver.cpp
  OpenHome/Media/Pipeline/Attenuator.cpp
  OpenHome/Media/Pipeline/Ramper.cpp
  OpenHome/Media/Pipeline/Reporter.cpp
  OpenHome/Media/Pipeline/SpotifyReporter.cpp
  OpenHome/Media/Pipeline/RampValidator.cpp
  OpenHome/Media/Pipeline/Rewinder.cpp
  OpenHome/Media/Pipeline/Router.cpp
  OpenHome/Media/Pipeline/StreamValidator.cpp
  OpenHome/Media/Pipeline/Seeker.cpp
  OpenHome/Media/Pipeline/Skipper.cpp
  OpenHome/Media/Pipeline/StarvationRamper.cpp
  OpenHome/Media/Pipeline/Stopper.cpp
  OpenHome/Media/Pipeline/TrackInspector.cpp
  OpenHome/Media/Pipeline/VariableDelay.cpp
  OpenHome/Media/Pipeline/Waiter.cpp
  OpenHome/Media/Pipeline/Pipeline.cpp
  OpenHome/Media/Pipeline/ElementObserver.cpp
  OpenHome/Media/IdManager.cpp
  OpenHome/Media/Filler.cpp
  OpenHome/Media/Supply.cpp
  OpenHome/Media/SupplyAggregator.cpp
  OpenHome/Media/Utils/AnimatorBasic.cpp
  OpenHome/Media/Utils/ProcessorAudioUtils.cpp
  OpenHome/Media/Utils/ClockPullerManual.cpp
  OpenHome/Media/Codec/Mpeg4.cpp
  OpenHome/Media/Codec/Container.cpp
  OpenHome/Media/Codec/Id3v2.cpp
  OpenHome/Media/Codec/MpegTs.cpp
  OpenHome/Media/Codec/CodecController.cpp
  OpenHome/Media/Protocol/Protocol.cpp
  OpenHome/Media/Protocol/ProtocolHls.cpp
  OpenHome/Media/Protocol/ProtocolHttp.cpp
  OpenHome/Media/Protocol/ProtocolFile.cpp
  OpenHome/Media/Protocol/ProtocolTone.cpp
  OpenHome/Media/Protocol/Icy.cpp
  OpenHome/Media/Protocol/Rtsp.cpp
  OpenHome/Media/Protocol/ProtocolRtsp.cpp
  OpenHome/Media/Protocol/ContentAudio.cpp
  OpenHome/Media/UriProviderRepeater.cpp
  OpenHome/Media/UriProviderSingleTrack.cpp
  OpenHome/Media/PipelineManager.cpp
  OpenHome/Media/PipelineObserver.cpp
  OpenHome/Media/MuteManager.cpp
  OpenHome/Media/FlywheelRamper.cpp
  OpenHome/Media/MimeTypeList.cpp
  OpenHome/Media/Utils/AllocatorInfoLogger.cpp
  OpenHome/Configuration/BufferPtrCmp.cpp
  OpenHome/Configuration/ConfigManager.cpp
  OpenHome/Media/Utils/Silencer.cpp
  OpenHome/SocketHttp.cpp
  OpenHome/SocketSsl.cpp
)

set(OHMEDIAPLAYER_SOURCES
  OpenHome/Av/Utils/FaultCode.cpp
  OpenHome/Av/KvpStore.cpp
  OpenHome/Av/ProviderUtils.cpp
  OpenHome/Av/Product.cpp
  OpenHome/Av/ProviderProduct.cpp
  OpenHome/Av/ProviderTime.cpp
  OpenHome/Av/ProviderInfo.cpp
  OpenHome/Av/TransportControl.cpp
  OpenHome/Av/ProviderTransport.cpp
  OpenHome/Av/Pins/TransportPins.cpp
  OpenHome/Av/Radio/TuneInPins.cpp
  OpenHome/Av/Radio/RadioPins.cpp
  OpenHome/Av/Pins/UrlPins.cpp
  OpenHome/Av/CalmRadio/CalmRadioPins.cpp
  OpenHome/Av/ProviderVolume.cpp
  OpenHome/Av/Source.cpp
  OpenHome/Av/MediaPlayer.cpp
  OpenHome/Av/Logger.cpp
  OpenHome/Json.cpp
  OpenHome/Av/Utils/FormUrl.cpp
  OpenHome/NtpClient.cpp
  OpenHome/UnixTimestamp.cpp
  OpenHome/Configuration/ProviderConfig.cpp
  OpenHome/Configuration/ProviderConfigApp.cpp
  OpenHome/PowerManager.cpp
  OpenHome/ThreadPool.cpp
  OpenHome/FsFlushPeriodic.cpp
  OpenHome/Av/Credentials.cpp
  OpenHome/Av/ProviderCredentials.cpp
  OpenHome/Av/VolumeManager.cpp
  OpenHome/Av/FriendlyNameAdapter.cpp
  OpenHome/Av/ProviderDebug.cpp
  OpenHome/Av/Pins/Pins.cpp
  OpenHome/Av/Pins/ProviderPins.cpp
  OpenHome/Av/OhMetadata.cpp
  Generated/DvAvOpenhomeOrgProduct3.cpp
  Generated/CpAvOpenhomeOrgProduct3.cpp
  Generated/DvAvOpenhomeOrgTime1.cpp
  Generated/DvAvOpenhomeOrgInfo1.cpp
  Generated/DvAvOpenhomeOrgTransport1.cpp
  Generated/CpAvOpenhomeOrgTransport1.cpp
  Generated/CpAvOpenhomeOrgRadio1.cpp
  Generated/DvAvOpenhomeOrgVolume4.cpp
  Generated/DvAvOpenhomeOrgConfig2.cpp
  Generated/DvAvOpenhomeOrgConfigApp1.cpp
  Generated/DvAvOpenhomeOrgCredentials1.cpp
  Generated/DvAvOpenhomeOrgDebug2.cpp
  Generated/DvAvOpenhomeOrgPins1.cpp
  
  Generated/DvAvOpenhomeOrgProduct3.h
  Generated/CpAvOpenhomeOrgProduct3.h
  Generated/DvAvOpenhomeOrgTime1.h
  Generated/DvAvOpenhomeOrgInfo1.h
  Generated/DvAvOpenhomeOrgTransport1.h
  Generated/CpAvOpenhomeOrgTransport1.h
  Generated/CpAvOpenhomeOrgRadio1.h
  Generated/DvAvOpenhomeOrgVolume4.h
  Generated/DvAvOpenhomeOrgConfig2.h
  Generated/DvAvOpenhomeOrgConfigApp1.h
  Generated/DvAvOpenhomeOrgCredentials1.h
  Generated/DvAvOpenhomeOrgDebug2.h
  Generated/DvAvOpenhomeOrgPins1.h
)

set(PLATFORM Linux-x64/ohNet-Linux-x64-Release)
set(CODEGEN_EXECUTABLE "${CMAKE_SOURCE_DIR}/dependencies/${PLATFORM}/lib/ServiceGen/ServiceGen.py")

macro(generate_source xml domain type version target)
  set(TEMPLATE_FILES DvUpnpCppCoreHeader.py DvUpnpCppCoreSource.py CpUpnpCppBufferHeader.py CpUpnpCppBufferSource.py)
  set(TEMPLATE_PREFIXES Dv Dv Cp Cp)
  set(TEMPLATE_EXTS ".h" ".cpp" ".h" ".cpp")

  foreach(tmp_file tmp_prefix tmp_ext IN ZIP_LISTS TEMPLATE_FILES TEMPLATE_PREFIXES TEMPLATE_EXTS)
    set(OUTPUT_PATH "Generated/${tmp_prefix}${target}${tmp_ext}")

    get_filename_component(abs_xml "${xml}"
      REALPATH BASE_DIR "${CMAKE_SOURCE_DIR}")

    add_custom_command(
      OUTPUT ${OUTPUT_PATH}
      COMMAND ${Python3_EXECUTABLE} ${CODEGEN_EXECUTABLE}
                                    -t ${tmp_file}
                                    -o Generated
                                    -x ${abs_xml}
                                    -d ${domain}
                                    -y ${type}
                                    -v ${version}
      MAIN_DEPENDENCY ${abs_xml}
      COMMENT "Generating code for ${target}."
      VERBATIM
    )
  endforeach()
endmacro()

# set(CMAKE_CXX_STANDARD 11)
add_compile_options(-g -pipe -D_GNU_SOURCE -D_REENTRANT -DDEFINE_TRACE -DDEFINE_LITTLE_ENDIAN -fvisibility=hidden -O2 -std=c++0x -fexceptions -Wall -Werror -m64 -Wno-psabi -fPIC)

find_package(Python3 COMPONENTS Interpreter)

generate_source("OpenHome/Av/ServiceXml/Upnp/AVTransport1.xml" "upnp.org" "AVTransport" "1" "UpnpOrgAVTransport1")
generate_source("OpenHome/Av/ServiceXml/Upnp/ConnectionManager1.xml" "upnp.org" "ConnectionManager" "1" "UpnpOrgConnectionManager1")
generate_source("OpenHome/Av/ServiceXml/Upnp/RenderingControl1.xml" "upnp.org" "RenderingControl" "1" "UpnpOrgRenderingControl1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Product3.xml" "av.openhome.org" "Product" "3" "AvOpenhomeOrgProduct3")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Radio1.xml" "av.openhome.org" "Radio" "1" "AvOpenhomeOrgRadio1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Sender2.xml" "av.openhome.org" "Sender" "2" "AvOpenhomeOrgSender2")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Playlist1.xml" "av.openhome.org" "Playlist" "1" "AvOpenhomeOrgPlaylist1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Receiver1.xml" "av.openhome.org" "Receiver" "1" "AvOpenhomeOrgReceiver1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Time1.xml" "av.openhome.org" "Time" "1" "AvOpenhomeOrgTime1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Info1.xml" "av.openhome.org" "Info" "1" "AvOpenhomeOrgInfo1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Volume4.xml" "av.openhome.org" "Volume" "4" "AvOpenhomeOrgVolume4")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Config2.xml" "av.openhome.org" "Config" "2" "AvOpenhomeOrgConfig2")
generate_source("OpenHome/Av/ServiceXml/OpenHome/ConfigApp1.xml" "av.openhome.org" "ConfigApp" "1" "AvOpenhomeOrgConfigApp1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Credentials1.xml" "av.openhome.org" "Credentials" "1" "AvOpenhomeOrgCredentials1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Debug2.xml" "av.openhome.org" "Debug" "2" "AvOpenhomeOrgDebug2")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Transport1.xml" "av.openhome.org" "Transport" "1" "AvOpenhomeOrgTransport1")
generate_source("OpenHome/Av/ServiceXml/OpenHome/Pins1.xml" "av.openhome.org" "Pins" "1" "AvOpenhomeOrgPins1")

add_library(ohPipeline STATIC ${OHPIPELINE_SOURCES})
add_library(ohMediaPlayer STATIC ${OHMEDIAPLAYER_SOURCES})

target_include_directories(ohPipeline PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ohPipeline PUBLIC ${OHNET_PATH} ${THIRDPARTY_HEADERS})
target_compile_definitions(ohPipeline PUBLIC ${ENDIANNESS} _GNU_SOURCE)

target_include_directories(ohMediaPlayer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ohMediaPlayer PUBLIC ${OHNET_PATH} ${THIRDPARTY_HEADERS})
target_include_directories(ohMediaPlayer PUBLIC ${CMAKE_BINARY_DIR})
target_include_directories(ohMediaPlayer PUBLIC "${CMAKE_BINARY_DIR}/Generated")
target_compile_definitions(ohMediaPlayer PUBLIC ${ENDIANNESS} _GNU_SOURCE)

set(CONAN_DISABLE_CHECK_COMPILER 1)
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()
