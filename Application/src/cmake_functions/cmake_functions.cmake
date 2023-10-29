include_guard()

function(adjust_target_output_dir)
	cmake_parse_arguments(ARG "" "ADDITIONAL_DIR_NAME" "" ${ARGN})

	set(outdir ${EXECUTABLE_OUTPUT_PATH})
	if(ARG_ADDITIONAL_DIR_NAME)
		set(outdir "${EXECUTABLE_OUTPUT_PATH}/${ARG_ADDITIONAL_DIR_NAME}")
	endif()

	foreach(target ${ARG_UNPARSED_ARGUMENTS})
		set_target_properties(${target}
			PROPERTIES
				ARCHIVE_OUTPUT_DIRECTORY "${outdir}"
				LIBRARY_OUTPUT_DIRECTORY "${outdir}"
				RUNTIME_OUTPUT_DIRECTORY "${outdir}"
		)
	endforeach()
endfunction()

function(cleanup_includedir INCLUDEDIR HEADERS)
	file(GLOB_RECURSE old_headers LIST_DIRECTORIES false "${INCLUDEDIR}/*")
	list(SORT HEADERS)
	list(SORT old_headers)
	foreach(header IN LISTS old_headers)
		list(FIND HEADERS "${CUT}${header}" index)
		if(index EQUAL -1)
			file(REMOVE "${header}")
		endif()
	endforeach()
endfunction()

function(copy_public_headers)
	cmake_parse_arguments(ARG "" "TARGET;DIR;HEADERS" "" ${ARGN})

	if(NOT ARG_TARGET ${TARGET})
		message(FATAL_ERROR "Target ${TARGET} does not exist.")
	endif()

	if(NOT ARG_DIR)
		set(ARG_DIR ${ARG_TARGET})
	endif()

	set(public_headers)

	foreach(header IN LISTS ARG_HEADERS)
		if(NOT hdr MATCHES "^.+_p\\.h$")
			list(APPEND public_headers ${header})
		endif()
	endforeach()

	set(includeroot "${CMAKE_CURRENT_BINARY_DIR}/include")
	set(includedir "${CMAKE_CURRENT_BINARY_DIR}/include/${ARG_DIR}")

	if(NOT EXISTS "${includedir}")
		file(MAKE_DIRECTORY "${includedir}")
	endif()

	set(proxy_headers)
	foreach(header IN LISTS public_headers)
		get_filename_component(public_header "${header}" NAME)

		set(proxy_path "${includedir}/${public_header}")
		string(REGEX REPLACE "//+" "/" proxy_path "${proxy_path}")
		list(APPEND proxy_headers "${proxy_path}")

		if(NOT IS_ABSOLUTE "${header}")
			set(header "${CMAKE_CURRENT_SOURCE_DIR}/${header}")
		endif()

		file(GENERATE OUTPUT "${proxy_path}" CONTENT "#include \"${header}\"\n")
	endforeach()

	cleanup_includedir("${includedir}" "${proxy_headers}")

	target_include_directories(${ARG_TARGET} INTERFACE "${includeroot}")
endfunction()
