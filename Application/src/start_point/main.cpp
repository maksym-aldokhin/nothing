#include <QGuiApplication>
#include <QQmlComponent>
#include <QQmlEngine>

#include <Consts/Consts.h>
#include <Version/Version.h>

int main(int argc, char *argv[]) {
	QCoreApplication::setApplicationVersion(version::version);
	QCoreApplication::setApplicationName(consts::appName);
	QCoreApplication::setOrganizationName(consts::orgName);
	QCoreApplication::setOrganizationDomain(consts::orgDomain);

	QGuiApplication a(argc, argv);

	QQmlEngine engine;
	QQmlComponent component(&engine, ":/core/main.qml");
	QObject *object = component.create();

	return a.exec();
}
