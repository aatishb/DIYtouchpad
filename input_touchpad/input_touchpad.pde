/**
* modified from wekinator example code
* processing sketch that sends Arduino data to wekinator
* This sends 6 input values to port 6448 using message /wek/inputs
**/

import processing.serial.*;

int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial myPort;  // Serial port you are using
float num;

//String[] list;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

PFont f;

void setup() {
  f = createFont("Courier", 16);
  textFont(f);

  size(640, 480, P2D);
  noStroke();
  smooth();
  
  String ports[] =  Serial.list();
  println("Set whichPort to be whichever port is connected to the Arduino");
  println("It should match with whatever is under Tools>Port in the Arduino IDE");
  
  for(int i=0; i<ports.length; i++){
    println(str(i) + ' ' + ports[i]);
  }
  println();
  
  int whichPort = 1; // set this to the number for the Arduino port
  
  myPort = new Serial(this, Serial.list()[whichPort], 250000);
  myPort.clear();
  
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,9000);
  dest = new NetAddress("127.0.0.1",6448);
  
}

void draw() {
  background(0);
  fill(255);
  text("Continuously sends serial input (6 numbers) to Wekinator\nUsing message /wek/inputs, to port 6448", 10, 30);

  while (myPort.available() > 0) {
    myString = myPort.readStringUntil(lf);
    if (myString != null) {
      
      String[] list = split(myString, ' ');

      //print(list);
      sendOsc(list);
      
    }
  }
  myPort.clear();

}

void sendOsc(String[] list) {
  OscMessage msg = new OscMessage("/wek/inputs");
  for(int i=0; i<list.length; i++){
    msg.add(float(list[i])); 
  }
  oscP5.send(msg, dest);
}