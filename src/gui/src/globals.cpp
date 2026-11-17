#include "globals.h"
#include <fstream>
#include <QDir>
#include <QDebug>
#include <QDir>
#include <Windows.h>
#include <ShlObj.h>
#include <objbase.h>

#include <filesystem>
#include <QString>

using namespace std;

QString getRoamingPath() {
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

QString g_env = []() {
    std::ifstream Env("../../testing.txt");

    if (!Env.is_open()) {
        return getRoamingPath();
    }
    else {
        QString location = "../../../../";
        return location;
    }
}();
