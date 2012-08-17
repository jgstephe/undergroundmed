var currentStats = null;
var startPlayURL =  "viewing_stats/start_play";
var endPlayURL =  "viewing_stats/end_play";
var restartPlayURL =  "viewing_stats/restart_play";

function getCurrentDate() {
  var dObject = new dateObject();
  var newDate = new Date();

  dObject.setYear(newDate.getUTCFullYear());
  dObject.setMonth(newDate.getUTCMonth()+1);
  dObject.setDay(newDate.getUTCDate());
  dObject.setHours(newDate.getUTCHours());
  dObject.setMinutes(newDate.getUTCMinutes());
  dObject.setSeconds(newDate.getUTCSeconds());
  dObject.setTZOffset(newDate.getTimezoneOffset());

   return dObject;
}

function recordStats(url,  startDate, endDate) {
   var x = 0;
  $.ajax({
    url: url,
    type: "POST",
    dataType: 'json',
    data:  {
      username: currentUser,
      videoname: currentStats.getVideoName(),
      videoid: currentStats.getVideoId(),
      id: currentStats.getId(),
      startdate: startDate != null ? JSON.stringify(startDate) :"",
      enddate: endDate != null ? JSON.stringify(endDate) :"",
      tzoffset:  startDate != null ? startDate.getTZOffset() :endDate.getTZOffset(),
      },
    success: function(data, status, xhr) {
      setId(data);
    },
    error: function(xhr, status, error) {
      currentStats = new statsObject();
    }
  });
}

function setId(data) {
  id = data[0];

  if(id != "fail")  {
      currentStats.setId(id);
  }
  else
   currentStats = new statsObject();
}

function newStats(videoId)   {
  var video = findVideoByid(videoId);

  currentStats = new statsObject();
  currentStats.setVideoName(video.title);
  currentStats.setVideoId(videoId);
}

function startPlay() {
  if(currentStats.isPaused())
    recordStats(restartPlayURL,  getCurrentDate(), null);
   else
    recordStats(startPlayURL,  getCurrentDate(), null);
}

function endPlay() {

  if(currentStats.getPlayState() == PLAYING )  {
    recordStats(endPlayURL,  null, getCurrentDate());
    currentStats.setPlayState(UNSTARTED); // if there is more than one transition event this keeps from recording twice.
  }
}