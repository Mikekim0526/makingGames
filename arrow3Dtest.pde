int mx, my;
int x, y, z;
int cx, cy, cw, ch;

boolean kbl, kbr, kbu, kbd;

PImage cloud;

void setup(){
  size(800,600,P3D);
  background(170,200,250);
  rectMode(CENTER);
  textureMode(NORMAL);
  mx=width/2;
  my=height*2/3;
  x=0;
  y=0;
  z=0;
  kbl=false;
  kbr=false;
  kbr=false;
  kbd=false;
  
  cloud= loadImage("cloud.jpg");
}

void draw(){
  background(170,200,250);
  translate(mx,my,z);
  fill(255);
  
  cloud(50,40,40,20);
  myself();
  
  z++;
}

void cloud(int cx, int cy, int cw, int ch){
  fill(255,100);
  noStroke();
  beginShape();
  texture(cloud);
  vertex(100, 70, z, 0, 0);
  vertex(100, 100, z, 0, 1);
  vertex(60, 100, z, 1, 1);
  vertex(60, 70, z, 1, 0);
  endShape();
}

void myself(){
  fill(200,0,0);
  stroke(0);
  beginShape();  
  vertex(x+30,y,-z);
  vertex(x-30,y,-z);
  vertex(x-30,y+30,-z);
  vertex(x+30,y+30,-z);
  endShape(CLOSE);
  
  if(kbl==true){
    x--;
  } else if(kbr==true){
    x++;
  }
  if(kbu==true){
    y--;
  } else if(kbd==true){
    y++;
  }
}

void keyPressed(){
  if(keyCode == LEFT){
    kbl=true;
  } else if(keyCode == RIGHT){
    kbr=true;
  }
  if(keyCode == UP){
    kbu=true;
  } else if(keyCode == DOWN){
    kbd=true;
  }
}

void keyReleased(){
  if(keyCode == LEFT){
      kbl = false;
    }
    if(keyCode == DOWN){
      kbd=false;
    }
    if(keyCode == RIGHT){
      kbr = false;
    }
    if(keyCode == UP){
      kbu = false;
    }
}
