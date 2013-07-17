import oscP5.*;
import netP5.*;
import processing.serial.*;

OscP5 myOsc;
Serial arduinoSerial;

int myPort = 22244;
//String otherIP = "192.168.2.13";

float x = 0;
float y = 0;

void setup() {
  size(640, 480);
  smooth();
  noStroke();
  
  println(Serial.list());
  //arduinoSerial = new Serial(this, Serial.list()[0], 9600);
  
  myOsc = new OscP5(this, myPort);
  
}

void oscEvent(OscMessage msg) {
  
  String addr = msg.addrPattern();
  float val = msg.get(0).floatValue();
  
  if (addr.equals("a")) {
    x = val;
  }else if(addr.equals("b")) {
    y = val;
  }
  
  println(msg);
  
}

void draw() {

  background(0);
  ellipse(x*width,y*height,10,10);
  
}
