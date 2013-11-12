/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float x = 0;
float y = 0;

void setup() {
  
  size(400, 400);
  frameRate(20);
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 22244);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 22243);
}


void draw() {
  background(0);
  
  // draw red ellipse from incoming values
  
  fill(255, 0, 0);
  ellipse(x * width, y * height, 10, 10);
  
  // send mouse position
  
  fill(255);
  ellipse(mouseX, mouseY, 10, 10);
  
  OscMessage myMessageX = new OscMessage("/test/mousex");
  OscMessage myMessageY = new OscMessage("/test/mousey");

  myMessageX.add(mouseX*1.0/width); /* add an int to the osc message */
  myMessageY.add(mouseY*1.0/height); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessageX, myRemoteLocation); 
  oscP5.send(myMessageY, myRemoteLocation);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage msg) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+msg.addrPattern());
  print(" typetag: "+msg.typetag());
  println(" val: "+msg.get(0).floatValue());

  String addr = msg.addrPattern();

  float val = msg.get(0).floatValue();

  if (addr.equals("/terrario/planta")) {
    x = val;
  }
  else if (addr.equals("/terrario/luz")) {
    y = val;
  }
  
}

