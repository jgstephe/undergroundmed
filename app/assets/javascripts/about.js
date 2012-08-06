var foundersText =
    "<b>Xinran (Leo) Liu</b><br/>Graduated from Cornell University with a major in Chemistry and Chemical Biology.  " +
        " He is currently a 4th year medical student at the Geisel School of Medicine at Dartmouth trying to decide which specialty to go into.  " +
        "His interests outside of clinical practice include LEAN process improvement, entrepreneurship, and medical education.  " +
        "In his free time, he enjoys reading, ultimate frisbee, basketball, tennis, ping pong, golf, drawing, among numerous other random things." +
        "<br/>" +
        " <b>Whitney de Luna</b><br/>" +
        " Graduated from Stanford University with a major in biological sciences. She is currently a 4th year medical student at the Geisel School of Medicine at Dartmouth interested in anesthesiology.   " +
        "Outside of the clinic her academic interests include the use of technology for education and global health. " +
        "In her free time she enjoys traveling, cooking, playing tennis and golf." +
        "<br/>" +
        "<b>Sharath Bhagavatula</b><br/>" +
        "Graduated from Cornell University with a degree in Electrical and Computer Engineering. He's currently a 4th year medical student " +
        "at NYU School of Medicine, interested in radiology. Outside of the clinic, his academic interests include robotics, engineering " +
        "research, and website development. Other interests include tennis, basketball, and watching TV.";


var collaborationText = "This site is a collaboration between UndergroundMed, a team of medical students, and <a href='#' onclick='openMeduWindow()'>MedU</a>, " +
    "a non-profit with a mission of advancing medical education through the innovative use of technology.  All site content was " +
    "written and produced by UndergroundMed; the web site is hosted and maintained through financial and technical support from MedU in support of UndergroundMed's " +
    "novel approach to teaching and building a community of student medical educators.";

var missionStatement ="Our goal is to use brief, practical, high-yield videos to make medical education more accessible and understandable for students. " +
    "All content on UndergroundMed is created by medical students, so information is tailored to what is most important and presented in a way that is easy to understand. " +
    "Videos are checked for factual correctness by experienced and accomplished medical educators. " +
    "<p/>" +
    "We are, and always intend to be, a student run organization - but one that also has support from nationally recognized and " +
    "accredited medical organizations. " +
    "<p/>" +
    "If you would like to join us in our mission, please contact us!  And please feel free to offer any advice or suggestions on how we " +
    "can improve your UndergroundMed experience!";

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