import QtQuick 1.0
import "books_data_manager.js" as BooksDataManager
import com.nokia.meego 1.0
//import com.nokia.symbian 1.0


Component {

    //TODO: clean up it (too much unnecessary elements here)
    Item {

        id: wrapper; width: wrapper.ListView.view.width; height: 80
        Item {
            id: moveMe

            SelectionDialog {
                id: selectionDialog
                titleText: "Add book to the bookshelf"
                selectedIndex: -1

                model: bookshelvesModelForSelection

                onSelectedIndexChanged: {
                    console.log("Selected index = ", selectedIndex);
                    if(selectedIndex != -1)
                    {
                        var shelf_id = root.bookshelves[selectedIndex]["id"];
                        BooksDataManager.addVolumeToBookshelf(shelf_id, volume_id);
                    }
                }

            }

            Rectangle {
                color:  index % 2 ? pageStack.light_color : pageStack.dark_color;
                width: wrapper.width; height: wrapper.height;



                Text {
                    id: titleText

                    anchors {left: parent.left; leftMargin: 10; top: parent.top; topMargin: 10 }
                    text: title
                    elide: "ElideRight"
                    font.pixelSize: 26
                    color: "white"
                    width: wrapper.width - 40
                }

                Text {
                    id: authorsText

                    anchors {left: parent.left; leftMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
                    text: authors
                    elide: "ElideRight"
                    font.pixelSize: 26
                    color: "white"
                    width: wrapper.width - 40
                }

                Image {
                    source: "images/Button-Plus.png"
                    anchors { verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: 10}
                }



                Rectangle {
                    anchors.fill: parent; color: "white"; opacity:  0.4
                    visible: mouseRegion.containsMouse
                }

                MouseArea {
                    id: mouseRegion
                    anchors.fill: parent
                    onClicked: {
                        console.log("Search delegate clicked. = ", root.bookshelves_list);
                        selectionDialog.selectedIndex = -1;
                        selectionDialog.open();
                    }
                }
            }
        }
    }
}
