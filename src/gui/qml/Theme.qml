pragma ComponentBehavior: Bound

pragma Singleton
import QtQuick

Item {
    id: root
    property bool isDarkMode: configSettings.getSetting(ConfigSettings.DarkMode)

    readonly property Fonts fonts: Fonts {}
    readonly property ColorPalette colorPalette: ColorPalette {}
    readonly property Images images: Images {}

    component Fonts: QtObject {
        id: fonts

        property string comingSoon: "qrc:/resources/fonts/SpaceGrotesk-Regular.ttf"
        property string main: "qrc:/resources/fonts/Nunito-Regular.ttf"
        property string roboto: "qrc:/resources/fonts/Roboto-Regular.ttf"
    }

    component ColorPalette: QtObject {
        id: colorPalette

        readonly property LightColors lightColors: LightColors {}
        readonly property DarkColors darkColors: DarkColors {}

        readonly property var _activeSource: root.isDarkMode ? darkColors : lightColors

        readonly property color background: _activeSource.background
        readonly property color panel: _activeSource.panel
        readonly property color topbar: _activeSource.topbar
        readonly property color text: _activeSource.text
        readonly property LightSwitch lightSwitch: _activeSource.lightSwitch
        readonly property Button button: _activeSource.button
        readonly property SettingsButton settingsButton: _activeSource.settingsButton
        readonly property Popup popup: _activeSource.popup
        readonly property Menu menu: _activeSource.menu
        readonly property SpinBox spinBox: _activeSource.spinBox
    }

    component Images: QtObject {
        id: images

        readonly property LightImages lightImages: LightImages {}
        readonly property DarkImages darkImages: DarkImages {}

        readonly property var _activeSource: root.isDarkMode ? darkImages : lightImages

        readonly property string bug: _activeSource.bug
        readonly property string close: _activeSource.close
        readonly property string expand: _activeSource.expand
        readonly property string folder: _activeSource.folder
        readonly property string gear: _activeSource.gear
        readonly property string home: _activeSource.home
        readonly property string minus: _activeSource.minus
        readonly property string moon: _activeSource.moon
        readonly property string more: _activeSource.more
        readonly property string settings: _activeSource.settings
        readonly property string sun: _activeSource.sun
        readonly property string logo: "qrc:/resources/images/logo.ico"
    }

    component LightImages: QtObject {
        id: lightImages

        readonly property string bug: "qrc:/resources/images/bugBlack.png"
        readonly property string close: "qrc:/resources/images/closeBlack.png"
        readonly property string expand: "qrc:/resources/images/expandBlack.png"
        readonly property string folder: "qrc:/resources/images/folderBlack.png"
        readonly property string gear: "qrc:/resources/images/gearBlack.png"
        readonly property string home: "qrc:/resources/images/homeBlack.png"
        readonly property string minus: "qrc:/resources/images/minusBlack.png"
        readonly property string moon: "qrc:/resources/images/moonBlack.png"
        readonly property string more: "qrc:/resources/images/moreBlack.png"
        readonly property string settings: "qrc:/resources/images/settingsBlack.png"
        readonly property string sun: "qrc:/resources/images/sunBlack.png"
    }

    component DarkImages: QtObject {
        id: darkImages

        readonly property string bug: "qrc:/resources/images/bugWhite.png"
        readonly property string close: "qrc:/resources/images/closeWhite.png"
        readonly property string expand: "qrc:/resources/images/expandWhite.png"
        readonly property string folder: "qrc:/resources/images/folderWhite.png"
        readonly property string gear: "qrc:/resources/images/gearWhite.png"
        readonly property string home: "qrc:/resources/images/homeWhite.png"
        readonly property string minus: "qrc:/resources/images/minusWhite.png"
        readonly property string moon: "qrc:/resources/images/moonWhite.png"
        readonly property string more: "qrc:/resources/images/moreWhite.png"
        readonly property string settings: "qrc:/resources/images/settingsWhite.png"
        readonly property string sun: "qrc:/resources/images/sunWhite.png"
    }

    component LightSwitch: QtObject {
        property color back
        property color front
    }

    component Button: QtObject {
        property color normal
        property color hover
        property color pressed
        property color border
    }

    component SettingsButton: QtObject {
        property color normal
        property color hover
        property color pressed
        property color border
    }

    component Popup: QtObject {
        property color background: "#FFFFFF"
        property color border: "#CCCCCC"
    }

    component Menu: QtObject {
        property color background
        property color hover
        property color pressed
    }

    component SpinBox: QtObject {
        property color background
        property color textSelected
        property color textSelection
        property color buttonNormal
        property color buttonHovered
        property color buttonEnabled
        property color buttonDisabled
        property color border
    }

    component LightColors: QtObject {
        id: lightColors

        readonly property color background: "#F0F0F0"
        readonly property color panel: "#FBFBFB"
        readonly property color topbar: "#E0E0E0"
        readonly property color text: "#1F1F1F"

        readonly property LightSwitch lightSwitch: LightSwitch {
            back: "#CFD2DB"
            front: "#E8E8ED"
        }

        readonly property Button button: Button {
            normal: "#E0E0E0"
            hover: "#CCCCCC"
            pressed: "#AAAAAA"
            border: "#DDDDDD"
        }

        readonly property SettingsButton settingsButton: SettingsButton {
            normal: "#F5F5F5"
            hover: "#E0E0E0"
            pressed: "#D5D5D5"
            border: "#DDDDDD"
        }

        readonly property Popup popup: Popup {
            background: "#FFFFFF"
            border: "#CCCCCC"
        }

        readonly property Menu menu: Menu {
            background: "#FFFFFF"
            hover: "#F5F5F5"
            pressed: "#F9F9F9"
        }

        readonly property SpinBox spinBox: SpinBox {
            background: "#F5F5F5"
            textSelected: "#FFFFFF"
            textSelection: "#3498DB"
            buttonNormal: "#F5F5F5"
            buttonHovered: "#E6E6E6"
            buttonEnabled: "#1F1F1F"
            buttonDisabled: "#CCCCCC"
            border: "#bdc3c7"
        }
    }

    component DarkColors: QtObject {
        id: darkColors

        readonly property color background: "#272727"
        readonly property color panel:      "#323232"
        readonly property color topbar:     "#1F1F1F"
        readonly property color text:       "#E0E0E0"

        readonly property LightSwitch lightSwitch: LightSwitch {
            back: "#2B2C35"
            front: "#767B8D"
        }

        readonly property Button button: Button {
            normal:  "#1F1F1F"
            hover:   "#444444"
            pressed: "#222222"
            border:  "#555555"
        }

        readonly property SettingsButton settingsButton: SettingsButton {
            normal:  "#2A2A2A"
            hover:   "#3A3A3A"
            pressed: "#1A1A1A"
            border:  "#555555"
        }

        readonly property Popup popup: Popup {
            background: "#1E1E1E"
            border:     "#444444"
        }

        readonly property Menu menu: Menu {
            background: "#121212"
            hover: "#0A0A0A"
            pressed: "#090909"
        }

        readonly property SpinBox spinBox: SpinBox {
            background: "#1F1F1F"
            textSelected: "#1F1F1F"
            textSelection: "#CC6734"
            buttonNormal: "#1F1F1F"
            buttonHovered: "#333333"
            buttonEnabled: "#909090"
            buttonDisabled: "#555555"
            border: "#555555"
        }
    }
}