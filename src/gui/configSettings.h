#ifndef CONFIGSETTINGS_H
#define CONFIGSETTINGS_H
#pragma once

#include <QObject>
#include <QJsonObject>
#include <QString>
#include <qqml.h>
#include <QVariant>

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
        Delay,
        DarkMode
    };
    Q_ENUM(Type)

    explicit ConfigSettings(QObject *parent = nullptr);

    QString getRoamingPath();
    bool isInTestingEnvironment();
    QJsonObject loadSettings();
    void writeKey(QString key, const QVariant& data);

    Q_INVOKABLE QString convertSecToDisplay(int n);
    Q_INVOKABLE QVariant getSetting(Type type);
    Q_INVOKABLE void saveSetting(
        Type type,
        const QVariant& data
    );
private:
    QJsonObject m_settings;
    QString m_filePath;
};

#endif // CONFIGSETTINGS_H
