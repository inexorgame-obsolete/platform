set(build_config "$(ConfigurationName)")
set(targ "vs13")
set(sep ";")

set(arch ${MSVC_CXX_ARCHITECTURE_ID})

add_definitions(-DPROTOBUF_USE_DLLS)

include(common_windows)
