import processing.serial.*;

int lf = 10;
String myString = null;
int msg;
Serial port;

int mx, my;
float x, y;
int ten,one;
boolean fired = true;
int cX, cY, cW, cH;

void setup () {
  println("Available serial ports:");
  println(Serial.list());
  port = new Serial(this, "COM3", 9600);
  port.clear();

  myString = port.readStringUntil(lf); 
  myString = null;
  
  size(800, 600);
  background(100,130,200);
  rectMode(CENTER);
  mx=width/2;
  my=height/2;
  x=0;
  y=0;
}

void draw () {
  translate(mx-x, my-y);
  background(100,130,200);
  if(fired){
    sky();
  }
  if(msg>50){
    x+=2;
    ten=50;
  } else if(msg>40){
    x++;
    ten=40;
  } else if(msg>30){
    x+=0;
    ten=30;
  } else if(msg>20){
    x-=1;
    ten=20;
  } else if(msg>10){
    x-=2;
    ten=10;
  }
  one = msg-ten;
  if(one==5){
    y+=2;
  } else if(one==4){
    y+=1;
  } else if(one==3){
    y+=0;
  } else if(one==2){
    y-=1;
  } else{
    y-=2;
  }
  
  if(x>mx ||x<-mx){
    x=0;
  }
  if(y>my ||y<-my){
    y=0;
  }
  fill(255,255);
  stroke(0);
  rect(x,y,40,30);
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

void sky(){
  c(0,0,100,60);
  c(80,40,50,30);
}

void c(int cX, int cY, int cW, int cH){
  fill(255,100);
  noStroke();
  ellipse(random(cX*3/4,cX*5/4),random(cY*3/4,cY*5/4),random(cW*3/4,cW*5/4),random(cH*3/4,cH*5/4));
  ellipse(random(cX*3/4,cX*5/4),random(cY*3/4,cY*5/4),random(cW*3/4,cW*5/4),random(cH*3/4,cH*5/4));
  ellipse(random(cX*3/4,cX*5/4),random(cY*3/4,cY*5/4),random(cW*3/4,cW*5/4),random(cH*3/4,cH*5/4));
  ellipse(random(cX*3/4,cX*5/4),random(cY*3/4,cY*5/4),random(cW*3/4,cW*5/4),random(cH*3/4,cH*5/4));
  ellipse(random(cX*3/4,cX*5/4),random(cY*3/4,cY*5/4),random(cW*3/4,cW*5/4),random(cH*3/4,cH*5/4));
}
void mouseClicked(){
  if(mouseButton==LEFT){
    fired = false;
  } else{
    fired = true;
  }
}
