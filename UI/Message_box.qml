import QtQuick 2.0
import QtQuick.Controls 2.0
import "../WIDGETS/"

Item {

    property Item wg_current_frame
    property string wg_message_text

    Rectangle{
        x: 0
        y: 0
        anchors.fill: parent
        color: "#AAFF0000"

        Text{
            anchors.fill: parent
            font.pointSize: 24
            text: wg_message_text
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                wg_current_frame.visible = false
                message_box.visible = false
            }
        }
    }
}

