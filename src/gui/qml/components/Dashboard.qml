import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../pages"
import "../"

Rectangle {
    property Loader loader
    color: Theme.colorPalette.dashboard.background

    ColumnLayout {
        id: dashboard
        anchors.fill: parent
        spacing: 5

        DashboardButton {
            labelText: "Home"
            Layout.fillWidth: true
            Layout.topMargin: 15

            Image {
                source: Theme.images.home
                width: 20
                height: 20
            }

            onClicked: {
                loader.source = "pages/HomePage.qml"
            }
        }

        DashboardButton {
            labelText: "Grouping"
            Layout.fillWidth: true

            Image {
                source: Theme.images.folder
                width: 20
                height: 20
            }

            onClicked: {
                loader.source = "pages/GroupingPage.qml"
            }
        }

        DashboardButton {
            labelText: "Rules"
            Layout.fillWidth: true

            Image {
                source: Theme.images.settings
                width: 20
                height: 20
            }

            onClicked: {
                loader.source = "pages/RulesPage.qml"
            }
        }

        DashboardButton {
            labelText: "Settings"

            Image {
                source: Theme.images.gear
                width: 20
                height: 20
            }

            onClicked: {
                loader.source = "pages/SettingsPage.qml"
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        DashboardButton {
            labelText: "Report a bug"

            Image {
                source: Theme.images.bug
                width: 20
                height: 20
            }

            onClicked: {
                var component = Qt.createComponent("../BugReport.qml");
                if (component.status === Component.Ready) {
                    // Setting mainWindow as the parent manages memory lifecycle
                    var win = component.createObject(Window);
                    win.show();
                } else {
                    console.error("Error loading component:", component.errorString());
                }
            }
        }

        DashboardButton {
            id: helpButton
            labelText: "Help"

            // Image {
            //     source: Theme.images.about
            //     width: 25
            //     height: 25
            //     anchors.centerIn: parent
            // }

            onClicked: {
                Qt.openUrlExternally("https://github.com/roboticsequalsfun/lively-wallpaper-playlist/blob/main/README.md")
            }
        }

        DashboardButton {
            id: aboutButton
            labelText: "About"
            Layout.bottomMargin: 15

            // Image {
            //     source: Theme.images.about
            //     width: 25
            //     height: 25
            //     anchors.centerIn: parent
            // }

            onClicked: {
                Qt.openUrlExternally("https://github.com/roboticsequalsfun")
            }
        }
    }
}