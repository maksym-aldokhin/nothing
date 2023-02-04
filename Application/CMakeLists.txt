cmake_minimum_required(VERSION 3.21)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

set(QT_VERSION_MAJOR 6)

project("Nothing")

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt${QT_VERSION_MAJOR} QUIET REQUIRED
	COMPONENTS
	        Core
		Gui
		Qml
		Quick
		Widgets
)

add_subdirectory(src/app)
