# Don't include this file directly but add_platform_files.cmake
message(STATUS "Using the Visual Studio Platform file")

set(target "windows")
set(subdir_debug "cpp_debug(MTd)")
set(subdir_release "cpp_release(MT)")


# Wrapper around find_library to autodetect _debug and _release versions of a library
# Documentation: See find_cpp_library in src/cmakelists.txt
function(definition_find_cpp_library RETURNVAR LIBNAME)

    # Look for the debug and release versions
    find_library(${RETURNVAR}_DEBUG   NAMES "${LIBNAME}" PATH_SUFFIXES ${subdir_debug}) # Look in the subdir. TODO: ignore main dir
    find_library(${RETURNVAR}_RELEASE NAMES "${LIBNAME}" PATH_SUFFIXES ${subdir_release})

    if(${RETURNVAR}_DEBUG AND ${RETURNVAR}_RELEASE)
        set(${RETURNVAR} ${${RETURNVAR}_DEBUG} ${${RETURNVAR}_RELEASE} PARENT_SCOPE)
    endif()

    unset(${RETURNVAR}_DEBUG CACHE)
    unset(${RETURNVAR}_RELEASE CACHE)

endfunction()

set(HAS_FIND_LIBRARY_WRAPPER 1)
