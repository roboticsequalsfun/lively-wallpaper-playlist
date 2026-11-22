pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: button
    property string labelText: "I'm a button, capisce?"
    property real buttonRadius: 8
    default property alias contentData: container.data
    Layout.fillWidth: true
    Layout.preferredHeight: 30
    Layout.alignment: Qt.AlignVCenter
    Layout.leftMargin: 15
    Layout.rightMargin: 15

    background: Rectangle {
        radius: button.buttonRadius
        anchors.fill: parent

        color: button.pressed
               ? Theme.colorPalette.button.pressed
               : button.hovered
                 ? Theme.colorPalette.button.hover
                 : Theme.colorPalette.button.normal
    }

    Row {
        anchors.centerIn: parent
        spacing: 10

        Item {
            id: container
            height: 20
            width: 20
        }

        Text {
            text: button.labelText
            color: Theme.colorPalette.text
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            font.weight: Font.Medium
            font.family: Theme.fonts.main
        }
    }
}
