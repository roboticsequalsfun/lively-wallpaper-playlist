import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property string labelText : "Button"

    Layout.fillWidth: true
    height: 65

    default property alias contentData: panel.data

    Rectangle {
        anchors.centerIn: parent
        anchors.fill: parent
        color: Theme.background
    }

    Item {
        id: panel
        height: 65
        anchors.fill: parent

        Rectangle {
            anchors.centerIn: parent
            height: 60
            width: parent.width - 10
            color: Theme.panel
            radius: 5
        }

        Label {
            id: label
            text: labelText
            color: Theme.text
            font.pixelSize: 15
            font.family: Theme.fonts.roboto

            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 10
            }
        }
    }
}