int mx, my;
int x, y, z;
int cx, cy, cw, ch, cd;

boolean kbl, kbr, kbu, kbd;

PImage cloud, cloudy, rainy, building, tower;

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
  tower= loadImage("tower.jpg");
}

void draw(){
  background(170,200,250);
  translate(mx-x,my-y,200);
  fill(255);
  
  sky();
  flyingObj();
  myself();
  
  z++;
}

void sky(){
  fill(100);
  stroke(0);
  cloud(0,0,40,20, z, rainy);
  building(tower, -250, 200, 160, 320, 1000);
  
}

void flyingObj(){
  cloud(50,40,40,20,100, cloudy);
  cloud(50,40,40,20,500, rainy);
  cloud(50,40,40,20,1000, cloudy);
}

void cloud(int cx, int cy, int cw, int ch, int cd, PImage cloud){
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

void building(PImage building, int cx, int cy, int cw, int ch, int cd){
  fill(85);
  noStroke();
  beginShape();
  texture(building);
  vertex(cx+cw, cy-ch, -cd, 0, 0);
  vertex(cx+cw, cy+ch, -cd, 0, 1);
  vertex(cx-cw,cy+ch, -cd, 1, 1);
  vertex(cx-cw, cy-ch, -cd, 1, 0);
  endShape();
}

void myself(){
  fill(200,0,0);
  stroke(0);
  beginShape();
  vertex(x+30,y,0);
  vertex(x-30,y,0);
  //vertex(x-30,y+20,-z);
  //vertex(x+30,y+20,-z);
  vertex(x-30,y+20,200);
  vertex(x+30,y+20,200);
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
