set(CMAKE_SYSTEM_NAME Windows)

get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

string(TOLOWER "${CMAKE_HOST_SYSTEM_NAME}" host)

if(host MATCHES "windows")
  set(sep ";")
else()
  set(sep ":")
endif()

set(ENV{PATH} "${PLATFORM_REPO_DIR}/tool/${host}${sep}$ENV{PATH}")
list(INSERT CMAKE_FIND_ROOT_PATH 0 ${PLATFORM_REPO_DIR})
list(INSERT CMAKE_INCLUDE_PATH 0 ${PLATFORM_REPO_DIR}/include)
list(INSERT CMAKE_LIBRARY_PATH 0
  "${PLATFORM_REPO_DIR}/lib/${targ}-${SHORT_ARCH}"
  "${PLATFORM_REPO_DIR}/lib/common-${SHORT_ARCH}")

message(STATUS "LIBRARY_PATHS: ${CMAKE_LIBRARY_PATH}")
foreach(dir ${CMAKE_LIBRARY_PATH})
  file(GLOB dlls "${dir}/*.dll")
  list(APPEND INSTALL_SHARED_LIBS ${dlls})
endforeach()