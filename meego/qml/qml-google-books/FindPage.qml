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
    property string title: "Find"
    property string prevState: ""

    //Header!!!
    BorderImage {
        id: top_tool_bar
        anchors { left:  parent.left; right: parent.right; top: parent.top }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        height: 60
        source: "images/toolbar-top.png"
        Text {
            text: title
            anchors.centerIn:  parent
            color: "white"
            font.pixelSize: 28
            font.bold: true;
            wrapMode: Text.WordWrap
        }
    }

    Text {
        id: titleText
        text: "Title"
        anchors{ left: parent.left; top: top_tool_bar.bottom }
        color: "white"
        font.pixelSize: 25
        font.bold: true;
        wrapMode: Text.WordWrap
    }

    TextField {
        id: titleTextEdit
        anchors{ left: parent.left; top: titleText.bottom; right: parent.right }
        height: 50
    }

    Text {
        id: authorText
        text: "Author"
        anchors{ left: parent.left; top: titleTextEdit.bottom; topMargin: 30 }
        color: "white"
        font.pixelSize: 25
        font.bold: true;
        wrapMode: Text.WordWrap
    }
    TextField {
        id: authorTextEdit
        anchors{ left: parent.left; top: authorText.bottom; right: parent.right }
        height: 50
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
                //root.state = prevState;
                pageStack.pop();
            }
        }


        Button {
            text: "Find";
            width: 120; height: 40
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                //root.state = "bookshelves"
                console.log("Find button clicked");
                BooksDataManager.findBooks(titleTextEdit.text, authorTextEdit.text);
                //root.state = "search_results"
                pageStack.push(Qt.resolvedUrl("SearchResultsPage.qml"))
            }
        }

    }

}
