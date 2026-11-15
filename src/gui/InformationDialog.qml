import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Dialog {
    id: messageDialog
    title: "Information"
    property string text: "I am very usefull information. I'm the most important information that you'll ever find!"

    modal: true
    standardButtons: Dialog.NoButton
    anchors.centerIn: parent

    width: 300
    height: 250

    header: Rectangle {
        color: Theme.colorPalette.topbar
        implicitHeight: 40
        topRightRadius: 8
        topLeftRadius: 8

        Text {
            text: messageDialog.title
            color: Theme.colorPalette.text
            font.bold: true
            font.pointSize: 15
            anchors.centerIn: parent
        }
    }

    contentItem: ColumnLayout{
        spacing: 10

        Label {
            text: messageDialog.text
            font.pointSize: 11.5
            color: Theme.colorPalette.text
            wrapMode: Label.WordWrap

            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        SettingsButton {
            id: ok
            labelText: "Ok"
            Layout.preferredWidth: 65
            Layout.preferredHeight: 30

            Layout.alignment: Qt.AlignRight

            onClicked: messageDialog.close()
        }
    }

    background: Rectangle {
        color: Theme.colorPalette.background
        radius: 8
    }
}