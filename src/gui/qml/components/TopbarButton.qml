pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: button
    default property alias contentData: container.data
    Layout.preferredWidth: 36
    Layout.preferredHeight: 36
    Layout.maximumWidth: 36
    Layout.maximumHeight: 36
    Layout.alignment: Qt.AlignVCenter

    background: Rectangle {
        radius: 0
        anchors.fill: parent

        color: button.pressed
               ? Theme.colorPalette.button.pressed
               : button.hovered
                 ? Theme.colorPalette.button.hover
                 : Theme.colorPalette.button.normal
    }

    Item {
        id: container
        anchors.centerIn: parent
        height: 25
        width: 25
    }
}
