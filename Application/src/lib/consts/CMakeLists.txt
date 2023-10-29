set(sources
	src/Consts.cpp
)

set(headers
	src/Consts.h
)

add_library(Consts SHARED ${sources} ${headers})

generate_export_header(Consts)

target_include_directories(Consts PUBLIC "${CMAKE_CURRENT_BINARY_DIR}")
adjust_target_output_dir(Consts)
copy_public_headers(TARGET Consts HEADERS ${headers})
