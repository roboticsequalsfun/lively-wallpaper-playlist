#include "fileManager.h"
#include <cstdlib>

using namespace std;

FileManager::FileManager(QObject *parent)
    : QObject(parent)
{
    m_env = m_configSettings->getSetting(ConfigSettings::Type::Environment).toString();
}

void FileManager::openConfig() {
    QString command = "start \"\" \"" + m_env + "config.json\"";
    system(command.toStdString().c_str());
}

void FileManager::openLogs() {
    QString command = "start \"\" \"" + m_env + "logs\"lively-playlist.log\"";
    system(command.toStdString().c_str());
}

void FileManager::createLogReport() {

}