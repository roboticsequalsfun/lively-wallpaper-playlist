import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    width: 65
    height: 35

    Rectangle {
        anchors.centerIn: parent
        width: 60
        height: 30
        radius: 15
        color: Theme.colorPalette.lightSwitch.back
    }

    Rectangle {
        id: circle
        y: 3

        width: 30
        height: 30
        radius: 30
        color: Theme.colorPalette.lightSwitch.front
        clip: true
    }

    NumberAnimation {
        id: moveRight
        target: circle
        property: "x"
        from: 2.5
        to: 32.5
        duration: 200
        easing.type: Easing.InOutQuad
    }


    NumberAnimation {
        id: moveLeft
        target: circle
        property: "x"
        from: 32.5
        to: 2.5
        duration: 200
        easing.type: Easing.InOutQuad
    }

    MouseArea {
        width: 60
        height: 30
        hoverEnabled: false

        onClicked: {
            Theme.isDarkMode ? moveLeft.start() : moveRight.start()
            Theme.isDarkMode = !Theme.isDarkMode
        }
    }

    Component.onCompleted: {
        circle.x = Theme.isDarkMode ? 32.5 : 2.5
    }
}
