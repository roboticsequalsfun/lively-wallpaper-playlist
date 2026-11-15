#pragma once

#include <QObject>
#include <QJsonObject>
#include <QString>
#include <qqmlregistration.h>
#include <QVariant>

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
        DarkMode,
        Environment
    };
    Q_ENUM(Type)

    explicit ConfigSettings(QObject *parent = nullptr);

    QJsonObject loadSettings();
    void writeKey(QString key, const QVariant& data);

    QString validateWallpaperPath(QString path);

    Q_INVOKABLE void showMessage(QString title, QString message);
    Q_INVOKABLE void changeText(QString text);
    Q_INVOKABLE QString convertSecToDisplay(int n);
    Q_INVOKABLE int convertDisplayToSec(QString hours, QString minutes, QString seconds);
    Q_INVOKABLE QVariantMap getValueFromDisplay(QString displayValue);
    Q_INVOKABLE QVariant getSetting(Type type);
    Q_INVOKABLE void saveSetting(
        Type type,
        const QVariant& data
    );
signals:
    void messageRequested(QString title, QString message);
    void textChangeRequested(QString text);
private:
    QJsonObject m_settings;
    QString m_filePath;
};
