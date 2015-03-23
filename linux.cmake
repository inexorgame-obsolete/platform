set(targ "linux")
set(targ_os "linux")
set(sep ";")

if(CMAKE_SIZEOF_VOID_P MATCHES 8)
  set(SHORT_ARCH "x86_64")
else()
  set(SHORT_ARCH "i686")
endif()


get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
include(${PLATFORM_REPO_DIR}/common.cmake)
