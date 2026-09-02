import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import QWindowKit

Window {
    id: window
    width: 250
    height: 185
    minimumWidth: 250
    minimumHeight: 185
    maximumWidth: 250
    maximumHeight: 185
    title: "Report a Bug"
    visible: false

    WindowAgent {
        id: windowAgent
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.colorPalette.background
        z: -1
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

        Column {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            Layout.topMargin: 7
            spacing: 5

            SettingsButton {
                labelText: "Create Report Log"
                anchors.right: parent.right
                anchors.left: parent.left
            }

            SettingsButton {
                labelText: "Report Bug"
                anchors.right: parent.right
                anchors.left: parent.left
            }

            SettingsButton {
                labelText: "Open Log"
                anchors.right: parent.right
                anchors.left: parent.left
            }

            SettingsButton {
                labelText: "Open Config"
                anchors.right: parent.right
                anchors.left: parent.left
            }
        }
    }

    Component.onCompleted: {
        windowAgent.setup(window)
        windowAgent.setTitleBar(systemTopBar)

        // Ensure interactive items inside the title bar can still receive clicks
        windowAgent.setHitTestVisible(closeButton, true)
    }
}