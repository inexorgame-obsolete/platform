
message(STATUS "Using the Visual Studio Toolchain file")

set(targ "vs2013")
set(sep ";")

# Check Architecture
if(CMAKE_GENERATOR MATCHES ".*64.*")
    set(SHORT_ARCH "win64")
else()
    set(SHORT_ARCH "win32")
endif()

add_definitions(-DPROTOBUF_USE_DLLS)

get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
include(${PLATFORM_REPO_DIR}/common_windows.cmake)

# Wrapper around find_library to autodetect _debug and _release versions of a library
# Documentation: See find_cpp_library in src/cmakelists.txt
function(definition_find_cpp_library RETURNVAR LIBNAME)

    # Look for the debug and release versions
    find_library(${RETURNVAR}_DEBUG   "${LIBNAME}_debug")
    find_library(${RETURNVAR}_RELEASE "${LIBNAME}_release")

    if(${RETURNVAR}_DEBUG AND ${RETURNVAR}_RELEASE)
        set(${RETURNVAR} ${${RETURNVAR}_DEBUG} ${${RETURNVAR}_RELEASE} CACHE INTERNAL "found cpp lib")
    endif()

endfunction()

set(HAS_FIND_LIBRARY_WRAPPER 1)

