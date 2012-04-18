import QtQuick 1.0
import QtWebKit 1.0
import "books_data_manager.js" as BooksDataManager
//import com.nokia.meego 1.0
import com.nokia.symbian 1.0


Page {
    //width: 360
    //height: 360
    //color: "black"
    id: page
    property int volume_index: 0
    property variant volumes;
    property string title: "Book Info"

    //Header!!!
    BorderImage {
        id: top_tool_bar
        anchors { left:  parent.left; right: parent.right; top: parent.top }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        height: 60
        source: "images/toolbar-top.png"
        Text {
            id: titleText
            text: title
            anchors.centerIn:  parent
            color: "white"
            font.pixelSize: 28
            font.bold: true;
            wrapMode: Text.WordWrap
        }
        Button {
            id: epubButton
            text: "epub";
            width: 80; height: 40
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                //root.state = "volumes"
                //pageStack.pop();
                console.log("Link to download", volumes[volume_index]["accessInfo"]["epub"]["downloadLink"])
                settingsManager.openUrl(volumes[volume_index]["accessInfo"]["epub"]["downloadLink"])
            }
        }
    }

    Component.onCompleted: {
        console.log("onCompleted");
//        showBookInfo();
//        if(volumes[volume_index]["accessInfo"]["epub"]["downloadLink"] == undefined)
//        {
//            epubButton.visible = false
//        }
    }
    onStatusChanged: {
        console.log("statusChanged", status);
        if(status == PageStatus.Active)
        {
            showBookInfo();
            if(volumes[volume_index]["accessInfo"]["epub"]["downloadLink"] == undefined)
            {
                epubButton.visible = false
            }
        }
    }

    function showBookInfo()
    {
        //volume_index = pageStack.volume_index;
        var index = volume_index;
        console.log("Book info", index);
        var str = "";
        str += "<html><body bgcolor=\"#FFFFFF\">";

        var strImage = "";
        if(("imageLinks" in volumes[index]["volumeInfo"]) &&
           ("thumbnail"  in volumes[index]["volumeInfo"]["imageLinks"]))
        {
            strImage = volumes[index]["volumeInfo"]["imageLinks"]["thumbnail"];
        }
        str += '<img src="'  +  strImage + '"width=128 height=192 />';
        str += "<p><u><font size=6>Title</u>: <b>" + volumes[index]["volumeInfo"]["title"] + "</b></font>\n\n";

        var authors = pageStack.volumes[index]["volumeInfo"]["authors"];
        var s1 = ""
        for(var j = 0; j < authors.length; ++j)
        {
            s1 += authors[j];
            if(j < authors.length-1)
                s1 += ", ";
        }
        str += "<P><u><font size=6>Authors</u>: <b>" + s1 + "</b></font>\n\n";

        str += "<P><u><font size=6>Viewability</u>: <b>" + volumes[index]["accessInfo"]["viewability"] + "</b></font>\n\n";


        //str += "<P><u>SelfLink</u>: <i>" + root.volumes[index]["selfLink"] + "</i>\n\n";
        str += "<P><u><font size=6>Publisher</u>: " + volumes[index]["volumeInfo"]["publisher"] + "\n\n";
        str += "<P><u>Published Date</u>: " + volumes[index]["volumeInfo"]["publishedDate"] + "\n\n";
        str += "<P><u>Description</u>: " + volumes[index]["volumeInfo"]["description"] + "</font>\n\n";

        str += "</body></html>\n";

        webView.html = str;

        //titleText.text = root.bookshelves[root.shelf_index]["title"];
    }


    Flickable {
        id: web_view_window

        anchors { left:  parent.left; right: parent.right; bottom: bottom_tool_bar.top; top: top_tool_bar.bottom }

        contentWidth: Math.max(width,webView.width)
        contentHeight: Math.max(height,webView.height)

        clip: true

        WebView {
            id: webView
            preferredWidth: web_view_window.width
            preferredHeight: web_view_window.height
        }
    }

    QueryDialog {
        id: queryDialog
        acceptButtonText: "Yes"
        rejectButtonText: "No"
        titleText: "Delete"

        onAccepted:  {
            console.log("Delete book accepted");
            var shelf_id = pageStack.bookshelves[root.shelf_index]["id"];
            var volume_id = pageStack.volumes[root.volume_index]["id"];
            BooksDataManager.removeVolumeFromBookshelf(shelf_id, volume_id);
            //root.state = "volumes"
            pageStack.pop();
        }
    }


    //Footer!!!
    BorderImage {
        id: bottom_tool_bar
        anchors { left:  parent.left; right: parent.right; bottom: parent.bottom }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        source: "images/toolbar-bottom.png"
        height: 60

        Button {
            text: "Back";
            width: 100; height: 40
            anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                //root.state = "volumes"
                pageStack.pop();
            }
        }

        Button {
            text: "Delete";
            width: 100; height: 40
            anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter }
            onClicked: {
                queryDialog.message = "Do you want to delete this book from the bookshelf '" + root.bookshelves[root.shelf_index]["title"] + "' ?";
                queryDialog.open();
                //root.state = "volumes"

            }
        }


        Button {
            text: "Read";
            width: 100; height: 40
            anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
            onClicked: {
                var url = "http://books.google.com/books/reader?id=" + root.volumes[volume_index]["id"] + "&printsec=frontcover&num=15";
                //readingPage.setUrl(url);
                //root.state = "reading"
                pageStack.push(Qt.resolvedUrl("ReadingPage.qml"), {url: url, pageStack: pageStack})
            }
        }
    }

}
