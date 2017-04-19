import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: item1

    Rectangle{
        anchors.fill: parent
        color: '#FFFFFF'
    }

    ToolBar {
        id: toolBar1
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Row{
            width: parent.width
            layoutDirection: Qt.RightToLeft
            ToolButton {
                id: toolButton2
                y: 0
                width: 90
                height: 40
                text: qsTr("Annuler")
                onClicked: {
                    page1_fieldedit.visible = false
                }
            }

            ToolButton {
                id: toolButton1
                y: 0
                width: 90
                height: 40
                text: qsTr("Valider")
                onClicked: {
                    survey_edit.add_field()
                    edit_field.visible = false
                }
            }
        }
    }

    TextEdit {
        id: textEdit1
        height: 193
        text: qsTr("Text Edit")
        anchors.top: toolBar1.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: 12
    }

}
