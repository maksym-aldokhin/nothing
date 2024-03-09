configure_file("src/version_config.in" "${CMAKE_CURRENT_BINARY_DIR}/version_config.h")

set(VERSION "0.0.1" CACHE STRING "Nothing Version")

set(sources
        src/NothingVersion.cpp
)

set(headers
        src/NothingVersion.h
)

set(private_header
	"${CMAKE_CURRENT_BINARY_DIR}/version_config.h"
)

add_library(NothingVersion SHARED ${sources} ${headers} ${private_header})

generate_export_header(NothingVersion)

target_include_directories(NothingVersion PUBLIC "${CMAKE_CURRENT_BINARY_DIR}")
adjust_target_output_dir(NothingVersion)
copy_public_headers(TARGET NothingVersion HEADERS ${headers})
