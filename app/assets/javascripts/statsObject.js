
function statsObject() {
  this.id = null;
  this.videoName = null;
  this.videoId = null;
  this.playState = UNSTARTED;
}

statsObject.prototype.getId = function() {
  return this.id;
}

statsObject.prototype.setId = function(value) {
  this.id = value;
}

statsObject.prototype.getVideoName = function() {
  return this.videoName;
}

statsObject.prototype.setVideoName = function(value) {
  this.videoName = value;
}

statsObject.prototype.getVideoId = function() {
  return this.videoId;
}

statsObject.prototype.setVideoId = function(value) {
  this.videoId = value;
}

statsObject.prototype.getPlayState = function() {
  return this.playState;
}

statsObject.prototype.setPlayState = function(value) {
  this.playState = value;
}

statsObject.prototype.isPaused = function() {
  return this.playState == PAUSED;
}