set(targ "osx")
set(targ_os "osx")
set(sep ";")
set(SHORT_ARCH "64")

get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
include(${PLATFORM_REPO_DIR}/common.cmake)
