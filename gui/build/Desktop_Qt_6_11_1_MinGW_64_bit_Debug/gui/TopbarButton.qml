import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: button
    property string labelText: "Button"
    property real buttonRadius: 8
    default property alias contentData: container.data
    Layout.preferredWidth: 90
    Layout.preferredHeight: 40
    Layout.maximumWidth: 90
    Layout.maximumHeight: 40
    Layout.alignment: Qt.AlignVCenter

    background: Rectangle {
        radius: buttonRadius
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
            height: 25
            width: 25
        }

        Text {
            text: labelText
            color: Theme.colorPalette.text
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
            font.family: Theme.fonts.main
        }
    }
}
