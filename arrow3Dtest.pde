int mx, my;
int x, y, z;
int cx, cy, cw, ch, cd;

boolean kbl, kbr, kbu, kbd;

PImage cloud, cloudy, rainy;

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
  
  cloudy= loadImage("cloud.jpg");
  rainy= loadImage("rainy.jpg");
}

void draw(){
  background(170,200,250);
  translate(mx-x,my-y,z+200);
  fill(255);
  
  sky();
  flyingObj();
  myself();
  
  z++;
}

void sky(){
  fill(100);
  stroke(0);
  cloud(0,0,40,20,2*z);
  
}

void flyingObj(){
  cloud(50,40,40,20,100);
  cloud(50,40,40,20,500);
  cloud(50,40,40,20,1000);
}

void cloud(int cx, int cy, int cw, int ch, int cd){
  fill(255,100);
  noStroke();
  beginShape();
  texture(cloud);
  vertex(cx+cw, cy-ch, z-cd, 0, 0);
  vertex(cx+cw, cy+ch, z-cd, 0, 1);
  vertex(cx-cw,cy+ch, z-cd, 1, 1);
  vertex(cx-cw, cy-ch, z-cd, 1, 0);
  endShape();
}

void myself(){
  fill(200,0,0);
  stroke(0);
  beginShape();  
  vertex(x+30,y,-z);
  vertex(x-30,y,-z);
  //vertex(x-30,y+20,-z);
  //vertex(x+30,y+20,-z);
  vertex(x-30,y+20,-z+200);
  vertex(x+30,y+20,-z+200);
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
