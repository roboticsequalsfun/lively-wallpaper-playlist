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

    property bool isDarkMode: false

    readonly property QtObject colorPalette: colorPalette
    QtObject {
        id: colorPalette

        // Expose active colors directly so controls update automatically on toggle
        readonly property color background: isDarkMode ? darkPalette.background : lightPalette.background
        readonly property color panel: isDarkMode ? darkPalette.panel : lightPalette.panel
        readonly property color topbar: isDarkMode ? darkPalette.topbar : lightPalette.topbar
        readonly property color text: isDarkMode ? darkPalette.text : lightPalette.text
        readonly property QtObject lightSwitch: isDarkMode ? darkPalette.lightSwitch : lightPalette.lightSwitch
        readonly property QtObject button: isDarkMode ? darkPalette.button : lightPalette.button
        readonly property QtObject settingsButton: isDarkMode ? darkPalette.settingsButton : lightPalette.settingsButton
        readonly property QtObject popup: isDarkMode ? darkPalette.popup : lightPalette.popup
        readonly property QtObject menu: isDarkMode ? darkPalette.menu : lightPalette.menu
        readonly property QtObject spinBox: isDarkMode ? darkPalette.spinBox : lightPalette.spinBox
    }

    readonly property QtObject images: images
    QtObject {
        id: images

        readonly property string bug: isDarkMode ? darkImages.bug : lightImages.bug
        readonly property string close: isDarkMode ? darkImages.close : lightImages.close
        readonly property string expand: isDarkMode ? darkImages.expand : lightImages.expand
        readonly property string folder: isDarkMode ? darkImages.folder : lightImages.folder
        readonly property string gear: isDarkMode ? darkImages.gear : lightImages.gear
        readonly property string home: isDarkMode ? darkImages.home : lightImages.home
        readonly property string minus: isDarkMode ? darkImages.minus : lightImages.minus
        readonly property string moon: isDarkMode ? darkImages.moon : lightImages.moon
        readonly property string more: isDarkMode ? darkImages.more : lightImages.more
        readonly property string settings: isDarkMode ? darkImages.settings : lightImages.settings
        readonly property string sun: isDarkMode ? darkImages.sun : lightImages.sun
        readonly property string logo: "images/logo.ico"
    }

    QtObject {
        id: lightImages

        readonly property string bug: "images/bugBlack.png"
        readonly property string close: "images/closeBlack.png"
        readonly property string expand: "images/expandBlack.png"
        readonly property string folder: "images/folderBlack.png"
        readonly property string gear: "images/gearBlack.png"
        readonly property string home: "images/homeBlack.png"
        readonly property string minus: "images/minusBlack.png"
        readonly property string moon: "images/moonBlack.png"
        readonly property string more: "images/moreBlack.png"
        readonly property string settings: "images/settingsBlack.png"
        readonly property string sun: "images/sunBlack.png"
    }

    QtObject {
        id: darkImages

        readonly property string bug: "images/bugWhite.png"
        readonly property string close: "images/closeWhite.png"
        readonly property string expand: "images/expandWhite.png"
        readonly property string folder: "images/folderWhite.png"
        readonly property string gear: "images/gearWhite.png"
        readonly property string home: "images/homeWhite.png"
        readonly property string minus: "images/minusWhite.png"
        readonly property string moon: "images/moonWhite.png"
        readonly property string more: "images/moreWhite.png"
        readonly property string settings: "images/settingsWhite.png"
        readonly property string sun: "images/sunWhite.png"
    }

    QtObject {
        id: lightPalette

        readonly property color background: "#F0F0F0"
        readonly property color panel: "#FBFBFB"
        readonly property color topbar: "#E0E0E0"
        readonly property color text: "#1F1F1F"

        readonly property QtObject lightSwitch: QtObject {
            readonly property color back: "#CFD2DB"
            readonly property color front: "#E8E8ED"
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
            readonly property color background: "#FFFFFF"
            readonly property color border: "#CCCCCC"
        }

        readonly property QtObject menu: QtObject {
            readonly property color background: "#FFFFFF"
            readonly property color hover: "#F5F5F5"
            readonly property color pressed: "#F9F9F9"
        }

        readonly property QtObject spinBox: QtObject {
            readonly property color background: "#F5F5F5"
            readonly property color textSelected: "#FFFFFF"
            readonly property color textSelection: "#3498DB"
            readonly property color buttonNormal: "#F5F5F5"
            readonly property color buttonHovered: "#E6E6E6"
            readonly property color buttonEnabled: "#1F1F1F"
            readonly property color buttonDisabled: "#CCCCCC"
            readonly property color border: "#bdc3c7"
        }
    }

    QtObject {
        id: darkPalette

        readonly property color background: "#272727"
        readonly property color panel:      "#323232"
        readonly property color topbar:     "#1F1F1F"
        readonly property color text:       "#E0E0E0"

        readonly property QtObject lightSwitch: QtObject {
            readonly property color back: "#2B2C35"
            readonly property color front: "#767B8D"
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

        readonly property QtObject menu: QtObject {
            readonly property color background: "#121212"
            readonly property color hover: "#0A0A0A"
            readonly property color pressed: "#090909"
        }

        readonly property QtObject spinBox: QtObject {
            readonly property color background: "#1F1F1F"
            readonly property color textSelected: "#1F1F1F"
            readonly property color textSelection: "#CC6734"
            readonly property color buttonNormal: "#1F1F1F"
            readonly property color buttonHovered: "#333333"
            readonly property color buttonEnabled: "#909090"
            readonly property color buttonDisabled: "#555555"
            readonly property color border: "#555555"
        }
    }
}