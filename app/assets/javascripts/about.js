var foundersText =
    "<b>Xinran (Leo) Liu</b><br/>Graduated from Cornell University with a major in Chemistry and Chemical Biology.  " +
        " He is currently a 4th year medical student at the Geisel School of Medicine trying to decide which specialty to go into.  " +
        "His interests outside of clinical practice include LEAN process improvement, entrepreneurship, and medical education.  " +
        "In his free time, he enjoys reading, ultimate frisbee, basketball, tennis, ping pong, golf, drawing, among numerous other random things." +
        "<br/>" +
        " <b>Whitney de Luna</b><br/>" +
        " Graduated from Stanford University with a major in biological sciences. She is currently a 4th year medical student interested " +
        "in anesthesiology. Outside of the clinic her academic interests include the use of technology for education and global health. " +
        "In her free time she enjoys traveling, cooking, playing tennis and golf." +
        "<br/>" +
        "<b>Sharath Bhagavatula</b><br/>" +
        "Graduated from Cornell University with a major in Electrical and Computer Engineering. He is currently a 4th year medical student " +
        "at NYU School of Medicine interested in radiology. Outside of the clinic, his academic interests include using technology to " +
        "advance medicine through research and education. Other interests include tennis, basketball, and Matlab.";

var collaborationText = "The site is a collaboration between UndergroundMed and MedU....." ;

var missionStatement = "Our ultimate goal is to create a site dedicated to the needs of the modern medical student. Our videos are " +
    "designed to be: fun, interactive, practical, contextual, high-yield, and time sensitive, and we are always looking for new ways to" +
    " improve on our work." +
    "<p/>" +
  "The intent of our videos is not to teach every detail in existence, but to instead provide a contextual thinking framework " +
    "that students can use to build their medical knowledge. Quality is also very important to us - as our videos are checked for " +
    "factual correctness by experienced and accomplished medical educators." +
    "<p/>" +
    "We are, and always intend to be, a student run organization - but one that also has support from nationally recognized " +
    "and accredited medical organizations." +
    "<p/>" +
    "If you would like to join us in our mission, please contact us! And please feel free to offer any advice or suggestions " +
    "on how we can improve your UndergroundMed experience!" ;

function aboutFounders() {
  showinfoDialog(foundersText, "Founders");
}

function aboutCollaboration() {
  showinfoDialog(collaborationText, "Collaboration");
}

function aboutMission() {
  showinfoDialog(missionStatement, "Our Mission");
}