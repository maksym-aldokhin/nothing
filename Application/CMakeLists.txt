cmake_minimum_required(VERSION 3.21)

include(GenerateExportHeader)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 23)

set(QT_VERSION_MAJOR 6)

project("Nothing" LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/out)

file(GLOB cmake_function_files "src/cmake_functions/*.cmake")
foreach(cmake_file ${cmake_function_files})
	include(${cmake_file})
endforeach()

find_package(Qt${QT_VERSION_MAJOR} QUIET REQUIRED
	COMPONENTS
		Core
		Gui
		Qml
		Quick
		Widgets
)

if(MSVC)
	add_compile_options(
		/we4715 # not all control paths return a value
		/we4716 # 'function' must return a value
		/we4172 # returning address of local variable or temporary
		/bigobj
	)
else()
	#non-void function should return a value, do not return address of local variable or temporary
	add_compile_options(-Werror=return-type -Werror=return-stack-address)
endif()

add_subdirectory(src/lib/consts)
add_subdirectory(src/lib/nothing_version)
add_subdirectory(src/start_point)

add_custom_target(copy_binary_files
	COMMAND "${WINDEPLOYQT_EXECUTABLE}" $<TARGET_FILE:Nothing> --dir "${CMAKE_BINARY_DIR}/Nothing" --qmldir "${CMAKE_SOURCE_DIR}" --no-virtualkeyboard --no-system-d3d-compiler
)

add_custom_target(create_release_zip
	COMMAND python ../.github/util/collect.py -t "*.dll" "*.exe" "qmldir" "plugins.qmltypes" -s "${EXECUTABLE_OUTPUT_PATH}" -d "${CMAKE_BINARY_DIR}/Nothing"
	COMMAND ${CMAKE_COMMAND} -E tar "cfv" "Nothing.zip" --format=zip "${CMAKE_BINARY_DIR}/Nothing"
	DEPENDS copy_binary_files
)
