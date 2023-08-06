set(sources
	main.cpp
)

set(headers
)

set(qml
	qml/main.qml
)

set(res
	qml/res.qrc
)

add_executable(Nothing ${sources} ${headers} ${res})

qt_add_qml_module(Nothing
	URI NothingCore
	QML_FILES
		${qml}
	RESOURCES
		${res}
)

target_link_libraries(Nothing PRIVATE
	Qt${QT_VERSION_MAJOR}::Core
	Qt${QT_VERSION_MAJOR}::Gui
	Qt${QT_VERSION_MAJOR}::Quick)
