import QtQuick

Rectangle {
    id: button

    property string text: "Button"
    property int padding: 0
    property color normalColor: Theme.button.normal
    property color hoverColor: Theme.button.hover
    property color pressedColor: Theme.button.pressed
    property bool borderOn: false
    property string borderColor: Theme.button.border

    signal clicked()

    width: 80
    height: 36
    radius: 8
    anchors.margins: padding

    color: mouseArea.pressed
           ? button.pressedColor
           : mouseArea.containsMouse
             ? button.hoverColor
             : button.normalColor


    border {
        color: borderColor
        width: borderOn ? 1.5 : 0
    }

    Text {
        anchors.centerIn: parent
        text: button.text
        color: Theme.text
        font.family: Theme.fonts.main
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onClicked: button.clicked()
    }
}
