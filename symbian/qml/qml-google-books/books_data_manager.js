function getBookshelves()
{
    console.log("getBookshelves called");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200)
        {
            //console.log("response headers:\n", req.getAllResponseHeaders());
            //console.log("responseText", req.responseText);
            var result = eval('(' + req.responseText + ')');
            if(result["kind"] == "error")
            {
                console.log("Error occured", result)
            }
            else
            {
                pageStack.bookshelves = result["items"]
            }
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4)
        {
            pageStack.runBusyIndicator(false);
            console.log("response headers:\n", req.getAllResponseHeaders());
            console.log("responseText", req.responseText);
        }
    }
    pageStack.runBusyIndicator(true);
    req.open("GET", "https://www.googleapis.com/books/v1/mylibrary/bookshelves?pp=1&access_token=" + google_oauth.accessToken, true);
    req.send(null);
}

function getVolumes(shelf_id, pageStack)
{
    console.log("getVolumes called", pageStack);
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200)
        {
            //console.log("responseText", req.responseText);
            var result = eval('(' + req.responseText + ')');
            if(result["kind"] == "error")
            {
                console.log("Error occured", result)
            }
            else
            {
                if("items" in result)
                {
                    pageStack.volumes = result["items"];
                }
                else
                {
                    pageStack.volumes = [];
                }
                for(var i = 0; i < pageStack.bookshelves.length; ++i)
                {
                    if(shelf_id == pageStack.bookshelves[i]["id"])
                    {
                        pageStack.shelf_index = i;
                        break;
                    }
                }
            }
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4)
        {
            console.log("response headers:\n", req.getAllResponseHeaders());
            console.log("responseText", req.responseText);
            pageStack.runBusyIndicator(false);
        }
    }

    pageStack.runBusyIndicator(true);
    req.open("GET", "https://www.googleapis.com/books/v1/mylibrary/bookshelves/"+shelf_id+ "/volumes?pp=1&access_token=" + google_oauth.accessToken, true);
    req.send(null);
}

function clearVolumesFromBookshelf(shelf_id)
{
    console.log("clearVolumesFromBookshelf called", shelf_id);
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200)
        {
            //console.log("responseText", req.responseText);
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4 && req.status == 403)
        {
            console.log("Status = ", req.status);
            console.log("response headers:\n", req.getAllResponseHeaders());
            console.log("responseText", req.responseText);
            console.log("Cannot remove all books from this Bookshelf.");
            pageStack.showWarning("Cannot remove all books from this Bookshelf.");
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4 && req.status == 204)
        {
            console.log("Status = ", req.status);
            //console.log("response headers:\n", req.getAllResponseHeaders());
            //console.log("responseText", req.responseText);
            pageStack.runBusyIndicator(false);
            getVolumes(shelf_id, pageStack);
        }
    }

    pageStack.runBusyIndicator(true);
    var url = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/"+shelf_id+ "/clearVolumes?access_token=" + google_oauth.accessToken;
    console.log("POST url", url);
    req.open("POST", url, true);
    req.setRequestHeader("Content-Type", "application/json");
    req.send();
}

function removeVolumeFromBookshelf(shelf_id, volume_id)
{
    console.log("removeVolumeFromBookshelf called", shelf_id, volume_id, pageStack);
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200)
        {
            console.log("responseText", req.responseText);
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4 && req.status == 403)
        {
            console.log("Status = ", req.status);
            console.log("response headers:\n", req.getAllResponseHeaders());
            console.log("responseText", req.responseText);
            console.log("Cannot remove a book from this Bookshelf.");
            pageStack.showWarning("Cannot remove a book from this Bookshelf.");
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4 && req.status == 204)
        {
            console.log("Status = ", req.status);
            //console.log("response headers:\n", req.getAllResponseHeaders());
            //console.log("responseText", req.responseText);
            pageStack.runBusyIndicator(false);
            getVolumes(shelf_id, pageStack);
        }
    }


    pageStack.runBusyIndicator(true);
    var url = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/"+shelf_id+ "/removeVolume?volumeId=" + volume_id + "&access_token=" + google_oauth.accessToken;
    console.log("POST url", url);
    req.open("POST", url, true);
    req.setRequestHeader("Content-Type", "application/json");
    req.send();
}

function addVolumeToBookshelf(shelf_id, volume_id)
{
    console.log("addVolumeToBookshelf called", shelf_id, volume_id);
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200)
        {
            console.log("responseText", req.responseText);
            pageStack.runBusyIndicator(false);
            getVolumes(shelf_id, pageStack);
        }
        else if(req.readyState == 4 && req.status == 403)
        {
            console.log("Status = ", req.status);
            //console.log("response headers:\n", req.getAllResponseHeaders());
            //console.log("responseText", req.responseText);
            console.log("Cannot add a book to this Bookshelf.");
            pageStack.showWarning("Cannot add the book to this Bookshelf.");
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4 && req.status == 204)
        {
            console.log("Status = ", req.status);
            //console.log("response headers:\n", req.getAllResponseHeaders());
            //console.log("responseText", req.responseText);
            //console.log("Cannot add a book to this Bookshelf.");
            //root.showWarning("Cannot add the book to this Bookshelf.");
            pageStack.runBusyIndicator(false);
            getVolumes(shelf_id, pageStack);
        }
    }


    pageStack.runBusyIndicator(true);
    var url = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/"+shelf_id+ "/addVolume?volumeId=" + volume_id + "&access_token=" + google_oauth.accessToken;
    console.log("POST url", url);
    req.open("POST", url, true);
    req.setRequestHeader("Content-Type", "application/json");
    req.send();
}


function findBooks(title, author)
{
    console.log("findBooks", title, author);
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.readyState == 4 && req.status == 200)
        {
            //console.log("responseText", req.responseText);
            var result = eval('(' + req.responseText + ')');
            if(result["kind"] == "error")
            {
                console.log("Error occured", result)
            }
            else
            {
                if("items" in result)
                {
                    pageStack.search_volumes = result["items"];
                }
                else
                {
                    pageStack.search_volumes = [];
                }
            }
            pageStack.runBusyIndicator(false);
        }
        else if(req.readyState == 4)
        {
            console.log("response headers:\n", req.getAllResponseHeaders());
            console.log("responseText", req.responseText);
            pageStack.runBusyIndicator(false);
        }
    }


    pageStack.runBusyIndicator(true);
    var url = "https://www.googleapis.com/books/v1/volumes?q=";
    if(author)
    {
       url += "inauthor:" + author + "+";
    }
    if(title)
    {
        url += "intitle:" + title;
    }
    req.open("GET", url, true);
    req.send();

}
