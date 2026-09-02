import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: button
    width: 80
    height: 36

    background: Rectangle {
        radius: 8

        color: mouseArea.pressed
               ? button.pressedColor
               : mouseArea.containsMouse
                 ? button.hoverColor
                 : button.normalColor

        border {
            color: borderColor
            width: borderWidth
        }
    }

    Row {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: button.text
            color: Theme.palette.text
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: fontSize
            font.family: font
        }
    }
}
