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
            from: 1
            to: 100
            editable: true
            width: 100
            height: 30

            contentItem: TextInput {
                z: 2
                text: monitorSpinBox.textFromValue(monitorSpinBox.value, monitorSpinBox.locale)
                font.family: Theme.fonts.main
                font.pixelSize: 15
                color: Theme.colorPalette.text
                selectionColor: Theme.colorPalette.spinBox.textSelection
                selectedTextColor: Theme.colorPalette.spinBox.textSelected
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                validator: monitorSpinBox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            up.indicator: Rectangle {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 5
                height: 20
                width: 20
                radius: 5
                color: monitorSpinBox.up.hovered ? Theme.colorPalette.spinBox.buttonHovered : Theme.colorPalette.spinBox.buttonNormal

                Text {
                    text: "+"
                    font.pixelSize: 16
                    color: monitorSpinBox.value < monitorSpinBox.to ? Theme.colorPalette.spinBox.buttonEnabled : Theme.colorPalette.spinBox.buttonDisabled
                    anchors.centerIn: parent
                }
            }

            down.indicator: Rectangle {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 5
                height: 20
                width: 20
                radius: 5
                color: monitorSpinBox.down.hovered ? Theme.colorPalette.spinBox.buttonHovered : Theme.colorPalette.spinBox.buttonNormal

                Text {
                    text: "-"
                    font.pixelSize: 16
                    color: monitorSpinBox.value > monitorSpinBox.from ? Theme.colorPalette.spinBox.buttonEnabled : Theme.colorPalette.spinBox.buttonDisabled
                    anchors.centerIn: parent
                }
            }

            background: Rectangle {
                radius: 8
                color: Theme.colorPalette.spinBox.background
                border.width: 1
                border.color: Theme.colorPalette.spinBox.border
            }

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

        Label {
            text: "1:05:30"
            font.family: Theme.fonts.main
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
    }

    Panel {
        id: panel3
        labelText: "Path to Lively Installation"

        SettingsButton {
            labelText: "Delay"
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

        SettingsButton {
            labelText: "Delay"
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