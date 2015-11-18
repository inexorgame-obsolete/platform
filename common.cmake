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
	
install(DIRECTORY "${pwd}/resources/all/locales/" DESTINATION "${PROJECT_SOURCE_DIR}/bin/all/locales")

foreach(dir ${CMAKE_LIBRARY_PATH})
  file(GLOB dlls "${dir}/*.dll")
  file(GLOB sos "${dir}/*.so")
  list(APPEND INSTALL_SHARED_LIBS ${dlls})
  list(APPEND INSTALL_SHARED_LIBS ${sos})
endforeach()

foreach(dir ${CMAKE_RESOURCES_PATH})
  file(GLOB exes LIST_DIRECTORIES false RELATIVE ${PROJECT_SOURCE_DIR} "${dir}/*")
  
  # CMake < 3.3 doesn't know LIST_DIRECTORIES false
  if(CMAKE_VERSION LESS 3.3)
    list(REMOVE_ITEM exes "inexor/platform/resources/all/locales")
  endif()
  
  list(APPEND INSTALL_RESOURCES ${exes})
endforeach()

# Install the portable node version + npm (on windows only currently)
if(WIN32)
  list(APPEND INSTALL_EXES "${pwd}/bin/${targ_os}/${SHORT_ARCH}/node.exe")
  list(APPEND INSTALL_PORTABLE_DIR "${pwd}/bin/${targ_os}/all/npm")
endif()

message(STATUS "CMAKE_PROGRAM_PATH = ${CMAKE_PROGRAM_PATH}")
message(STATUS "CMAKE_LIBRARY_PATH = ${CMAKE_LIBRARY_PATH}")
message(STATUS "CMAKE_INCLUDE_PATH = ${CMAKE_INCLUDE_PATH}")
message(STATUS "INSTALL_EXES       = ${INSTALL_EXES}")

endif() # Include guard
