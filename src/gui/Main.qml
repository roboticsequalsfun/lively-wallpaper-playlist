import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QWindowKit

ApplicationWindow {
    id: window
    width: 540
    height: 420
    minimumWidth: 520
    minimumHeight: 410
    visible: true
    title: qsTr("Lively Playlist")

    WindowAgent {
        id: windowAgent
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: systemTopBar
            Layout.fillWidth: true
            Layout.preferredHeight: 36
            Layout.maximumHeight: 36
            color: Theme.colorPalette.topbar

            RowLayout {
                anchors.fill: parent

                Image {
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10
                    source: Theme.images.logo
                    width: 14; height: 14;
                }

                Text {
                    text: window.title
                    color: Theme.colorPalette.text
                    font.family: Theme.fonts.roboto
                    font.bold: true
                }

                Item {
                    Layout.fillWidth: true
                }

                TopbarButton {
                    id: minButton
                    buttonRadius: 0
                    labelText: ""
                    Layout.preferredWidth: 36
                    Layout.preferredHeight: 36
                    Layout.maximumWidth: 36
                    Layout.maximumHeight: 36

                    Image {
                        source: Theme.images.minus
                        width: 14; height: 14
                        anchors.centerIn: parent
                    }

                    onClicked: window.showMinimized()
                }

                TopbarButton {
                    id: expandButton
                    buttonRadius: 0
                    labelText: ""
                    Layout.preferredWidth: 36
                    Layout.preferredHeight: 36
                    Layout.maximumWidth: 36
                    Layout.maximumHeight: 36

                    Image {
                        source: Theme.images.expand
                        width: 14; height: 14
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        if (window.visibility === Window.Maximized) {
                            window.showNormal()
                        } else {
                            window.showMaximized()
                        }
                    }
                }

                TopbarButton {
                    id: closeButton
                    labelText: ""
                    buttonRadius: 0
                    Layout.preferredWidth: 36
                    Layout.preferredHeight: 36
                    Layout.maximumWidth: 36
                    Layout.maximumHeight: 36

                    Image {
                        source: Theme.images.close
                        width: 14; height: 14
                        anchors.centerIn: parent
                    }

                    onClicked: window.close()
                }
            }
        }


        Rectangle {
            color: Theme.colorPalette.topbar
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            Layout.maximumHeight: 40

            RowLayout {
                id: topBar
                anchors.fill: parent

                TopbarButton {
                    labelText: "Home"
                    buttonRadius: 8

                    Image {
                        source: Theme.images.home
                        width: 25
                        height: 25
                    }

                    onClicked: {
                        pages.source = "HomePage.qml"
                    }
                }

                TopbarButton {
                    labelText: "Grouping"
                    buttonRadius: 8
                    Layout.preferredWidth: 110
                    Layout.maximumWidth: 110

                    Image {
                        source: Theme.images.folder
                        width: 25
                        height: 25
                    }

                    onClicked: {
                        pages.source = "GroupingPage.qml"
                    }
                }

                TopbarButton {
                    labelText: "Rules"
                    buttonRadius: 8

                    Image {
                        source: Theme.images.settings
                        width: 25
                        height: 25
                    }

                    onClicked: {
                        pages.source = "RulesPage.qml"
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.minimumWidth: 80
                }

                TopbarButton {
                    labelText: ""
                    buttonRadius: 8
                    Layout.preferredWidth: 40
                    Layout.maximumWidth: 40

                    Image {
                        source: Theme.images.bug
                        width: 28
                        height: 28
                        anchors.centerIn: parent
                    }

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

                TopbarButton {
                    labelText: ""
                    buttonRadius: 8
                    Layout.preferredWidth: 40
                    Layout.maximumWidth: 40

                    Image {
                        source: Theme.images.gear
                        width: 25
                        height: 25
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        pages.source = "SettingsPage.qml"
                    }
                }

                TopbarButton {
                    id: moreButton
                    labelText: ""
                    buttonRadius: 8
                    Layout.preferredWidth: 25
                    Layout.maximumWidth: 25

                    Image {
                        source: Theme.images.more
                        width: 25
                        height: 25
                        anchors.centerIn: parent
                    }

                    onClicked: menu.popup(moreButton.x, moreButton.y + moreButton.height)
                }

                Menu {
                    id: menu
                    width: 125

                    background: Rectangle {
                        color: Theme.colorPalette.menu.background
                        anchors.fill: parent
                        radius: 4
                    }

                    MenuItem {
                        id: menuItem
                        text: "Help"
                        height: 30

                        contentItem: Text {
                            text: parent.text
                            font.pointSize: 10
                            font.family: Theme.fonts.main
                            color: Theme.colorPalette.text
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            anchors.fill: parent
                            color: parent.down ? Theme.colorPalette.menu.pressed : (parent.hovered ? Theme.colorPalette.menu.hover : Theme.colorPalette.menu.background)
                            radius: 4
                        }

                        onClicked: {
                            Qt.openUrlExternally("https://github.com/roboticsequalsfun/lively-wallpaper-playlist/blob/main/README.md")
                        }
                    }

                    MenuItem {
                        text: "About"
                        height: 30

                        contentItem: Text {
                            text: parent.text
                            font.pointSize: 10
                            font.family: Theme.fonts.main
                            color: Theme.colorPalette.text
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            anchors.fill: parent
                            color: parent.down ? Theme.colorPalette.menu.pressed : (parent.hovered ? Theme.colorPalette.menu.hover : Theme.colorPalette.menu.background)
                            radius: 4
                        }

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
                color: Theme.colorPalette.background
            }

            Loader {
                id: pages
                anchors.fill: parent
                source: "HomePage.qml"
            }
        }
    }

    Component.onCompleted: {
        windowAgent.setup(window)
        windowAgent.setTitleBar(systemTopBar)

        // Ensure interactive items inside the title bar can still receive clicks
        windowAgent.setHitTestVisible(minButton, true)
        windowAgent.setHitTestVisible(closeButton, true)
        windowAgent.setHitTestVisible(expandButton, true)
    }
}
