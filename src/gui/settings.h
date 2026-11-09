#ifndef CONFIGSETTINGS_H
#define CONFIGSETTINGS_H

#include <QObject>
#include <QJsonObject>
#include <QString>
#include <qqml.h>

using std::variant;

class ConfigSettings : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    enum class Type {
        Monitors,
        LivelyPath,
        WallpaperPath,
        Delay
    };
    Q_ENUM(Type)

    explicit ConfigSettings(QObject *parent = nullptr);

    QString getRoamingPath();
    bool isInTestingEnvironment();
    QJsonObject loadSettings();
    void writeKey(QString path, int number, QString key);

    Q_INVOKABLE QString convertSecToDisplay(int n);
    Q_INVOKABLE variant<int, QString> getSetting(Type type);
    Q_INVOKABLE void saveSetting(
        Type type,
        int value = -1,
        const QString& path = QString()
    );
private:
    QJsonObject m_settings;
    QString m_filePath;
};

#endif // CONFIGSETTINGS_H
