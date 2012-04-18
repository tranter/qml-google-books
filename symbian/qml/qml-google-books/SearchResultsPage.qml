import QtQuick 1.0
import "books_data_manager.js" as BooksDataManager
//import com.nokia.meego 1.0
import com.nokia.symbian 1.0

Page {
    //x: 0
    //y: 0
    //width: 360
    //height: 640
    //color: "black"
    property string title: "Search Results"

    //Header!!!
    BorderImage {
        id: top_tool_bar
        anchors { left:  parent.left; right: parent.right; top: parent.top }
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



    ListView {
        anchors { left:  parent.left; right: parent.right; bottom: bottom_tool_bar1.top; top: top_tool_bar.bottom }
        model: searchResultsModel
        delegate: SearchResultsDelegate {}
        clip: true
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
    }

}
