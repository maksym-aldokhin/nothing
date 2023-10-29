configure_file("src/version_config.in" "${CMAKE_CURRENT_BINARY_DIR}/version_config.h")

set(VERSION "0.0.1" CACHE STRING "Nothing Version")

set(sources
	src/Version.cpp
)

set(headers
	src/Version.h
)

set(private_header
	"${CMAKE_CURRENT_BINARY_DIR}/version_config.h"
)

add_library(Version SHARED ${sources} ${headers} ${private_header})

generate_export_header(Version)

target_include_directories(Version PUBLIC "${CMAKE_CURRENT_BINARY_DIR}")
adjust_target_output_dir(Version)
copy_public_headers(TARGET Version HEADERS ${headers})
