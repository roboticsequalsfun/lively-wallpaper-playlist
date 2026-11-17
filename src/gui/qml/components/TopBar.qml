import QtQuick
import QtQuick.Layouts

Rectangle {
    id: topBar
    color: Theme.colorPalette.topbar

    property alias minButton: minButton
    property alias expandButton: expandButton
    property alias closeButton: closeButton

    RowLayout {
        id: buttons
        anchors.fill: parent

        Image {
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            source: Theme.images.logo
            width: 14; height: 14;
        }

        Text {
            text: window.title
            color: Theme.colorPalette.text
            font.family: Theme.fonts.roboto
            font.bold: true
        }

        Item {
            Layout.fillWidth: true
        }

        TopbarButton {
            id: minButton
            buttonRadius: 0
            labelText: ""
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.maximumWidth: 36
            Layout.maximumHeight: 36

            Image {
                source: Theme.images.minus
                width: 14; height: 14
                anchors.centerIn: parent
            }

            onClicked: window.showMinimized()
        }

        TopbarButton {
            id: expandButton
            buttonRadius: 0
            labelText: ""
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.maximumWidth: 36
            Layout.maximumHeight: 36

            Image {
                source: Theme.images.expand
                width: 14; height: 14
                anchors.centerIn: parent
            }

            onClicked: {
                if (window.visibility === Window.Maximized) {
                    window.showNormal()
                } else {
                    window.showMaximized()
                }
            }
        }

        TopbarButton {
            id: closeButton
            labelText: ""
            buttonRadius: 0
            Layout.preferredWidth: 36
            Layout.preferredHeight: 36
            Layout.maximumWidth: 36
            Layout.maximumHeight: 36

            Image {
                source: Theme.images.close
                width: 14; height: 14
                anchors.centerIn: parent
            }

            onClicked: window.close()
        }
    }
}