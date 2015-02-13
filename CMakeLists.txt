### Windows Specific files and definitions

# Install shared libs to the Executable output dir
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${EXE_SUB_DIR}/
    DESTINATION ${EXE_DIR}
    PATTERN "*")

# Path to the protoc generator
if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Windows") # Crosscompiler has it globally already
  set(PROTOC_EXE "${CMAKE_CURRENT_SOURCE_DIR}/tool/protoc" CACHE INTERNAL "")
endif()

# Protobuf should not require RTTI (disabled for msvc by default, really slow for mingw)
add_definitions(-DGOOGLE_PROTOBUF_NO_RTTI)

# zlib compressing
set(ZLIB_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include" CACHE INTERNAL "")
set(ZLIB_LIBRARY zdll CACHE INTERNAL "")

set(ZLIB_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR} CACHE INTERNAL "")
set(ZLIB_LIBRARIES ${ZLIB_LIBRARY} CACHE INTERNAL "")

# SDL2
set(SDL2_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/include/SDL2;${CMAKE_CURRENT_SOURCE_DIR}/include" CACHE INTERNAL "" FORCE)
set(SDL2_LIBRARIES "SDL2;SDL2_image;SDL2_mixer" CACHE INTERNAL "" FORCE)

# ENet Networking
set(ENET_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE INTERNAL "")
set(ENET_LIBRARIES "enet"  CACHE INTERNAL "")

# ASIO Networking
set(ASIO_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE INTERNAL "")

# Protobuf Serialization Format
set(PROTOBUF_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE INTERNAL "")
set(PROTOBUF_LIBRARIES "protobuf"  CACHE INTERNAL "")

# Set Linker folder
set(PLATFORM_LINK_DIRECTORIES
    ${CMAKE_CURRENT_SOURCE_DIR}/lib/${PROJECT_ARCH} PARENT_SCOPE)

