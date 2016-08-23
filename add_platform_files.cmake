#### Adds all prebuilts, headers and tools to the CMAKE paths, so it can find them.
## Needs to be included after platform_detection.cmake (or you need to specify PROJECT_ARCH otherwise before)
## Additionally to modifying CMAKE_XXX_PATHs it sets some variables for Install targets, see message at the bottom of this file.

get_filename_component(pwd "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Set specific windows or linux variables.
string(TOLOWER "${CMAKE_GENERATOR}" GEN)
if(GEN MATCHES ".*visual studio.*")
  include(${pwd}/vs_include.cmake)
else()
  include(${pwd}/linux_include.cmake)
endif()

# Check Architecture
set(arch ${PROJECT_ARCH})


list(INSERT CMAKE_PROGRAM_PATH 0
  ${pwd}/tool/${target}
  ${pwd}/tool/${target}-${arch})

list(INSERT CMAKE_INCLUDE_PATH 0
    ${pwd}/include/${target}-${arch}
    ${pwd}/include/${target}
    ${pwd}/include/all)

list(INSERT CMAKE_LIBRARY_PATH 0
  ${pwd}/lib/${target}-${arch})

list(INSERT CMAKE_RESOURCES_PATH 0
  ${pwd}/resources/${target}-${arch}
  ${pwd}/resources/${target}
  ${pwd}/resources/all)


# Look for shared libs (or other stuff which gets placed in the binary folder)
function(list_shared_libs_in_dir OUT_VAR_LIST DIRECTORY)
  file(GLOB dlls "${DIRECTORY}/*.dll")
  file(GLOB sos "${DIRECTORY}/*.so")
  file(GLOB bins "${DIRECTORY}/*.bin")
  list(APPEND LOCAL_LIST ${dlls})
  list(APPEND LOCAL_LIST ${sos})
  list(APPEND LOCAL_LIST ${bins})
  set(${OUT_VAR_LIST} ${LOCAL_LIST} PARENT_SCOPE) # list doesn't allow PARENT_SCOPE
endfunction()

foreach(dir ${CMAKE_LIBRARY_PATH})
  list_shared_libs_in_dir(INSTALL_SHARED_LIBS ${dir})
  list_shared_libs_in_dir(INSTALL_SHARED_LIBS_DEBUG ${dir}/${subdir_debug})
  list_shared_libs_in_dir(INSTALL_SHARED_LIBS_RELEASE ${dir}/${subdir_release})
endforeach()

# Look for resources
foreach(dir ${CMAKE_RESOURCES_PATH})
  file(GLOB RES_FILES_AND_DIRS "${dir}/*")

  # Install stuff differently if its inside a folder (cmake workaround)
  foreach(ITEM ${RES_FILES_AND_DIRS})
    if(IS_DIRECTORY ${ITEM})
      list(APPEND INSTALL_RESOURCES_FOLDERS ${ITEM})
    else()
      list(APPEND INSTALL_RESOURCES ${ITEM})
    endif()
  endforeach()
endforeach()
 
# Install the portable node version (on windows only currently)
if(WIN32)
  list(APPEND INSTALL_EXES "${pwd}/bin/${target}/${arch}/node.exe")
 # list(APPEND INSTALL_ADDITIONAL_DEV_TOOLS "${pwd}/bin/${targ_os}/all/npm")
endif()

message(STATUS "CMAKE_PROGRAM_PATH   = ${CMAKE_PROGRAM_PATH}")
message(STATUS "CMAKE_LIBRARY_PATH   = ${CMAKE_LIBRARY_PATH}")
message(STATUS "CMAKE_INCLUDE_PATH   = ${CMAKE_INCLUDE_PATH}")
message(STATUS "INSTALL_EXES         = ${INSTALL_EXES}")
message(STATUS "INSTALL_SHARED_LIBS  = ${INSTALL_SHARED_LIBS}")
message(STATUS "INSTALL_SHARED_LIBS_DEBUG   = ${INSTALL_SHARED_LIBS_DEBUG}")
message(STATUS "INSTALL_SHARED_LIBS_RELEASE = ${INSTALL_SHARED_LIBS_RELEASE}")
message(STATUS "INSTALL_RESOURCES           = ${INSTALL_RESOURCES}")
message(STATUS "INSTALL_RESOURCES_FOLDERS   = ${INSTALL_RESOURCES_FOLDERS}")
