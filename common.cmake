get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
string(TOLOWER "${CMAKE_HOST_SYSTEM_NAME}" host)
set(pwd ${PLATFORM_REPO_DIR})

if(NOT PLATFORM_INCLUDE_GUARD)
list(INSERT PLATFORM_INCLUDE_GUARD 0 "1")

list(INSERT CMAKE_PROGRAM_PATH 0
  ${pwd}/tool/${host}-${targ}
  ${pwd}/tool/${host})
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
    ${pwd}/resources/${targ}-${SHORT_ARCH}
    ${pwd}/resources/${targ}
    ${pwd}/resources/${targ_os}-${SHORT_ARCH}
    ${pwd}/resources/${targ_os}
    ${pwd}/resources/all)

# TODO: Use install(DIRECTORY) to install without manually searching the resource paths
install(DIRECTORY "${pwd}/resources/all/locales/" DESTINATION "${PROJECT_SOURCE_DIR}/bin/all/locales")

foreach(dir ${CMAKE_LIBRARY_PATH})
  file(GLOB dlls "${dir}/*.dll")
  file(GLOB sos "${dir}/*.so")
  list(APPEND INSTALL_SHARED_LIBS ${dlls})
  list(APPEND INSTALL_SHARED_LIBS ${sos})
endforeach()

foreach(dir ${CMAKE_RESOURCES_PATH})
  file(GLOB exes RELATIVE ${PROJECT_SOURCE_DIR} "${dir}/*")

  # CMake < 3.3 doesn't know LIST_DIRECTORIES false; we do
  # not use it on newer versions either to avoid hiding errors
  list(REMOVE_ITEM exes "platform/resources/all/locales")
  
  list(APPEND INSTALL_RESOURCES ${exes})
endforeach()
 
# Install the portable node version (on windows only currently)
if(WIN32)
  list(APPEND INSTALL_EXES "${pwd}/bin/${targ_os}/${SHORT_ARCH}/node.exe")
 # list(APPEND INSTALL_ADDITIONAL_DEV_TOOLS "${pwd}/bin/${targ_os}/all/npm")
endif()

message(STATUS "CMAKE_PROGRAM_PATH   = ${CMAKE_PROGRAM_PATH}")
message(STATUS "CMAKE_LIBRARY_PATH   = ${CMAKE_LIBRARY_PATH}")
message(STATUS "CMAKE_INCLUDE_PATH   = ${CMAKE_INCLUDE_PATH}")
message(STATUS "INSTALL_EXES         = ${INSTALL_EXES}")
message(STATUS "INSTALL_SHARED_LIBS  = ${INSTALL_SHARED_LIBS}")
message(STATUS "INSTALL_RESOURCES    = ${INSTALL_RESOURCES}")

endif() # Include guard
