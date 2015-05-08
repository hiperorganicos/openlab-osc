import oscP5.*;
import netP5.*;

OscP5 osc_receiver;

int receiver_port = 22244;

float x = 0;
float y = 0;

void setup() {
  size(640, 480);
  smooth();
  noStroke();
  osc_receiver = new OscP5(this, receiver_port);
}

void oscEvent(OscMessage msg) {
  
  String addr = msg.addrPattern();
  float val = msg.get(0).floatValue();
  
  if (addr.equals("/terrario/planta")) {
    x = val;
  }else if(addr.equals("/terrario/luz")) {
    y = val;
  }

  println(msg);

}

void draw() {
  background(0);
  ellipse(x * width, y * height, 10, 10);
}
