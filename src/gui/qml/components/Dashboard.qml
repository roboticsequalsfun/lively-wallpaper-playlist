import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../pages"

Rectangle {
    property Loader loader
    color: Theme.colorPalette.topbar

    // ColumnLayout {
    //     id: topBar
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom

    //     TopbarButton {
    //         labelText: "Home"
    //         buttonRadius: 8

    //         Image {
    //             source: Theme.images.home
    //             width: 25
    //             height: 25
    //         }

    //         onClicked: {
    //             loader.source = "pages/HomePage.qml"
    //         }
    //     }

    //     TopbarButton {
    //         labelText: "Grouping"
    //         buttonRadius: 8
    //         Layout.preferredWidth: 110
    //         Layout.maximumWidth: 110

    //         Image {
    //             source: Theme.images.folder
    //             width: 25
    //             height: 25
    //         }

    //         onClicked: {
    //             loader.source = "pages/GroupingPage.qml"
    //         }
    //     }

    //     TopbarButton {
    //         labelText: "Rules"
    //         buttonRadius: 8

    //         Image {
    //             source: Theme.images.settings
    //             width: 25
    //             height: 25
    //         }

    //         onClicked: {
    //             loader.source = "pages/RulesPage.qml"
    //         }
    //     }

    //     Item {
    //         Layout.fillWidth: true
    //         Layout.minimumWidth: 80
    //     }

    //     TopbarButton {
    //         labelText: ""
    //         buttonRadius: 8
    //         Layout.preferredWidth: 40
    //         Layout.maximumWidth: 40

    //         Image {
    //             source: Theme.images.bug
    //             width: 28
    //             height: 28
    //             anchors.centerIn: parent
    //         }

    //         onClicked: {
    //             var component = Qt.createComponent("BugReport.qml");
    //             if (component.status === Component.Ready) {
    //                 // Setting mainWindow as the parent manages memory lifecycle
    //                 var win = component.createObject(Window);
    //                 win.show();
    //             } else {
    //                 console.error("Error loading component:", component.errorString());
    //             }
    //         }
    //     }

    //     TopbarButton {
    //         labelText: ""
    //         buttonRadius: 8
    //         Layout.preferredWidth: 40
    //         Layout.maximumWidth: 40

    //         Image {
    //             source: Theme.images.gear
    //             width: 25
    //             height: 25
    //             anchors.centerIn: parent
    //         }

    //         onClicked: {
    //             loader.source = "pages/SettingsPage.qml"
    //         }
    //     }

    //     TopbarButton {
    //         id: moreButton
    //         labelText: ""
    //         buttonRadius: 8
    //         Layout.preferredWidth: 25
    //         Layout.maximumWidth: 25

    //         Image {
    //             source: Theme.images.more
    //             width: 25
    //             height: 25
    //             anchors.centerIn: parent
    //         }

    //         onClicked: menu.popup(moreButton.x, moreButton.y + moreButton.height)
    //     }

    //     Menu {
    //         id: menu
    //         width: 125

    //         background: Rectangle {
    //             color: Theme.colorPalette.menu.background
    //             anchors.fill: parent
    //             radius: 4
    //         }

    //         MenuItem {
    //             id: menuItem
    //             text: "Help"
    //             height: 30

    //             contentItem: Text {
    //                 text: parent.text
    //                 font.pointSize: 10
    //                 font.family: Theme.fonts.main
    //                 color: Theme.colorPalette.text
    //                 horizontalAlignment: Text.AlignLeft
    //                 verticalAlignment: Text.AlignVCenter
    //             }

    //             background: Rectangle {
    //                 anchors.fill: parent
    //                 color: parent.down ? Theme.colorPalette.menu.pressed : (parent.hovered ? Theme.colorPalette.menu.hover : Theme.colorPalette.menu.background)
    //                 radius: 4
    //             }

    //             onClicked: {
    //                 Qt.openUrlExternally("https://github.com/roboticsequalsfun/lively-wallpaper-playlist/blob/main/README.md")
    //             }
    //         }

    //         MenuItem {
    //             text: "About"
    //             height: 30

    //             contentItem: Text {
    //                 text: parent.text
    //                 font.pointSize: 10
    //                 font.family: Theme.fonts.main
    //                 color: Theme.colorPalette.text
    //                 horizontalAlignment: Text.AlignLeft
    //                 verticalAlignment: Text.AlignVCenter
    //             }

    //             background: Rectangle {
    //                 anchors.fill: parent
    //                 color: parent.down ? Theme.colorPalette.menu.pressed : (parent.hovered ? Theme.colorPalette.menu.hover : Theme.colorPalette.menu.background)
    //                 radius: 4
    //             }

    //             onClicked: {
    //                 Qt.openUrlExternally("https://github.com/roboticsequalsfun")
    //             }
    //         }
    //     }
    // }
}