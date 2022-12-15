
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

add_library(ohMediaPlayer STATIC ${OHMEDIAPLAYER_SOURCES})
target_include_directories(ohMediaPlayer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(ohMediaPlayer PUBLIC
  ${OHNET_PATH}/include/ohnet
  ${THIRDPARTY_HEADERS}
  ${CMAKE_BINARY_DIR}
  "${CMAKE_BINARY_DIR}/Generated"
)
target_link_directories(ohMediaPlayer PUBLIC ${OHNET_PATH}/lib)
target_compile_definitions(ohMediaPlayer PUBLIC ${ENDIANNESS})
