import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    id: window
    width: 500
    height: 400
    minimumWidth: 460
    minimumHeight: 400
    visible: true
    title: qsTr("Lively Playlist")

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            height: 45
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            Rectangle {
                anchors.fill: parent
                height: 50
                color: Theme.topbar
            }

            RowLayout {
                id: topBar
                anchors.fill: parent
                anchors.centerIn: parent

                CustomButton {
                    id: homeButton
                    text: "Home"
                    width: 80

                    onClicked: {
                        pages.source = "HomePage.qml"
                    }
                }

                CustomButton {
                    id: groupingButton
                    text: "Grouping"
                    width: 80

                    onClicked: {
                        pages.source = "GroupingPage.qml"
                    }
                }

                CustomButton {
                    id: rulesButton
                    text: "Rules"
                    width: 80

                    onClicked: {
                        pages.source = "RulesPage.qml"
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.minimumWidth: 80
                }

                CustomButton {
                    id: bugButton
                    text: "BG"
                    width: 36

                    onClicked: {
                        var component = Qt.createComponent("BugReport.qml");
                        if (component.status === Component.Ready) {
                            // Setting mainWindow as the parent manages memory lifecycle
                            var win = component.createObject(Window);
                            win.show();
                        } else {
                            console.error("Error loading component:", component.errorString());
                        }
                    }
                }

                CustomButton {
                    id: settingsButton
                    text: "SE"
                    width: 36

                    onClicked: {
                        pages.source = "SettingsPage.qml"
                    }
                }

                CustomButton {
                    id: moreButton
                    text: ":"
                    width: 30

                    onClicked: menu.popup(moreButton.x, moreButton.y + moreButton.height)
                }

                Menu {
                    id: menu
                    width: 115

                    MenuItem {
                        text: "Help"
                        font.family: Theme.fonts.main

                        onClicked: {
                            Qt.openUrlExternally("https://github.com/roboticsequalsfun/lively-wallpaper-playlist/blob/main/README.md")
                        }
                    }

                    MenuItem {
                        text: "About"
                        font.family: Theme.fonts.main

                        onClicked: {
                            Qt.openUrlExternally("https://github.com/roboticsequalsfun")
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Rectangle {
                anchors.fill: parent
                color: Theme.background
            }

            Loader {
                id: pages
                anchors.fill: parent
                source: "HomePage.qml"
            }
        }
    }
}
