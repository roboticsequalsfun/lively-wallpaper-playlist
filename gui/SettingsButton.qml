import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    property string labelText: "Button"
    id: button
    width: 65
    height: 30

    background: Rectangle {
        radius: 8
        anchors.fill: parent

        color: button.pressed
               ? Theme.colorPalette.settingsButton.pressed
               : button.hovered
                 ? Theme.colorPalette.settingsButton.hover
                 : Theme.colorPalette.settingsButton.normal

        border.width: 1.5
        border.color: Theme.colorPalette.settingsButton.border
    }

    Text {
        text: labelText
        color: Theme.colorPalette.text
        anchors.centerIn: parent
        font.pixelSize: 15
        font.family: Theme.fonts.main
    }
}
