#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QWKQuick/qwkquickglobal.h>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.addImportPath("C:/Libraries/QWindowKit/qml");

    QWK::registerTypes(&engine);
    engine.loadFromModule("gui", "Main");

    return QGuiApplication::exec();
}
