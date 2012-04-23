import QtQuick 1.0


Component {

    //TODO: clean up it (too much unnecessary elements here)
    Item {

        id: wrapper; width: wrapper.ListView.view.width; height: 80
        Item {
            id: moveMe

            Rectangle {
                color:  index % 2 ? root.light_color : root.dark_color;
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
                        console.log("Volumes delegate clicked.")
                        pageStack.volume_index = index;
                        //bookInfoPage.showBookInfo();
                        //root.state = "book_info"
                        pageStack.push(Qt.resolvedUrl("BookInfoPage.qml"),
                                       {volume_index: index, volumes:pageStack.volumes, title: pageStack.bookshelves[pageStack.shelf_index]["title"]})
                    }
                }
            }
        }
    }
}
