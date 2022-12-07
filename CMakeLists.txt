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

set(sources
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

# set(CMAKE_CXX_STANDARD 11)
add_compile_options(-g -pipe -D_GNU_SOURCE -D_REENTRANT -DDEFINE_TRACE -DDEFINE_LITTLE_ENDIAN -fvisibility=hidden -O2 -std=c++0x -fexceptions -Wall -Werror -m64 -Wno-psabi -fPIC)

add_library(ohPipeline STATIC ${sources})


target_include_directories(ohPipeline PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ohPipeline PUBLIC ${OHNET_PATH} ${THIRDPARTY_HEADERS})
target_compile_definitions(ohPipeline PUBLIC ${ENDIANNESS} _GNU_SOURCE)

set(CONAN_DISABLE_CHECK_COMPILER 1)
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()
