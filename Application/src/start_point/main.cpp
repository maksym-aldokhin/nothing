#include <QGuiApplication>
#include <QQmlComponent>
#include <QQmlEngine>

#include <Consts/Consts.h>
#include <NothingVersion/NothingVersion.h>

int main(int argc, char *argv[])
{
	QCoreApplication::setApplicationVersion(nothing_version::version.c_str());
	QCoreApplication::setApplicationName(consts::appName);
	QCoreApplication::setOrganizationName(consts::orgName);
	QCoreApplication::setOrganizationDomain(consts::orgDomain);

	QGuiApplication a(argc, argv);

	QQmlEngine engine;
	QQmlComponent component(&engine, ":/qml/main.qml");
	QObject *object = component.create();

	return a.exec();
}
