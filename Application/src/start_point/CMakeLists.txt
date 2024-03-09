set(sources
	main.cpp
)

set(headers
)

set(qml
	qml/Editor.qml
	qml/main.qml
)

add_executable(Nothing ${sources} ${headers})

qt6_add_resources(Nothing "core"
	PREFIX
		"/"
	FILES
		${qml}
)

target_link_libraries(Nothing PRIVATE
	Qt${QT_VERSION_MAJOR}::Core
	Qt${QT_VERSION_MAJOR}::Gui
	Qt${QT_VERSION_MAJOR}::Qml
	Qt${QT_VERSION_MAJOR}::Quick
	Qt${QT_VERSION_MAJOR}::Widgets
	NothingVersion
	Consts
)
