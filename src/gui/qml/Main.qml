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
    maximumHeight: 635
    maximumWidth: 890
    minimumHeight: 635
    minimumWidth: 890
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

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 2

            color: Theme.colorPalette.dashboard.divider
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            Dashboard {
                id: dashboard
                loader: pages

                Layout.fillHeight: true
                Layout.preferredWidth: 180
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 2

                color: Theme.colorPalette.dashboard.divider
            }

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
    }
}
