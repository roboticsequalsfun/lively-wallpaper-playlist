import QtQuick
import QtQuick.Layouts
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs
Item {
    ColumnLayout {
        id: panels
        anchors.fill: parent
        spacing: 0

        Panel {
            id: panel1
            labelText: "Number Of Monitors"

            MonitorSpinBox {
                id: monitorSpinBox
                from: 1
                to: 100
                value: configSettings.getSetting(ConfigSettings.Monitors)
                width: 100
                height: 30

                onValueChanged: {
                    configSettings.saveSetting(ConfigSettings.Monitors, value)
                }
            }
        }

        Panel {
            id: panel2
            labelText: "Wallpaper Shuffle Delay"

            Label {
                id: timePickerLabel
                text: configSettings.getSetting(ConfigSettings.Delay)
                font.family: Theme.fonts["main"]
                color: Theme.colorPalette.text
                font.pixelSize: 20
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: false

                    onClicked: {
                        timePicker.open()
                    }
                }
            }

            Connections {
                target: configSettings

                function onTextChangeRequested(text) {
                    timePickerLabel.text = text
                }
            }
        }

        Panel {
            id: panel3
            labelText: "Path to Lively Installation"

            SettingsButton {
                labelText: "Browse"
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }

                onClicked: livelyInstallation.open()
            }

            FileDialog {
                id: livelyInstallation
                currentFolder: "file:///C:/"
                nameFilters: ["Lively Installation(Lively.exe)"]
                onAccepted: configSettings.saveSetting(ConfigSettings.LivelyPath, selectedFile)
            }
        }

        Panel {
            id: panel4
            labelText: "Path to Wallpapers"

            SettingsButton {
                labelText: "Browse"
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }

                onClicked: livelyWallpapers.open()
            }

            FolderDialog {
                id: livelyWallpapers
                currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
                onAccepted: configSettings.saveSetting(ConfigSettings.WallpaperPath, selectedFolder)
            }
        }

        Panel {
            id: panel5
            labelText: "Dark Mode"

            LightSwitch {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }
            }
        }
    }

    Item {
        anchors.centerIn: parent

        InformationDialog {
            id: messageDialog
            title: "Information"
            text: "Information you probably need, I think... Maybe..."
            anchors.centerIn: parent
            width: 300
            height: 200
        }

        Connections {
            target: configSettings

            function onMessageRequested(title, message) {
                messageDialog.title = title
                messageDialog.text = message
                messageDialog.open()
            }
        }
    }

    TimePicker {
        id: timePicker
        anchors.centerIn: parent
    }
}