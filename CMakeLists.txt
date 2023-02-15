cmake_minimum_required(VERSION 3.4.1)
project(ohPipeline LANGUAGES CXX C)

find_package(ohnet REQUIRED)
find_package(LibreSSL REQUIRED)
find_package(alac REQUIRED)
find_package(flac REQUIRED)
find_package(Ogg REQUIRED)
find_package(fdk-aac REQUIRED)
find_package(libmad REQUIRED)

set(ENDIANNESS DEFINE_LITTLE_ENDIAN)

# TODO: add other platforms
set(DEPS_PLATFORM Linux-x64)
set(CMAKE_BUILD_TYPE Release)

set(CODEGEN_EXECUTABLE "${CMAKE_CURRENT_BINARY_DIR}/ServiceGen.py")
# message(FATAL_ERROR "Pytoniec jest ${CODEGEN_EXECUTABLE}")
set(GENERATED_FILES "")

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
      DEPENDS ${CODEGEN_EXECUTABLE} ${abs_xml}
      COMMENT "Generating code for ${target} -> ${OUTPUT_PATH}."
      VERBATIM
    )
    set(GENERATED_FILES ${GENERATED_FILES} ${OUTPUT_PATH})
  endforeach()
endmacro()

add_compile_options(-g -pipe -D_GNU_SOURCE -D_REENTRANT -DDEFINE_TRACE -fvisibility=hidden -O2 -std=c++0x -fexceptions -Wall -m64 -Wno-psabi -fPIC)

# setup third party libs
add_compile_definitions(BIG_ENDIAN BYTE_ORDER=BIG_ENDIAN) #vorbis

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

# force to generate files (especially headers)
add_custom_target(
  oh_codegen
  DEPENDS ${GENERATED_FILES}
)

include(${CMAKE_SOURCE_DIR}/cmake/ohpipeline.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/ohmediaplayer.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/rest.cmake)
