var foundersText =
    "<b>Xinran (Leo) Liu</b><br/>Graduated from Cornell University with a major in Chemistry and Chemical Biology.  " +
        " He is currently a 4th year medical student at the Geisel School of Medicine trying to decide which specialty to go into.  " +
        "His interests outside of clinical practice include LEAN process improvement, entrepreneurship, and medical education.  " +
        "In his free time, he enjoys reading, ultimate frisbee, basketball, tennis, ping pong, golf, drawing, among numerous other random things." +
        "<br/>" +
        " <b>Whitney de Luna</b><br/>" +
        " Graduated from Stanford University with a major in biological sciences. She is currently a 4th year medical student at the Geisel School of Medicine at Dartmouth interested in anesthesiology.   " +
        "Outside of the clinic her academic interests include the use of technology for education and global health. " +
        "In her free time she enjoys traveling, cooking, playing tennis and golf." +
        "<br/>" +
        "<b>Sharath Bhagavatula</b><br/>" +
        "Graduated from Cornell University with a major in Electrical and Computer Engineering. He is currently a 4th year medical student " +
        "at NYU School of Medicine interested in radiology. Outside of the clinic, his academic interests include robotics, engineering " +
        "research, and making websites. Other interests include tennis, basketball, and watching TV.";


var collaborationText = "This site is a collaboration between UndergroundMed, a team of medical students, and <a href='#' onclick='openMeduWindow()'>MedU</a>, " +
    "a non-profit with a mission of advancing medical education through the innovative use of technology.  All site content was " +
    "written and produced by UndergroundMed; the web site is hosted and maintained through financial and technical support from MedU in support of UndergroundMed's " +
    "novel approach to teaching and building a community of student medical educators.";

var missionStatement ="Our ultimate goal is to eliminate the frustrating barriers that surrounds medical education and to make it more " +
    "accessible to all students by creating a site dedicated to the needs of the modern medical student.  Our videos are designed to be: fun, " +
    "interactive, practical, contextual, high-yield, and time sensitive, and we are always looking for new ways to improve on our work.  " +
    "The intent of our videos is not to teach every detail in existence, but to instead provide a contextual thinking framework that students" +
    " can use to build their medical knowledge.  Rest assured that factual correctness and quality are very important to us - as our videos " +
    "are checked for factual correctness by experienced and accomplished medical educators. " +
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