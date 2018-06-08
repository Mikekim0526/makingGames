import processing.serial.*;


int xPos = 1;         // horizontal position of the graph
int lf = 10;
String myString = null;
float accX;
float preX;
Serial port;

void setup () {
  println("Available serial ports:");
  println(Serial.list());
  port = new Serial(this, "COM12", 9600);
  port.clear();

  myString = port.readStringUntil(lf); 
  myString = null;
  
  size(800, 600);
  background(0);
}

void draw () {
  float val= map(accX, 0,180 ,height,0);
  strokeWeight(3);
  stroke(127, 34, 255);
  //point(xPos, mouseY);
  //point(xPos, val);
  line(xPos, val, xPos, preX);
  println(val, preX);
  if (xPos >= width) {
    xPos = 0;
    background(0);
  } else {
    xPos++;
  }
  
  preX = val;
  delay(100);
}

void serialEvent(Serial port) { 
    myString = port.readStringUntil(lf);
    
    if (myString != null) { 
      try { 
        accX=Integer.parseInt(myString.trim()); 
      } 
      catch (NumberFormatException npe) { 
      }
    }
}
