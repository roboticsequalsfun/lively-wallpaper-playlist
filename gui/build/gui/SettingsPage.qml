import QtQuick
import QtQuick.Layouts
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs

ColumnLayout {
    anchors.fill: parent
    spacing: 0

    Panel {
        id: panel1
        labelText: "Number Of Monitors"

        SpinBox {
            id: monitorSpinBox
            width: 80

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 10
            }
        }
    }

    Panel {
        id: panel2
        labelText: "Wallpaper Shuffle Delay"

        CustomButton {
            text: "Delay"
            normalColor: Theme.settingsButton.normal
            hoverColor: Theme.settingsButton.hover
            pressedColor: Theme.settingsButton.pressed
            borderOn: true

            width: 65
            height: 30

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 10
            }

            onClicked: timePicker.open()
        }
    }

    Panel {
        id: panel3
        labelText: "Path to Lively Installation"

        CustomButton {
            text: "Browse"
            normalColor: Theme.settingsButton.normal
            hoverColor: Theme.settingsButton.hover
            pressedColor: Theme.settingsButton.pressed
            borderOn: true

            width: 65
            height: 30

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
            nameFilters: ["EXE files(*.exe)"]
        }
    }

    Panel {
        id: panel4
        labelText: "Path to Wallpapers"

        CustomButton {
            text: "Browse"
            normalColor: Theme.settingsButton.normal
            hoverColor: Theme.settingsButton.hover
            pressedColor: Theme.settingsButton.pressed
            borderOn: true

            width: 65
            height: 30

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
        }
    }

    Panel {
        id: panel5
        labelText: "Light Mode"

        LightSwitch {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 10
            }
        }
    }

    TimePicker {
        id: timePicker
        anchors.centerIn: parent
    }
}