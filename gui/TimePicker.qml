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

            Tumbler {
                id: hoursTumbler
                width: 60
                model: 13
                delegate: delegateComponent
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
                delegate: delegateComponent
                property bool padZeroes: true  // Enable padding for seconds
            }
        }

        Button {
            id: confirm
            width: 65
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter

            background: Rectangle {
                radius: 8
                anchors.fill: parent

                color: confirm.pressed
                       ? Theme.colorPalette.settingsButton.pressed
                       : confirm.hovered
                         ? Theme.colorPalette.settingsButton.hover
                         : Theme.colorPalette.settingsButton.normal

                border.width: 1.5
                border.color: Theme.colorPalette.settingsButton.border
            }

            Text {
                text: "Confirm"
                color: Theme.colorPalette.text
                anchors.centerIn: parent
                font.pixelSize: 15
                font.family: Theme.fonts.main
            }

            onClicked: popup.close()
        }
    }
}

