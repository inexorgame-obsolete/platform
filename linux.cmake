set(targ "linux")
set(targ_os "linux")
set(sep ";")

# TODO: Get rid of this terrible workaround
execute_process(COMMAND uname -m OUTPUT_VARIABLE uname_arch)
if(uname_arch MATCHES "x86_64")
  set(SHORT_ARCH "x86_64")
else()
  set(SHORT_ARCH "i386")
endif()


get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
include(${PLATFORM_REPO_DIR}/common.cmake)
