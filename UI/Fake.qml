import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.3

Item {
    ToolBar {
        id: toolBar
        x: 0
        y: 0
        width: 640
        height: 40

        ToolButton {
            id: toolButton
            x: 560
            y: 0
            text: qsTr("Tool Button")
            anchors.right: parent.right
            anchors.rightMargin: 0
        }

        Image {
            id: image
            x: 0
            y: 0
            width: 35
            height: 40
            source: "qrc:/qtquickplugin/images/template_image.png"
        }

        Text {
            id: text1
            x: 49
            y: 13
            width: 311
            height: 14
            text: qsTr("Text")
            font.pixelSize: 12
        }
    }



}
