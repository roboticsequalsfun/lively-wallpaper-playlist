#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QWKQuick/qwkquickglobal.h>
#include <QQuickStyle>
#include <QQmlContext>
#include <QFile>
#include "configSettings.h"
#include "fileManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    FileManager fileManager;
    ConfigSettings configSettings;
    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.addImportPath("C:/Libraries/QWindowKit/qml");

    QWK::registerTypes(&engine);
    engine.rootContext()->setContextProperty("fileManager", &fileManager);
    engine.rootContext()->setContextProperty("configSettings", &configSettings);
    engine.loadFromModule("gui", "Main");

    return QGuiApplication::exec();
}
