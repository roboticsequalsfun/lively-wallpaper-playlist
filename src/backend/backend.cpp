#include <iostream>

int main() {
{
    // Get the current file path and directory path
    string file_path = __FILE__;
    string dir_path = file_path.substr(0, file_path.rfind("\\"));

    // Determine the file path based on the environment
    bool testingEnvironment = isInTestingEnvironment();
    m_filePath = QString::fromStdString(dir_path) + (testingEnvironment ? "/Lively Playlist/config.json" : "/../../config.json");
}

string getRoamingPath() {
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

bool isInTestingEnvironment() {
    for (const auto & entry : fs::directory_iterator("./")) {
        if (entry.is_directory() && entry.path().filename() == "frozen") {
            return true;
        }
    }
    return false;
}