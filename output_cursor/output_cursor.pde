//This demo allows wekinator to control background color (hue)
//This is a continuous value between 0 and 1

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;

//Parameters of sketch
float myX, myY;
PFont myFont;

void setup() {
  //Initialize OSC communication
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  
  colorMode(HSB);
  size(480,480, P3D);
  smooth();
  background(255);

  //Initialize appearance
  myX = 0;
  myY = 0;
  sendOscNames();
  myFont = createFont("Arial", 14);
}

void draw() {

  background(0);
  fill(255,50);
  pushMatrix();
  translate(width*0.5, height*0.5);
  rotate(PI/4);
  polygon(0,0,200,4);
  popMatrix();
  drawtext();

  fill(255);
  ellipse(myX,myY,20,20);
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("ff")) { 
       // looking for 2 float value
        float receivedX = theOscMessage.get(0).floatValue();
        myX = map(receivedX, 0, 1, 0, width);
        float receivedY = theOscMessage.get(1).floatValue();
        myY = map(receivedY, 0, 1, 0, height);
     } else {
        println("Error: unexpected OSC message received by Processing: ");
        theOscMessage.print();
      }
 }
}

//Sends current parameter (hue) to Wekinator
void sendOscNames() {
  OscMessage msg = new OscMessage("/wekinator/control/setOutputNames");
  msg.add("x"); //Now send all 5 names
  msg.add("y"); //Now send all 5 names
  oscP5.send(msg, dest);
}

//Write instructions to screen.
void drawtext() {
    stroke(0);
    textFont(myFont);
    textAlign(LEFT, TOP); 
    fill(0, 0, 255);
    text("Receiving 2 continuous parameters: x,y in range 0-1", 10, 10);
    text("Listening for /wek/outputs on port 12000", 10, 40);
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}