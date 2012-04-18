import QtQuick 1.0
import "books_data_manager.js" as BooksDataManager
import ICS 1.0
//import com.nokia.meego 1.0
import com.nokia.symbian 1.0



Window {
    id: window

    //color: "black"




    //property bool initialized: false

    anchors {
        fill: parent
    }

    PageStack {
        id: pageStack
        anchors.fill: parent

        property string light_color: "#272727"
        property string dark_color:  "#181818"

        property variant bookshelves;
        property variant volumes;
        property variant search_volumes;

        property int shelf_index:  0
        property int volume_index: 0

        function updateBookshelvesModel()
        {
            console.log("updateBookshelvesModel");
            bookshelvesModel.clear();
            bookshelvesModelForSelection.clear();
            for(var i = 0; i < bookshelves.length; ++i)
            {
                console.log(i, bookshelves.length, bookshelves[i]["title"], bookshelves[i]["id"]);
                bookshelvesModel.append({"title":bookshelves[i]["title"], "shelf_id": bookshelves[i]["id"],
                                            "volumeCount": bookshelves[i]["volumeCount"]});
                bookshelvesModelForSelection.append({"name": bookshelves[i]["title"]}); //Name is needed for the Adding SelectionDialog.
            }

        }

        onBookshelvesChanged: {
            updateBookshelvesModel();
        }

        onVolumesChanged: {
            console.log("volumes", volumes);
            volumesModel.clear();
            for(var i = 0; i < volumes.length; ++i)
            {
                var authors = volumes[i]["volumeInfo"]["authors"];
                var s = ""
                for(var j = 0; j < authors.length; ++j)
                {
                    s += authors[j];
                    if(j < authors.length-1)
                        s += ", ";
                }

                volumesModel.append({"title":volumes[i]["volumeInfo"]["title"], "volume_id": volumes[i]["id"],
                                        "authors": s});

            }
            bookshelves[shelf_index]["volumeCount"] = volumes.length;
            updateBookshelvesModel();
        }

        onSearch_volumesChanged: {
            searchResultsModel.clear();
            for(var i = 0; i < search_volumes.length; ++i)
            {
                var authors = search_volumes[i]["volumeInfo"]["authors"];
                var s = ""
                for(var j = 0; j < authors.length; ++j)
                {
                    s += authors[j];
                    if(j < authors.length-1)
                        s += ", ";
                }

                searchResultsModel.append({"title":search_volumes[i]["volumeInfo"]["title"], "volume_id": search_volumes[i]["id"],
                                        "authors": s});

            }
        }

        function showWarning(warning)
        {
            warningDialog.message = warning;
            warningDialog.open();
        }

        function runBusyIndicator(b)
        {
            busy_indicator.visible = b;
            busy_indicator.running = b;
        }


        BusyIndicator {
            id: busy_indicator;
            running: false
            width:  100;
            height: 100;
            anchors.centerIn:  parent;
            visible: false
            z: 10
        }
        QueryDialog {
            id: warningDialog
            acceptButtonText: "Close"
            titleText: "Error"

        }
    }//End of page stack


    Component.onCompleted: {
        console.log("onCompleted")
        pageStack.push(Qt.resolvedUrl("BookshelvesPage.qml"));

        console.log("onCompleted!!")
        //google_oauth.accessToken = settingsManager.accessToken;
        if(settingsManager.refreshToken == "")
        {
            console.log("onCompleted")
            google_oauth.visible = true;
            google_oauth.login();
        }
        else
        {
            //BooksDataManager.getBookshelves();
            google_oauth.refreshAccessToken(settingsManager.refreshToken);
        }

    }


    //property int pageWidth:  854 //360 - N8 (Symbian); 854 - N9 (MeeGo) (as N9 works in Landscape mode)
    //property int pageHeight: 480 //640 - N8 (Symbian); 480 - N9 (MeeGo) (as N9 works in Landscape mode)

    //width:  pageWidth
    //height: pageHeight



    SettingsManager {
        id: settingsManager
    }








    ListModel {
        id: bookshelvesModel
        //ListElement {
        //    title: ""
        //    shelf_id: ""
        //}
    }

    ListModel {
        id: bookshelvesModelForSelection
        //ListElement {
        //    name: ""
        //}
    }


    ListModel {
        id: volumesModel
        //ListElement {
        //    title: ""
        //    volume_id: ""
        //    author: ""
        //}
    }

    ListModel {
        id: searchResultsModel
        //ListElement {
        //    title: ""
        //    volume_id: ""
        //    author: ""
        //}
    }


    GoogleOAuth {
        id: google_oauth
        visible: false
        anchors.fill: parent
        z: 10
        onLoginDone: {
            visible = false;
            console.log("Login Done")
            settingsManager.accessToken = google_oauth.accessToken;
            BooksDataManager.getBookshelves();
        }
    }


//    Component.onCompleted: {
//        console.log("onCompleted!!")
//        //google_oauth.accessToken = settingsManager.accessToken;
//        if(settingsManager.refreshToken == "")
//        {
//            console.log("onCompleted")
//            google_oauth.visible = true;
//            google_oauth.login();
//        }
//        else
//        {
//            //BooksDataManager.getBookshelves();
//            google_oauth.refreshAccessToken(settingsManager.refreshToken);
//        }
//    }

//    BookshelvesPage {
//        id: bookshelvesPage
//        width:  pageWidth
//        height: pageHeight
//        x: 0
//        y: 0
//    }

//    VolumesPage {
//        id: volumesPage
//        width:  pageWidth
//        height: pageHeight
//        x: pageWidth
//        y: 0
//    }

//    BookInfoPage {
//        id: bookInfoPage
//        width:  pageWidth
//        height: pageHeight
//        x: pageWidth
//        y: 0
//    }

//    ReadingPage {
//        id: readingPage
//        width:  pageWidth
//        height: pageHeight
//        x: pageWidth
//        y: 0
//    }

//    FindPage {
//        id: findPage
//        width:  pageWidth
//        height: pageHeight
//        x: pageWidth
//        y: 0
//    }

//    SearchResultsPage {
//        id: searchResultsPage
//        width:  pageWidth
//        height: pageHeight
//        x: pageWidth
//        y: 0
//    }





//    states: [
//        State {
//            name: "bookshelves"
//            PropertyChanges { target: bookshelvesPage; x: 0   }
//            PropertyChanges { target: volumesPage;     x: pageWidth }
//            PropertyChanges { target: bookInfoPage;    x: pageWidth }
//            PropertyChanges { target: readingPage;     x: pageWidth }
//            PropertyChanges { target: findPage;        x: pageWidth }
//            PropertyChanges { target: searchResultsPage; x: pageWidth }
//        },
//        State {
//            name: "volumes"
//            PropertyChanges { target: bookshelvesPage; x: -pageWidth }
//            PropertyChanges { target: volumesPage;     x: 0    }
//            PropertyChanges { target: bookInfoPage;    x: pageWidth  }
//            PropertyChanges { target: readingPage;     x: pageWidth }
//            PropertyChanges { target: findPage;        x: pageWidth }
//            PropertyChanges { target: searchResultsPage; x: pageWidth }
//        },
//        State {
//            name: "book_info"
//            PropertyChanges { target: bookshelvesPage; x: -pageWidth }
//            PropertyChanges { target: volumesPage;     x: -pageWidth }
//            PropertyChanges { target: bookInfoPage;    x: 0    }
//            PropertyChanges { target: readingPage;     x: pageWidth }
//            PropertyChanges { target: findPage;        x: pageWidth }
//            PropertyChanges { target: searchResultsPage; x: pageWidth }
//        },
//        State {
//            name: "reading"
//            PropertyChanges { target: bookshelvesPage; x: -pageWidth }
//            PropertyChanges { target: volumesPage;     x: -pageWidth }
//            PropertyChanges { target: bookInfoPage;    x: -pageWidth }
//            PropertyChanges { target: readingPage;     x: 0    }
//            PropertyChanges { target: findPage;        x: pageWidth }
//            PropertyChanges { target: searchResultsPage; x: pageWidth }
//        },
//        State {
//            name: "find"
//            PropertyChanges { target: bookshelvesPage; x: -pageWidth }
//            PropertyChanges { target: volumesPage;     x: -pageWidth }
//            PropertyChanges { target: bookInfoPage;    x: pageWidth }
//            PropertyChanges { target: readingPage;     x: pageWidth  }
//            PropertyChanges { target: findPage;        x: 0 }
//            PropertyChanges { target: searchResultsPage; x: pageWidth }
//        },
//        State {
//            name: "search_results"
//            PropertyChanges { target: bookshelvesPage; x: -pageWidth }
//            PropertyChanges { target: volumesPage;     x: -pageWidth }
//            PropertyChanges { target: bookInfoPage;    x: pageWidth }
//            PropertyChanges { target: readingPage;     x: pageWidth  }
//            PropertyChanges { target: findPage;        x: -pageWidth }
//            PropertyChanges { target: searchResultsPage; x: 0 }
//        }
//    ]

//    transitions: [
//        Transition {
//            from: "*"
//            to: "*"
//            NumberAnimation { properties: "x,y"; easing.type: Easing.Linear; duration: 350 }
//        }
//    ]





}
