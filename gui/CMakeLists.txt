cmake_minimum_required(VERSION 3.16)

project(gui VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_PREFIX_PATH "C:/Libraries/QWindowKit")
list(APPEND CMAKE_QML_IMPORT_PATH "C:/Libraries/QWindowKit/qml")
set(QML_IMPORT_PATH "C:/Libraries/QWindowKit/qml" CACHE STRING "QML Import Path" FORCE)

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

set_source_files_properties(Theme.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(appgui
    URI gui
    VERSION 1.0

    QML_FILES
        Main.qml

        HomePage.qml
        GroupingPage.qml
        RulesPage.qml
        SettingsPage.qml
        Panel.qml
        Theme.qml
        BugReport.qml
        TimePicker.qml
        LightSwitch.qml

    RESOURCES
        fonts/SpaceGrotesk-Regular.ttf
        fonts/Nunito-Regular.ttf
        fonts/Roboto-Regular.ttf
        images/bugBlack.png
        images/closeBlack.png
        images/expandBlack.png
        images/folderBlack.png
        images/gearBlack.png
        images/homeBlack.png
        images/minusBlack.png
        images/moonBlack.png
        images/moreBlack.png
        images/settingsBlack.png
        images/sunBlack.png
        images/closeWhite.png
        images/expandWhite.png
        images/folderWhite.png
        images/gearWhite.png
        images/homeWhite.png
        images/minusWhite.png
        images/moonWhite.png
        images/moreWhite.png
        images/settingsWhite.png
        images/sunWhite.png
        images/logo.ico
        images/bugWhite.png
        QML_FILES
        QML_FILES
        QML_FILES SettingsButton.qml
        QML_FILES TopbarButton.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appgui PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appgui
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
