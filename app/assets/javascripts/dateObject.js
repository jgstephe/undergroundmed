function dateObject() {
  this.year = null;
  this.month = null;
  this.day = null;
  this.hours = null;
  this.minutes = null;
  this.seconds = null;
  this.tzOffset = null;
}

dateObject.prototype.getYear = function() {
  return this.year;
}

dateObject.prototype.setYear = function(value) {
  this.year = value;
}

dateObject.prototype.getMonth = function() {
  return this.month;
}

dateObject.prototype.setMonth = function(value) {
  this.month = value;
}

dateObject.prototype.getDay = function() {
  return this.day;
}

dateObject.prototype.setDay = function(value) {
  this.day = value;
}

dateObject.prototype.getHours = function() {
  return this.hours;
}

dateObject.prototype.setHours = function(value) {
  this.hours = value;
}


dateObject.prototype.getMinutes = function() {
  return this.minutes;
}

dateObject.prototype.setMinutes = function(value) {
  this.minutes = value;
}

dateObject.prototype.getSeconds = function() {
  return this.seconds;
}

dateObject.prototype.setSeconds = function(value) {
  this.seconds = value;
}

dateObject.prototype.getTZOffset = function() {
  return this.tzOffset;
}

dateObject.prototype.setTZOffset = function(value) {
  this.tzOffset = value;
}
