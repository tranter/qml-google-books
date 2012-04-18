import QtQuick 1.0
import QtWebKit 1.0
//import com.nokia.meego 1.0
import com.nokia.symbian 1.0

Page {
    //width: 360
    //height: 360
    //color: "black"
    property alias url: webView.url
    property QtObject pageStack;

    //Header!!!
    BorderImage {
        id: top_tool_bar
        anchors { left:  parent.left; right: parent.right; top: parent.top }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        height: 60
        source: "images/toolbar-top.png"
        Text {
            text: "Reading"
            anchors.centerIn:  parent
            color: "white"
            font.pixelSize: 28
            font.bold: true;
            wrapMode: Text.WordWrap
        }
        Button {
            text: "Back";
            width: 100; height: 40
            anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                pageStack.runBusyIndicator(false);
                pageStack.pop();
            }
        }
        Button {
            text: "Zoom";
            width: 100; height: 40
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                selectionDialog.open();
            }
        }
    }

    ListModel {
        id: zoomModel
        ListElement { name: 1.5 }
        ListElement { name: 1.6 }
        ListElement { name: 1.7 }
        ListElement { name: 1.8 }
        ListElement { name: 1.9 }
        ListElement { name: 2.0 }
        ListElement { name: 2.1 }

    }

    SelectionDialog {
        id: selectionDialog
        titleText: "Set Zoom"
        selectedIndex: -1

        model: zoomModel

        onSelectedIndexChanged: {
            console.log("Selected index = ", selectedIndex);
            if(selectedIndex != -1)
            {
                //var shelf_id = root.bookshelves[selectedIndex]["id"];
                //BooksDataManager.addVolumeToBookshelf(shelf_id, volume_id);
                webView.contentsScale = 1.5 + selectedIndex*0.1;
            }
        }

    }

    //function setUrl(url)
    //{
    //    webView.url = url;
    //}


    Flickable {
        id: web_view_window
        anchors { left:  parent.left; right: parent.right; bottom: parent.bottom; top: top_tool_bar.bottom }
        contentWidth: Math.max(width,webView.width)
        contentHeight: Math.max(height,webView.height)
        clip: true


        WebView {
            id: webView
            //preferredWidth: web_view_window.width
            //preferredHeight: web_view_window.height
            contentsScale: 1.6

            onLoadStarted: {
                pageStack.runBusyIndicator(true);
            }
            onLoadFinished: {
                pageStack.runBusyIndicator(false);
            }
        }
    }

//    //Footer!!!
//    BorderImage {
//        id: bottom_tool_bar
//        anchors { left:  parent.left; right: parent.right; bottom: parent.bottom }
//        //x: 0; y:0; width:360; height: mainWindow.tb_height
//        source: "images/toolbar-bottom.png"
//        height: 60

//    }

}
