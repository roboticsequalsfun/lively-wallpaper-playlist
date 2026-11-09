#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QWKQuick/qwkquickglobal.h>
#include <QQuickStyle>
#include <QQmlContext>
#include <QFile>
#include "configSettings.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

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
    engine.rootContext()->setContextProperty("configSettings", &configSettings);
    engine.loadFromModule("gui", "Main");

    return QGuiApplication::exec();
}
