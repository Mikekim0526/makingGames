import processing.serial.*;


int xPos = 1;         // horizontal position of the graph
int lf = 10;
String myString = null;
int msg;
int pre;
Serial port;

void setup () {
  println("Available serial ports:");
  println(Serial.list());
  port = new Serial(this, "COM3", 9600);
  port.clear();

  myString = port.readStringUntil(lf); 
  myString = null;
  
  size(800, 600);
  background(0);
}

void draw () {
  float val= map(msg, 0,56 ,height,0);
  strokeWeight(3);
  stroke(127, 34, 255);
  //point(xPos, mouseY);
  //point(xPos, val);
  line(xPos, val, xPos, height);
  println(val, pre);
  if (xPos >= width) {
    xPos = 0;
    background(0);
  } else {
    xPos++;
  }
  
  pre = msg;
  delay(100);
}

void serialEvent(Serial port) { 
    myString = port.readStringUntil(lf);
    
    if (myString != null) { 
      try { 
        msg=Integer.parseInt(myString.trim()); 
      } 
      catch (NumberFormatException npe) { 
      }
    }
}
