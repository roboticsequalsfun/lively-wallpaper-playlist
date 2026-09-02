pragma Singleton
import QtQuick

Item {
    id: root

    readonly property QtObject fonts: internalFonts

    QtObject {
        id: internalFonts

        property string comingSoon: "Space Grotesk"
        property string main: "Nunito"
        property string roboto: "Roboto"
    }

    // Property to toggle active mode: true = Dark, false = Light
    property bool isDarkMode: false

    // Expose active colors directly so controls update automatically on toggle
    readonly property color background: isDarkMode ? darkPalette.background : lightPalette.background
    readonly property color panel: isDarkMode ? darkPalette.panel : lightPalette.panel
    readonly property color topbar: isDarkMode ? darkPalette.topbar : lightPalette.topbar
    readonly property color text: isDarkMode ? darkPalette.text : lightPalette.text
    readonly property QtObject lightSwitch: isDarkMode ? darkPalette.lightSwitch : lightPalette.lightSwitch
    readonly property QtObject button: isDarkMode ? darkPalette.button : lightPalette.button
    readonly property QtObject settingsButton: isDarkMode ? darkPalette.settingsButton : lightPalette.settingsButton
    readonly property QtObject popup: isDarkMode ? darkPalette.popup : lightPalette.popup

    QtObject {
        id: lightPalette

        readonly property color background: "#F0F0F0"
        readonly property color panel: "#FBFBFB"
        readonly property color topbar: "#E0E0E0"
        readonly property color text: "#2C2C2C"

        readonly property QtObject lightSwitch: QtObject {
            readonly property color back: "#E0E0E0"
            readonly property color front: "#E1E9F2"
        }

        readonly property QtObject button: QtObject {
            readonly property color normal: "#E0E0E0"
            readonly property color hover: "#CCCCCC"
            readonly property color pressed: "#AAAAAA"
            readonly property color border: "#DDDDDD"
        }

        readonly property QtObject settingsButton: QtObject {
            readonly property color normal: "#F5F5F5"
            readonly property color hover: "#E0E0E0"
            readonly property color pressed: "#D5D5D5"
            readonly property color border: "#DDDDDD"
        }

        readonly property QtObject popup: QtObject {
            property color background: "#FFFFFF"
            property color border: "#CCCCCC"
        }
    }

    QtObject {
        id: darkPalette

        readonly property color background: "#272727"
        readonly property color panel:      "#323232"
        readonly property color topbar:     "#1F1F1F"
        readonly property color text:       "#E0E0E0"

        readonly property QtObject lightSwitch: QtObject {
            readonly property color back: "#333333"
            readonly property color front: "#2D3655"
        }

        readonly property QtObject button: QtObject {
            readonly property color normal:  "#1F1F1F"
            readonly property color hover:   "#444444"
            readonly property color pressed: "#222222"
            readonly property color border:  "#555555"
        }

        readonly property QtObject settingsButton: QtObject {
            readonly property color normal:  "#2A2A2A"
            readonly property color hover:   "#3A3A3A"
            readonly property color pressed: "#1A1A1A"
            readonly property color border:  "#555555"
        }

        readonly property QtObject popup: QtObject {
            readonly property color background: "#1E1E1E"
            readonly property color border:     "#444444"
        }
    }
}