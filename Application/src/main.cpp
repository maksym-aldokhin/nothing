#include <QGuiApplication>
#include <QQmlComponent>
#include <QQmlEngine>

int main(int argc, char *argv[]) {
	QGuiApplication a(argc, argv);

	QQmlEngine engine;
	QQmlComponent component(&engine, ":/core/main.qml");
	QObject *object = component.create();

	return a.exec();
}
