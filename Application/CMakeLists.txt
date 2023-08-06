cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

set(QT_VERSION_MAJOR 6)

project("Nothing")

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/out)

find_package(Qt${QT_VERSION_MAJOR} QUIET REQUIRED
	COMPONENTS
		Core
		Gui
		Qml
		Quick
		Widgets
)

add_subdirectory(src)

add_custom_target(create_release_zip
	COMMAND python ../.github/util/collect.py -t "*.dll" "*.exe" "qmldir" "plugins.qmltypes" -s "${EXECUTABLE_OUTPUT_PATH}" -d "${CMAKE_BINARY_DIR}/Nothing"
	COMMAND ${CMAKE_COMMAND} -E tar "cfv" "Nothing.zip" --format=zip "${CMAKE_BINARY_DIR}/Nothing"
)
