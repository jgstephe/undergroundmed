// these are used by the prevous/next buttons
var currentVideoList = null;
var currentPosition = null;
var firstPosition = null;
var lastPosition = null;
var allVideosList = null;
var allCategories = "All";
var currentVideoURL = "";

function getVideoList(value)    {
  showProgressDialog("Getting list of " + value + " videos...");

  $.ajax({
    url: "show_videos/get_list",
    dataType: 'json',
    data:  { category: value },
    success: function(data, status, xhr) {
      buildTable(data) ;
      if(value == allCategories)
        allVideosList = data;
      hideProgressDialog();
      setPositionForFeaturedVideo (featuredVideoId) ;
      newStats(featuredVideoId);
    },
    error: function(xhr, status, error) {
      showMsg(error);
    }
  });
}

function getVideoListLocal(value) {

  if(allVideosList != null) {
    var  videoList = new Array();

      if(value != allCategories)  {
      for(i = 0; i < allVideosList.length; i++) {
        if(allVideosList[i].category == value)  {
          videoList.push(allVideosList[i]);
        }
      }

      /*
       mimics ruby <=> (Combined comparison operator).
       Returns 0 if first operand equals second,
       1 if first operand is greater than the second
       and -1 if first operand is less than the second
       */
      videoList.sort(function(a,b){
        return (
            (parseInt(a.order) < parseInt(b.order)) ? -1 :
            (parseInt(a.order) > parseInt(b.order)) ? +1 : 0);
      });

      /* for debugging */
//      var order = "";
//      for (j = 0; j < videoList.length; j++) {
//         order += videoList[j].order + ", ";
//      }

  }
  else {
        videoList = allVideosList;
    }

   buildTable(videoList);
   cueVideo(videoList[0].yt_id);
  }
  else  {
    getVideoList(value);
  }

}

function buildTable(videolist) {
  setupPostionParams(videolist);

  var table = document.getElementById("videoListTable")

  // Remove all table rows
  var tableRows = table.rows;
  for (var i = tableRows.length-1; i >= 1; i--) {
    table.deleteRow(i);
  }

   for(i=0; i < videolist.length; i++) {
     var row = createTableRow(table, "");

     var img = createImg(videolist[i]);
     createElementCell(row, "", img, "");

     var link = createAnchor(videolist[i]);
     createElementCell(row, "", link, "");

     var avg_rating = "Not rated";
     if(videolist[i].avg_rating != undefined && videolist[i].avg_rating.length > 0)
      avg_rating = videolist[i].avg_rating;

     createTextCell(row, "", avg_rating, "");
     createTextCell(row, "", videolist[i].view_count, "");
   }
}

function createImg(video) {
  var img = document.createElement('img');

  img.src = video.thumbnail;
  img.height = "50";
  img.width = "90";
  img.style.cursor="pointer";
  img.style.padding = "3px";
  img.style.marginLeft = "auto";
  img.style.marginRight = "auto";
  img.style.display = "block";
//  img.style.verticalAlign = "top";
  img.title = "Duration: " + video. duration_in_minutes;

  addVideoLoadOnClick(img, video.yt_id) ;

  return img;
}

function createAnchor(video) {
  var anchor = document.createElement('a');

  anchor.innerHTML = video.title+"<br/><span class='categorySpan'> "+video.category +"</span>";

  addVideoLoadOnClick(anchor, video.yt_id) ;

  return anchor;
}

function addVideoLoadOnClick(element, id) {
  try {
    element.onclick = new Function("loadVideo('" + id + "')");
  }
  catch (e) {
    element.onclick = new Function("loadVideo(id);");
  }
}

 function setupPostionParams(videoList) {
   currentVideoList = videoList;
   firstPosition = videoList[0].order;
   currentPosition = videoList[0].order;
   lastPosition =  videoList[videoList.length-1].order;
 }

function findPositionInList(order)   {
  for(i = 0; i < currentVideoList.length; i++) {
    if(currentVideoList[i].order == order)  {
      return i;
    }
  }
}

function findVideoByid(yt_id)   {
  var video = null;
  for(i = 0; i < currentVideoList.length; i++) {
    if(currentVideoList[i].yt_id == yt_id)  {
      video =  currentVideoList[i];
      break;
    }
  }

  return video;
}

// note that we never assume the order will be sequential numbers
// because it is possible to have a subset of the total list.
  function getPreviousVideo() {
    // if we are at the start, we're done
    if(currentPosition == firstPosition)
      return;

    var index = findPositionInList(currentPosition);
    var video = currentVideoList[index-1];
    currentPosition = video.order;
    cueVideo(video.yt_id);
  }

  function getNextVideo() {
    // if we are at the end, we're done
    if(currentPosition == lastPosition)
      return;

    var index = findPositionInList(currentPosition);
    var video = currentVideoList[index+1];
    currentPosition = video.order;
    cueVideo(video.yt_id);
  }

function showVideoTitle(id) {
  var video = findVideoByid(id);

  $("#fv_title").text(video.title);
}

function setPositionForFeaturedVideo(id) {
  var video = findVideoByid(id);
  currentPosition = video.order;
}

function setCurrentURL(videoId) {
  var url = getRuntimeURL();
  currentVideoURL = url + "?playId=" + videoId

  $("#shareInput").css("display", "none");
  $("#shareText").css("display", "none");
}

function getRuntimeURL() {
  var url = "videos.undergroundmed.net";
  var httpStr = "http://"

  switch (runtimeEnvironment) {
    case "development":
      url = "localhost:3000";
      break;
    case "staging":
      url ="strong-stream-7408.herokuapp.com/";
      break;
  }

  return httpStr+url;
}
