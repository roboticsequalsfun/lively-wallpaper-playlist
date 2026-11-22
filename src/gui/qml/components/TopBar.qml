import QtQuick
import QtQuick.Layouts
import "../"

Rectangle {
    id: topBar
    color: Theme.colorPalette.dashboard.background

    property alias minButton: minButton
    property alias closeButton: closeButton

    RowLayout {
        id: buttons
        anchors.fill: parent
        spacing: 0

        Image {
            Layout.preferredWidth: 14;
            Layout.preferredHeight: 14;
            Layout.leftMargin: 10
            Layout.rightMargin: 10

            source: Theme.images.logo
        }

        Text {
            text: window.title
            color: Theme.colorPalette.text
            font.family: Theme.fonts.roboto
            font.bold: true
        }

        Item {
            Layout.preferredWidth: 59
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 2 / Screen.devicePixelRatio

            color: Theme.colorPalette.dashboard.divider
        }

        Item {
            Layout.fillWidth: true
        }

        TopbarButton {
            id: minButton

            Image {
                source: Theme.images.minus
                width: 14; height: 14
                anchors.centerIn: parent
            }

            onClicked: window.showMinimized()
        }

        // TopbarButton {
        //     id: expandButton
        //     buttonRadius: 0
        //     labelText: ""
        //     Layout.preferredWidth: 36
        //     Layout.preferredHeight: 36
        //     Layout.maximumWidth: 36
        //     Layout.maximumHeight: 36

        //     Image {
        //         source: Theme.images.expand
        //         width: 14; height: 14
        //         anchors.centerIn: parent
        //     }

        //     onClicked: {
        //         if (window.visibility === Window.Maximized) {
        //             window.showNormal()
        //         } else {
        //             window.showMaximized()
        //         }
        //     }
        // }

        TopbarButton {
            id: closeButton

            Image {
                source: Theme.images.close
                width: 14; height: 14
                anchors.centerIn: parent
            }

            onClicked: window.close()
        }
    }
}