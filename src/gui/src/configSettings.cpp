#include "configSettings.h"
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QCoreApplication>
#include <QDebug>
#include <QString>
#include <QVariant>
#include <filesystem>
#include <filesystem>
#include <QDir>
#include "globals.h"

namespace fs = std::filesystem;
using namespace std;

ConfigSettings::ConfigSettings(QObject *parent) 
    : QObject(parent)
{
    m_filePath = g_env + "config.json";
    m_settings = loadSettings();
}

QJsonObject ConfigSettings::loadSettings() {
    QFile file(m_filePath);

    if (!file.open(QIODevice::ReadOnly)) {
        QString warning = QString("Could not open setting file from: %1").arg(m_filePath);
        qWarning() << warning;
        return QJsonObject();
    }

    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(file.readAll(), &error);

    if (error.error != QJsonParseError::NoError) {
        QString warning = QString("Error parsing JSON from: %1").arg(m_filePath);
        qWarning() << warning;
        return QJsonObject();
    }
    QJsonObject json = doc.object();

    return json;
}

void ConfigSettings::showMessage(QString title, QString message) {
    emit messageRequested(title, message);
}

void ConfigSettings::changeText(QString text) {
    emit textChangeRequested(text);
}

QString ConfigSettings::validateWallpaperPath(QString path) {
    filesystem::path std_path(path.toStdString());
    QString last_element = QString::fromStdString(std_path.filename().string());

    if (last_element != "wptmp")
        std_path /= "SaveData/wptmp";
    else if (last_element == "SaveData")
        std_path /= "wptmp";

    if (filesystem::exists(std_path)) {
        return QString::fromStdString(std_path.string());
    } else {
        showMessage("Invalid Path", "The provided directory is not a lively wallpaper directory. Please select a valid path.");
        return QString();
    }
}

void ConfigSettings::saveSetting(Type type, const QVariant& data) {
    QString path = "";

    if (type == Type::LivelyPath || type == Type::WallpaperPath) {
        path = QUrl(data.toString()).toLocalFile();

        if (type == Type::WallpaperPath) {
            path = validateWallpaperPath(path);

            if (path.isEmpty()) {
                return;
            }
        }

        path.replace('/', '\\');
    }

    switch (type) {
        case Type::Monitors:
            writeKey("monitors", data);
            break;
        case Type::LivelyPath:
            writeKey("lively_path", path);
            break;
        case Type::WallpaperPath:
            writeKey("wallpaper_path", path);
            break;
        case Type::Delay:
            writeKey("delay_seconds", data);
            break;
        case Type::DarkMode:
            writeKey("dark_mode", data);
            break;
    }

    // Reset the settings object to ensure it reflects the latest changes
    m_settings = loadSettings();
}

QVariant ConfigSettings::getSetting(Type type) {
    switch (type) {
        case Type::Monitors:
            return QVariant(m_settings["monitors"].toInt());
        case Type::LivelyPath:
            return QVariant(m_settings["lively_path"].toString());
        case Type::WallpaperPath:
            return QVariant(m_settings["wallpaper_path"].toString());
        case Type::Delay:
            return QVariant(convertSecToDisplay(m_settings["delay_seconds"].toInt()));
        case Type::DarkMode:
            return QVariant(m_settings["dark_mode"].toBool());
        case Type::Environment:
            return QVariant(m_settings["environment"].toString());
        default:
            return {};
    }
}

QString ConfigSettings::convertSecToDisplay(int n)
{
    // Convert seconds to hours, minutes, and seconds
    n = n % (24 * 3600);
    int hour = n / 3600;

    n %= 3600;
    int minutes = n / 60 ;

    n %= 60;
    int seconds = n;
    
    // Format the result as a string in the format "HH:MM:SS"

    QString value = QString::asprintf("%01d:%02d:%02d", hour, minutes, seconds);
    return value;
}

QVariantMap ConfigSettings::getValueFromDisplay(QString displayValue) {
    // Split the display value into hours, minutes, and seconds
    QVariantMap map;
    map.insert("hours", 0);
    map.insert("minutes", 0);
    map.insert("seconds", 0);

    QStringList parts = displayValue.split(':');
    if (parts.size() != 3) {
        return map;
    }

    map.insert("hours", parts[0].toInt());
    map.insert("minutes", parts[1].toInt());
    map.insert("seconds", parts[2].toInt());

    return map;
}

int ConfigSettings::convertDisplayToSec(QString hours, QString minutes, QString seconds)
{
    // Convert hours, minutes, and seconds to total seconds
    int totalSeconds = hours.toInt() * 3600 + minutes.toInt() * 60 + seconds.toInt();
    return totalSeconds;
}

void ConfigSettings::writeKey(QString key, const QVariant& data) {
    m_settings[key] = QJsonValue::fromVariant(data);

    QFile file(m_filePath);

    if (file.open(QIODevice::WriteOnly)) {
        QJsonDocument doc(m_settings);
        file.write(doc.toJson());
        file.close();
    } else {
        QString warning = QString("Could not open setting file for writing: %1").arg(m_filePath);
        qWarning() << warning;
    }
}