var foundersText =  "founders text";


var collaborationText = "collaboration text";

var missionStatement ="mission statement";

function aboutFounders() {
  showinfoDialog(foundersText, "Meet the Founders");
}

function aboutCollaboration() {
  showinfoDialog(collaborationText, "Collaboration");
}

function aboutMission() {
  showinfoDialog(missionStatement, "Our Mission");
}

function openMeduWindow() {
  hideInfoDialog();
  window.open("http://www.med-u.org/");
}