import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.3

Item {
    SwipeView {
        id: swipeView
        x: 31
        y: 29
        width: 559
        height: 384
        enabled: true
        interactive: false
        currentIndex: tabBar1.currentIndex

        Item {
        }

        Item {
        }
    }

    TabBar {
        id: tabBar1
        x: 309
        y: 432
        anchors.bottom: swipeView.top
        anchors.left: swipeView.left
        anchors.right: swipeView.right
        TabButton {
            text: "Tab 0"
        }

        TabButton {
            text: "Tab 1"
        }
    }

}
