cmake_minimum_required(VERSION 3.21)

set(source
	startpoint/main.cpp
)

add_executable(Nothing ${source})

target_link_libraries(Nothing PRIVATE 
	Qt::Core
	Qt::Gui
	Qt::Qml
	Qt::Quick
	Qt::Widgets
)
