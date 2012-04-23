import QtQuick 1.0
import com.nokia.meego 1.0
//import com.nokia.symbian 1.0


Page {
    //width: 360
    //height: 360
    //color: "black"

    //Header!!!
    BorderImage {
        id: top_tool_bar
        anchors { left:  parent.left; right: parent.right; top: parent.top }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        height: 60
        source: "images/toolbar-top.png"
        Text {
            text: "Bookshelves"
            anchors.centerIn:  parent
            color: "white"
            font.pixelSize: 28
            font.bold: true;
            wrapMode: Text.WordWrap
        }
    }



    ListView {
        anchors { left:  parent.left; right: parent.right; bottom: bottom_tool_bar.top; top: top_tool_bar.bottom }
        model: bookshelvesModel
        delegate: BookshelfDelegate {}
        clip: true
    }

    //Footer!!!
    BorderImage {
        id: bottom_tool_bar
        anchors { left:  parent.left; right: parent.right; bottom: parent.bottom }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        source: "images/toolbar-bottom.png"
        height: 60

        Button {
            text: "Quit";
            width: 120; height: 40
            anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                Qt.quit();
            }
        }

        Button {
            text: "Login";
            width: 120; height: 40
            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
            onClicked: {
                google_oauth.visible = true;
                google_oauth.login();
            }
        }


        Button {
            text: "Find";
            width: 120; height: 40
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                console.log("Find button clicked");
                //findPage.prevState = root.state;
                //root.state = "find";
                pageStack.push(Qt.resolvedUrl("FindPage.qml"))
            }
        }

    }

}
