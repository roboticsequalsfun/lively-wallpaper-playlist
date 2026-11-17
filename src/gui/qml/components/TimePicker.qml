import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

Popup {
    id: popup

    width: 300
    height: 300
    modal: true
    focus: true

    padding: 0

    background: Rectangle {
        color: Theme.colorPalette.popup.background
        radius: 20
        border.color: Theme.colorPalette.popup.border
        border.width: 1
    }

    FontMetrics {
        id: fontMetrics
    }

    Component {
        id: delegateComponent

        Label {
            // Access the custom property on the Tumbler instance
            readonly property bool paddingEnabled: Tumbler.tumbler.padZeroes ?? true

            text: formatText(Tumbler.tumbler.count, modelData, paddingEnabled)
            color: Theme.colorPalette.text
            font.family: Theme.fonts.main
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (3 / 2)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: fontMetrics.font.pixelSize * 3

            function formatText(count, modelData, pad) {
                var data = count === 12 ? modelData + 1 : modelData;
                if (pad) {
                    return data < 10 ? "0" + data : data.toString();
                }
                return data.toString();
            }
        }
    }

    Column {
        anchors.centerIn: parent
        anchors.fill: parent

        Label {
            text: "Time Between Shuffles"
            font.pixelSize: 25
            color: Theme.colorPalette.text
            font.family: Theme.fonts.roboto
            height: 30
            topPadding: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row {
            id: row
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 10
            topPadding: 10

            property var display: configSettings.getValueFromDisplay(configSettings.getSetting(ConfigSettings.Delay))

            Tumbler {
                id: hoursTumbler
                width: 60

                model: 13
                delegate: delegateComponent
                currentIndex: row.display.hours
                property bool padZeroes: false // Disable padding for hours
            }

            Label {
                text: ":"
                width: 10

                color: Theme.colorPalette.text
                font.family: Theme.fonts.main
                font.pixelSize: 25
                anchors.verticalCenter: parent.verticalCenter
            }

            Tumbler {
                id: minutesTumbler
                width: 60

                model: 60
                delegate: delegateComponent
                currentIndex: row.display.minutes
                property bool padZeroes: true  // Enable padding for minutes
            }

            Label {
                text: ":"
                width: 10

                color: Theme.colorPalette.text
                font.family: Theme.fonts.main
                font.pixelSize: 25

                anchors.verticalCenter: parent.verticalCenter
            }

            Tumbler {
                id: secondsTumbler
                width: 60

                model: 60
                currentIndex: row.display.seconds
                delegate: delegateComponent
                property bool padZeroes: true  // Enable padding for seconds
            }
        }

        SettingsButton {
            id: confirm
            width: 65
            height: 30

            labelText: "Confirm"
            border: 0
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                configSettings.saveSetting(
                    ConfigSettings.Delay,
                    configSettings.convertDisplayToSec(
                        hoursTumbler.currentItem.text,
                        minutesTumbler.currentItem.text,
                        secondsTumbler.currentItem.text,
                    )
                )
                configSettings.changeText(
                    hoursTumbler.currentItem.text +
                    ":" +  minutesTumbler.currentItem.text +
                    ":" + secondsTumbler.currentItem.text
                )
                popup.close()
            }
        }
    }
}