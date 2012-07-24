var UNSTARTED = -1;
var ENDED = 0;
var PLAYING = 1;
var PAUSED = 2;
var BUFFERING = 3;
var CUED = 5;

function loadVideo(id) {
  var videoID = id
  var video = findVideoByid(id);
  currentPosition = video.order;
  showVideoTitle(id);

  if(ytplayer) {
    ytplayer.loadVideoById(videoID);
  }

  newStats(id);
}

function cueVideo(id) {
  var videoID = id
  var video = findVideoByid(id);
  currentPosition = video.order;
  showVideoTitle(id);

  if(ytplayer) {
    ytplayer.cueVideoById(videoID);
  }

  newStats(id);
}

//This function is called when an error is thrown by the player
function onPlayerError(errorCode) {
  alert("An error occured of type:" + errorCode);
}

//This function is automatically called by the player once it loads
function onYouTubePlayerReady(playerId) {
  ytplayer = document.getElementById("ytPlayer");
  ytplayer.addEventListener("onError", "onPlayerError");
  ytplayer.addEventListener("onStateChange", "handleStateChange");
}

//The "main method" of this sample. Called when someone clicks "Run".
function loadPlayer(id) {

  // The video to load
  var videoID = id
  // Lets Flash from another domain call JavaScript
  var params = { allowScriptAccess: "always", wmode:"transparent" , allowFullScreen: true};
  // The element id of the Flash embed
  var atts = { id: "ytPlayer" };
  // All of the magic handled by SWFObject (http://code.google.com/p/swfobject/)
  swfobject.embedSWF("http://www.youtube.com/v/" + videoID +
      "?version=3&enablejsapi=1&playerapiid=player1",
      "videoDiv", "640", "385", "9", null, null, params, atts);
}

/*
 Possible event values are unstarted (-1), ended (0), playing (1), paused (2), buffering (3), video cued (5).
 When the SWF is first loaded it will broadcast an unstarted (-1) event. When the video is cued and ready to play
 it will broadcast a video cued event (5).
 */
function handleStateChange (event) {

  // if we are transitioning between states see if there is anything to record`
  if(event != PAUSED && event != BUFFERING)  {
    endPlay();
  }

  if(event == PLAYING)  {
      startPlay();
      currentStats.setPlayState(PLAYING);
    }

  if (event == PAUSED) {
      currentStats.setPlayState(PAUSED);
  }
}