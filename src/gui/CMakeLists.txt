cmake_minimum_required(VERSION 3.16)
project(gui VERSION 0.1 LANGUAGES CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_PREFIX_PATH "C:/Libraries/QWindowKit")
list(APPEND CMAKE_QML_IMPORT_PATH "C:/Libraries/QWindowKit/qml")
set(QWindowKit_DIR
    "C:/Libraries/QWindowKit/lib/cmake/QWindowKit"
)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2)
find_package(QWindowKit REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

# Content of downloaded design from Figma to Qt or similar
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

set(CMAKE_VERBOSE_MAKEFILE ON)

qt_add_executable(appgui
    main.cpp
)

target_sources(appgui PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/../../resources.qrc"
)

target_include_directories(appgui PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/src/managers
)

set_source_files_properties(qml/Theme.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appgui
    URI gui
    VERSION 1.0

    QML_FILES
        qml/Main.qml
        qml/pages/HomePage.qml
        qml/pages/GroupingPage.qml
        qml/pages/RulesPage.qml
        qml/pages/SettingsPage.qml
        qml/components/Panel.qml
        qml/Theme.qml
        qml/BugReport.qml
        qml/components/TimePicker.qml
        qml/components/LightSwitch.qml
        qml/components/SettingsButton.qml
        qml/components/TopbarButton.qml
        qml/components/MonitorSpinBox.qml
        qml/components/InformationDialog.qml
    SOURCES
    	src/configSettings.h
        src/configSettings.cpp
        src/managers/communicator.h 
	src/managers/communicator.cpp
        src/managers/fileManager.h 
	src/managers/fileManager.cpp
        src/globals.h 
	src/globals.cpp
        QML_FILES qml/components/Dashboard.qml
        QML_FILES qml/components/TopBar.qml
        QML_FILES qml/components/DashboardButton.qml
)

set_target_properties(appgui PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appgui PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
    QWindowKit::Quick
)

install(TARGETS appgui
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
