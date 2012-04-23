import QtQuick 1.0
import "books_data_manager.js" as BooksDataManager
import com.nokia.meego 1.0
//import com.nokia.symbian 1.0

Page {
    //x: 0
    //y: 0
    //width: 360
    //height: 640
    //color: "black"
    //property string title: pageStack.bookshelves[pageStack.shelf_index]["title"]
    property string shelf_id: ""

    //Header!!!
    BorderImage {
        id: top_tool_bar
        anchors { left:  parent.left; right: parent.right; top: parent.top }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        height: 60
        source: "images/toolbar-top.png"
        Text {
            id: titleText
            text: pageStack.bookshelves[pageStack.shelf_index]["title"]
            anchors.centerIn:  parent
            color: "white"
            font.pixelSize: 28
            font.bold: true;
            wrapMode: Text.WordWrap
        }
    }



    ListView {
        anchors { left:  parent.left; right: parent.right; bottom: bottom_tool_bar1.top; top: top_tool_bar.bottom }
        model: volumesModel
        delegate: VolumeDelegate {}
        clip: true
    }

    QueryDialog {
        id: queryDialog
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        titleText: "Clear"

        onAccepted:  {
            console.log("Clear accepted");
            BooksDataManager.clearVolumesFromBookshelf(root.bookshelves[root.shelf_index]["id"]);
        }
    }


    //Footer!!!
    BorderImage {
        id: bottom_tool_bar1
        anchors { left:  parent.left; right: parent.right; bottom: parent.bottom }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        source: "images/toolbar-bottom.png"
        height: 60

        Button {
            text: "Back";
            width: 120; height: 40
            anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                pageStack.pop();
            }
        }

        Button {
            text: "Clear";
            width: 120; height: 40
            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
            onClicked: {
                console.log("Clear button clicked");
                queryDialog.message = "Do you want to remove all the books from the bookshelf '" + root.bookshelves[root.shelf_index]["title"] + "'?"
                queryDialog.open();
            }
        }


        Button {
            text: "Find";
            width: 120; height: 40
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                //findPage.prevState = root.state;
                //root.state = "find";
                pageStack.push(Qt.resolvedUrl("FindPage.qml"))
            }
        }

    }

//    Component.onCompleted: {
//        titleText.text = pageStack.bookshelves[pageStack.shelf_index]["title"];
//    }

}
