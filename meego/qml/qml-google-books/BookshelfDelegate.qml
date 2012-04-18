import QtQuick 1.0
import "books_data_manager.js" as BooksDataManager


Component {

    //TODO: clean up it (too much unnecessary elements here)
    Item {

        id: wrapper; width: wrapper.ListView.view.width; height: 80
        Item {
            id: moveMe

            Rectangle {
                color:  index % 2 ? pageStack.light_color : pageStack.dark_color;
                width: wrapper.width; height: wrapper.height;



                Text {
                    id: titleText

                    anchors {left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                    text: title
                    elide: "ElideRight"
                    font.pixelSize: 28
                    color: "white"
                }

                Text {
                    id: countText

                    anchors {right: parent.right; rightMargin: 50; verticalCenter: parent.verticalCenter }
                    text: (volumeCount != undefined) ? "(" + volumeCount + ")" : ""
                    elide: "ElideRight"
                    font.pixelSize: 24
                    color: "white"
                }


                Image {
                    source: "images/Button-RedArrowMore.png"
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
                        console.log("Bookshelf delegate clicked.", "shelf_id", shelf_id);
                        //volumesModel.clear();
                        BooksDataManager.getVolumes(shelf_id, pageStack);
                        //volumesPage.title = title;
                        pageStack.shelf_index = index;
                        //root.state = "volumes"
                        pageStack.push(Qt.resolvedUrl("VolumesPage.qml"));//, {title: title})
                    }
                }
            }
        }
    }
}
