import QtQuick
import QtQuick.Controls

SpinBox {
    id: spinBox
    anchors.centerIn: parent
    from: 1
    to: 1000
    editable: true
    width: 50
    height: 30

    validator: IntValidator {
        bottom: spinBox.from
        top: spinBox.to
    }

    background: Rectangle {
        border.color: "#1E272E"
        border.width: 5
        radius: 25
    }
}
