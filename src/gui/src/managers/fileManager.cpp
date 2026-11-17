#include "fileManager.h"
#include "globals.h"
#include <QDesktopServices>
#include <QUrl>
#include <QDir>
#include <QString>
#include <filesystem>

using namespace std;
namespace fs = filesystem;

FileManager::FileManager(QObject *parent)
    : QObject(parent)
    , m_configSettings(new ConfigSettings(this))
{
    m_env = g_env;
}

void FileManager::openConfig() {
    QString file = QDir(m_env).filePath("config.json");
    QUrl fileUrl = QUrl::fromLocalFile(file);
    
    bool success = QDesktopServices::openUrl(fileUrl);

    if (!success) {
        qWarning() << "Failed to open config";
    }
}

void FileManager::openLogs() {
    QString file = QDir(m_env).filePath("logs/lively-playlist.log");
    QUrl fileUrl = QUrl::fromLocalFile(file);
    
    bool success = QDesktopServices::openUrl(fileUrl);

    if (!success) {
        qWarning() << "Failed to open config";
    }
}

void FileManager::createLogReport() {
    fs::path base_dir = m_env.toStdString();
    fs::path dest_dir = base_dir / "report";
    fs::create_directory(dest_dir);
    
    fs::path config_src = base_dir / "config.json";
    fs::copy(config_src, dest_dir / config_src.filename(), fs::copy_options::overwrite_existing);

    fs::path logs_src = base_dir / "logs";
    fs::copy(logs_src, dest_dir / logs_src.filename(), fs::copy_options::recursive | fs::copy_options::overwrite_existing);
}