# Choose an appropriate compiler prefix

set(MINGW_TYPE "i686" CACHE DOC "Cross compilation mingw type, can be classic, i686 or x86_64")

if("${MINGW_TYPE}" STREQUAL "i686")
    set(COMPILER_PREFIX "i686-w64-mingw32")
    set(arch i686)
elseif("${MINGW_TYPE}" STREQUAL "x86_64")
    set(COMPILER_PREFIX "x86_64-w64-mingw32")
    set(arch x86_64)
elseif("${MINGW_TYPE}" STREQUAL "classic")
    message(FATAL_ERROR "Sorry, classic mingw is no longer supported. Use https://mingw-w64.sourceforge.net/")
else()
    message(FATAL_ERROR "Invalid MINGW_TYPE")
endif()

# which compilers to use for C and C++
find_program(CMAKE_RC_COMPILER NAMES ${COMPILER_PREFIX}-windres)
find_program(CMAKE_C_COMPILER NAMES ${COMPILER_PREFIX}-gcc)
find_program(CMAKE_CXX_COMPILER NAMES ${COMPILER_PREFIX}-g++)

if(NOT WIN32)
  message(STATUS "Cross compiling for windows!")

  # here is the target environment located
  SET(CMAKE_FIND_ROOT_PATH  /usr/${COMPILER_PREFIX})

  # adjust the default behaviour of the FIND_XXX() commands:
  # search headers and libraries in the target environment,
  # search programs in the host environment
  set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endif()

set(build_config "")
set(targ "mingw")
set(sep ":")

get_filename_component(pwd ${CMAKE_CURRENT_LIST_FILE} PATH)
include(${pwd}/common_windows.cmake)
