### Windows Specific files and definitions


# Install shared libs to the Executable output dir
install(
    DIRECTORY ${pwd}/${EXE_SUB_DIR}/
    DESTINATION ${EXE_DIR}
    PATTERN "*")

if(MSVC)
  set(mode $(ConfigurationName))
  set(host windows)
  set(targ vs)
else() # linux; TODO: Mac support for cross compile?
  set(mode "")
  set(host linux)
  set(targ mingw)
endif()

set(pwd ${CMAKE_CURRENT_SOURCE_DIR})
set(arch ${PROJECT_ARCH})

set(ENV{PATH} "${pwd}/tool/${host}:$ENV{PATH}")  # $PATH
set(CMAKE_INCLUDE_PATH                           # includes
  ${pwd}/include
  ${CMAKE_INCLUDE_PATH} CACHE INTERNAL "")
set(ENV{CMAKE_LIBRARY_PATH}                 # libs
  ${pwd}/lib/common${arch}
  ${pwd}/lib/${targ}${arch}${mode}
  $ENV{CMAKE_LIBRARY_PATH} CACHE INTERNAL "")

if (MSVC)
  add_definitions(-DPROTOBUF_USE_DLLS)
endif()
