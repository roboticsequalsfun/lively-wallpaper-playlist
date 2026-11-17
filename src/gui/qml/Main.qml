import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QWindowKit
import "components"
import "pages"

ApplicationWindow {
    id: window
    width: 890
    height: 635
    minimumWidth: 550
    minimumHeight: 410
    visible: true
    title: qsTr("Lively Playlist")

    WindowAgent {
        id: windowAgent
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        TopBar {
            id: topBar

            Layout.fillWidth: true
            Layout.minimumHeight: 36
            Layout.maximumHeight: 36
            Layout.alignment: Qt.AlignTop
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            // Dashboard {
            //     id: dashboard
            //     loader: pages

            //     Layout.fillHeight: true
            //     Layout.minimumWidth: 60
            //     Layout.maximumWidth: 60
            // }

            Rectangle {
                Layout.fillHeight: true
                Layout.minimumWidth: 125
                Layout.maximumWidth: 175
                Layout.preferredWidth: Math.round(Math.max(125, Math.min(175, 125 + ((window.width - 550) / 340) * 50)))

                color: "blue"
            }

            // Rectangle {
            //     Layout.fillHeight: true
            //     Layout.fillWidth: true

            //     color: "green"
            // }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true

                Rectangle {
                    anchors.fill: parent
                    color: Theme.colorPalette.background
                }

                Loader {
                    id: pages
                    anchors.fill: parent
                    source: "pages/HomePage.qml"
                }
            }
        }
    }

    Component.onCompleted: {
        windowAgent.setup(window)
        windowAgent.setTitleBar(topBar)

        // Ensure interactive items inside the title bar can still receive clicks
        windowAgent.setHitTestVisible(topBar.minButton, true)
        windowAgent.setHitTestVisible(topBar.closeButton, true)
        windowAgent.setHitTestVisible(topBar.expandButton, true)
    }
}
