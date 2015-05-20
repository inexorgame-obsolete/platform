message(STATUS "Using the Visual Studio Toolchain file")

set(CMAKE_SYSTEM_NAME Windows)

set(targ "vs2013")
set(targ_os "win")
set(sep ";")

# Check Architecture
if(CMAKE_GENERATOR MATCHES ".*64.*")
    set(SHORT_ARCH "win64")
else()
    set(SHORT_ARCH "win32")
endif()

add_definitions(-DPROTOBUF_USE_DLLS)

get_filename_component(PLATFORM_REPO_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Wrapper around find_library to autodetect _debug and _release versions of a library
# Documentation: See find_cpp_library in src/cmakelists.txt
function(definition_find_cpp_library RETURNVAR LIBNAME)

    # Look for the debug and release versions
    find_library(${RETURNVAR}_DEBUG   "${LIBNAME}_debug")
    find_library(${RETURNVAR}_RELEASE "${LIBNAME}_release")

    if(${RETURNVAR}_DEBUG AND ${RETURNVAR}_RELEASE)
        set(${RETURNVAR} ${${RETURNVAR}_DEBUG} ${${RETURNVAR}_RELEASE} PARENT_SCOPE)
    endif()

    unset(${RETURNVAR}_DEBUG CACHE)
    unset(${RETURNVAR}_RELEASE CACHE)

endfunction()

set(HAS_FIND_LIBRARY_WRAPPER 1)

include(${PLATFORM_REPO_DIR}/common.cmake)
