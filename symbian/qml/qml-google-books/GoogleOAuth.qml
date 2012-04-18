import QtQuick 1.0
import QtWebKit 1.0
import "google_oauth.js" as OAuth

//import com.nokia.meego 1.0
import com.nokia.symbian 1.0


Rectangle {
    id: google_oauth
    width:  400
    height: 400
    color: "#343434";
    property string oauth_link: "https://accounts.google.com/o/oauth2/auth?" +
                                "client_id=" + OAuth.client_id +
                                "&redirect_uri=" + OAuth.redirect_uri +
                                "&response_type=code" +
                                "&scope=https://www.googleapis.com/auth/books" +
                                "&access_type=offline" +
                                "&approval_prompt=force"
    property bool authorized: accessToken != ""
    property string accessToken: ""
    signal loginDone();

    onAccessTokenChanged: {
        console.log('onAccessTokenChanged');
        if(accessToken != '')
        {
            console.log("accessToken = ", accessToken)
            //textEditToHideKeyboard.closeSoftwareInputPanel();
            loginDone();
        }
    }


    function login()
    {
        loginView.url = oauth_link;
    }

    function refreshAccessToken(refresh_token)
    {
        OAuth.refreshAccessToken(refresh_token)
    }

    //Header!!!
    BorderImage {
        id: top_tool_bar
        anchors { left:  parent.left; right: parent.right; top: parent.top }
        //x: 0; y:0; width:360; height: mainWindow.tb_height
        height: 60
        source: "images/toolbar-top.png"
        Text {
            id: titleText
            text: "Login"
            anchors.centerIn:  parent
            color: "white"
            font.pixelSize: 28
            font.bold: true;
            wrapMode: Text.WordWrap
        }
//        MouseArea {
//            anchors { left: parent.left; top: parent.top; bottom: parent.bottom; right: closeButton.left }
//            onClicked: {
//                console.log("Header clicked");
//                textEditToHideKeyboard.closeSoftwareInputPanel();
//            }
//        }
//        TextEdit{
//            id: textEditToHideKeyboard
//            visible: false
//            width: 40;
//            height: 40
//            anchors { left:hideKeyboardButton.right; verticalCenter: parent.verticalCenter}
//        }

        Button {
            id: closeButton
            text: "Close"
            width: 120
            height: 40
            anchors { right:  parent.right; verticalCenter: parent.verticalCenter }
            onClicked: {
                //textEditToHideKeyboard.closeSoftwareInputPanel();
                google_oauth.visible = false;
            }
        }
//        Button {
//            id: hideKeyboardButton
//            text: "Hide Keyboard"
//            width: 200
//            height: 40
//            anchors { left:  parent.left; verticalCenter: parent.verticalCenter }
//            onClicked: {
//                console.log("Hide clicked");
//                //textEditToHideKeyboard.focus = true;
//                textEditToHideKeyboard.closeSoftwareInputPanel();
//            }
//        }
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

    Flickable {
        id: web_view_window

        property bool loading:  false;
        anchors { top: top_tool_bar.bottom; right: parent.right; left: parent.left; bottom: parent.bottom }

        contentWidth: Math.max(width,loginView.width)
        contentHeight: Math.max(height,loginView.height)
        clip: true

        WebView {
            id: loginView

            preferredWidth: web_view_window.width
            preferredHeight: web_view_window.height
            contentsScale: 1.7

            url: ""
            onUrlChanged: OAuth.urlChanged(url)

            onLoadFinished: {
                console.log("onLoadFinished");
                busy_indicator.running = false;
                busy_indicator.visible = false;
            }

            onLoadStarted: {
                console.log("onLoadStarted");
                busy_indicator.running = true;
                busy_indicator.visible = true;
            }


        }
    }


}
