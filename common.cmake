get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
string(TOLOWER "${CMAKE_HOST_SYSTEM_NAME}" host)
set(pwd ${PLATFORM_REPO_DIR})

list(INSERT CMAKE_PROGRAM_PATH 0
  ${pwd}/tool/${host}-${targ}
  ${pwd}/tool/${host})
message(STATUS "CMAKE_PROGRAM_PATH : ${CMAKE_PROGRAM_PATH}")
list(INSERT CMAKE_FIND_ROOT_PATH 0 ${pwd})
list(INSERT CMAKE_INCLUDE_PATH 0
    ${pwd}/include/${targ}-${SHORT_ARCH}
    ${pwd}/include/${targ}
    ${pwd}/include/${targ_os}-${SHORT_ARCH}
    ${pwd}/include/${targ_os}
    ${pwd}/include/all)
list(INSERT CMAKE_LIBRARY_PATH 0
  "${pwd}/lib/${targ}-${SHORT_ARCH}"
  "${pwd}/lib/${targ_os}-${SHORT_ARCH}")
list(INSERT CMAKE_RESOURCES_PATH 0
    ${pwd}/res/${targ}-${SHORT_ARCH}
    ${pwd}/res/${targ}
    ${pwd}/res/${targ_os}-${SHORT_ARCH}
    ${pwd}/res/${targ_os}
    ${pwd}/res/all)

foreach(dir ${CMAKE_LIBRARY_PATH})
  file(GLOB dlls "${dir}/*.dll")
  file(GLOB sos "${dir}/*.so")
  list(APPEND INSTALL_SHARED_LIBS ${dlls})
  list(APPEND INSTALL_SHARED_LIBS ${sos})
endforeach()

foreach(dir ${CMAKE_RESOURCES_PATH})
  file(GLOB exes "${dir}/*")
  list(APPEND INSTALL_EXES ${exes})
endforeach()
