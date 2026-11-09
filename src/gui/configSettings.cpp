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
#include <windows.h>
#include <shlobj.h>
#include <QDir>

namespace fs = std::filesystem;
using namespace std;

ConfigSettings::ConfigSettings(QObject *parent)
    : QObject(parent)
{
    // Get the current file path and directory path
    string file_path = __FILE__;
    string dir_path = file_path.substr(0, file_path.rfind("\\"));

    // Determine the file path based on the environment
    bool testingEnvironment = isInTestingEnvironment();
    m_filePath = QString::fromStdString(dir_path) + (testingEnvironment ? "/Lively Playlist/config.json" : "/../../config.json");

    m_settings = loadSettings();
}

QString ConfigSettings::getRoamingPath() {
    std::filesystem::path standard_path;
    PWSTR path_tmp;

    auto get_folder_path_ret = SHGetKnownFolderPath(FOLDERID_RoamingAppData, 0, nullptr, &path_tmp);

    // Error handling: If the function fails, return an empty string
    if (get_folder_path_ret != S_OK) {
        CoTaskMemFree(path_tmp);
        return QString();
    }

    // Convert the Windows path type to a string 
    standard_path = path_tmp;
    QString path = QString::fromStdString(standard_path.string());

    // Free the memory allocated for the path
    CoTaskMemFree(path_tmp);

    return path;
}

bool ConfigSettings::isInTestingEnvironment() {
    for (const auto & entry : fs::directory_iterator("./")) {   
        if (entry.is_directory() && entry.path().filename() == "frozen") {
            return true;
        }
    }
    return false;
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

void ConfigSettings::saveSetting(Type type, const QVariant& data) {
    QString cleaned_path = "";

    if (type == Type::LivelyPath || type == Type::WallpaperPath) {
        QUrl url = data.toUrl();
        cleaned_path = url.toLocalFile();
    }

    switch (type) {
        case Type::Monitors:
            writeKey("monitors", data);
            break;
        case Type::LivelyPath:
            writeKey("lively_path", cleaned_path);
            break;
        case Type::WallpaperPath:
            writeKey("wallpaper_path", cleaned_path);
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
    QString value = QString::number(hour) + ":" + QString::number(minutes) + ":" + QString::number(seconds);
    return value;
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