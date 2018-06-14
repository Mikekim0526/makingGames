import processing.serial.*;

int lf=10;
String myString = null;
int msg;
int ten, one;
Serial port;

int mx, my;
float x, y, z, speed, rate;
float px, py;
float X, Y;
int r, g, b, t, dt, pt;

float cx, cy, cw, ch, cd, cr, fin;

boolean kbl, kbr, kbu, kbd, playing;

PImage sky, cloud, cloudy, rainy, building, tower, missile, man, life, ending;


void setup() {
  smooth();
  size(1200, 900, P3D);
  background(170, 200, 250);
  rectMode(CENTER);
  textureMode(NORMAL);
  mx=width/2;
  my=height*2/3;
  x=0;
  y=0;
  z=0;
  speed=30;
  rate=0.5;
  kbl=false;
  kbr=false;
  kbr=false;
  kbd=false;
  playing=true;
  fin=10000;

  r=220;
  g=220;
  b=220;
  t=0;
  dt=1;

  cloudy= loadImage("cloud.jpg");
  rainy= loadImage("rainy.jpg");
  tower= loadImage("tower.jpg");
  missile= loadImage("missile.jpg");
  sky = loadImage("sky.jpg");
  man = loadImage("man.jpg");
  life = loadImage("life.jpg");
  ending = loadImage("ending.jpg");
  port = new Serial(this, "COM13", 9600);
  port.clear();

  myString = port.readStringUntil(lf);
  myString = null;
}

void draw() {
  background(170, 200, 250);
  X=mx-x;
  Y=my-y;
  translate(X, Y, 200);
  lights();
  fill(255);

  if (playing==true) {
    sky();
    flyingObj();
    myself();
  }
  
  z+=speed;
  speed+=rate;

  px=x;
  py=y;

  if (z>3*fin) {
    ending();
    playing=false;
  }
}

void sky() {
  fill(r, g, b);
  stroke(0);
  beginShape();
  texture(sky);
  vertex(-12*mx, -12*my, -4800, 0, 0);
  vertex(-12*mx, 12*my, -4800, 0, 1);
  vertex(12*mx, 12*my, -4800, 1, 1);
  vertex(12*mx, -12*my, -4800, 1, 0);
  endShape(CLOSE);
  //cloud(0, 0, 40, 20, z, rainy);
  building(tower, 0, 0, mx, my*1.8, fin-z/3);
  fill(130, 20);
  for (int j=-100; j<=900; j+=150) {
    for (int i=-200; i<3*mx-100; i+=100) {
      pushMatrix();
      translate(i-mx, my+50, -j);
      sphere(50);
      popMatrix();
      pushMatrix();
      translate(i-mx, -my-50, -j);
      sphere(50);
      popMatrix();
    }
    for (int k=-my-50; k<my+50; k+=100) {
      pushMatrix();
      translate(-1.5*mx, k, -j);
      sphere(50);
      popMatrix();
      pushMatrix();
      translate(1.5*mx, k, -j);
      sphere(50);
      popMatrix();
    }
  }
}

void flyingObj() {
  missile(0, 0, 4800);
  missile(0, 0, 9000);
  obstacle(-100, 4, 5000);
}

void missile(int cx, int cy, int cd) {
  fill(200, 0, 0);
  stroke(100, 0, 0, 40);
  pushMatrix();
  translate(cx, cy, z-cd);
  drawCylinder(mx*0.2, 0, mx*0.8, 16);
  translate(cx, cy, -mx*1.2);
  fill(150);
  drawCylinder(mx*0.15, mx*0.15, mx*1.2, 8);
  popMatrix();

  pushMatrix();
  //translate(X, Y, z);
  if (z-cd<=speed && z-cd>=-speed && dist(0, 0, X-mx, Y-my)<mx*0.28) {
    speed=0;
    r=120;
    g=20;
    b=20;
    y+=random(3, 7);
    dt=0;
  }
  popMatrix();
}

void obstacle(int cx, int ch, int cd) {
  fill(120);
  stroke(100);
  beginShape();
  vertex(cx-mx/2, 2*my, z-cd);
  vertex(cx+mx/2, 2*my, z-cd);
  vertex(cx+mx/2, my-ch*my/2, z-cd);
  vertex(cx-mx/2, my-ch*my/2, z-cd);
  endShape(CLOSE);

  pushMatrix();
  translate(X, Y, z);
  if (z-cd<=speed && z-cd>=-speed) {
    if (X-mx/2+cx>=0 && X-mx/2+cx<=mx && ch*my/4>=Y-my) {
      speed=0;
      r=20;
      g=20;
      b=20;
      y+=random(3, 7);
      dt=0;
    }
  }
  popMatrix();
}

void cloud(float cx, float cy, float cw, float ch, float cd, PImage cloud) {
  fill(255, 100);
  noStroke();
  beginShape();
  texture(cloud);
  vertex(cx+cw, cy-ch, z-cd, 0, 0);
  vertex(cx+cw, cy+ch, z-cd, 0, 1);
  vertex(cx-cw, cy+ch, z-cd, 1, 1);
  vertex(cx-cw, cy-ch, z-cd, 1, 0);
  endShape(CLOSE);
}

void building(PImage building, float cx, float cy, float cw, float ch, float cd) {
  fill(255);
  noStroke();
  beginShape();
  texture(building);
  vertex(cx+cw, cy-ch, -cd, 0, 0);
  vertex(cx+cw, cy+ch, -cd, 0, 1);
  vertex(cx-cw, cy+ch, -cd, 1, 1);
  vertex(cx-cw, cy-ch, -cd, 1, 0);
  endShape(CLOSE);
}

void myself() {
  fill(200, 0);
  noStroke();
  directionalLight(200, 200, 200, 0, 10, 1);

  if (msg>50) {
    x+=mx/80;
    ten=50;
  } else if (msg>40) {
    x=mx/200;
    ten=40;
  } else if (msg>30) {
    x+=0;
    ten=30;
  } else if (msg>20) {
    x-=mx/200;
    ten=20;
  } else if (msg>10) {
    x-=mx/80;
    ten=10;
  }
  one = msg-ten;
  if (one==5) {
    y+=my/80;
  } else if (one==4) {
    y+=my/200;
  } else if (one==3) {
    y+=0;
  } else if (one==2) {
    y-=my/200;
  } else {
    y-=my/80;
  }


  if (kbl==true) {
    x-=10;
  } else if (kbr==true) {
    x+=10;
  }
  if (kbu==true) {
    y-=10;
  } else if (kbd==true) {
    y+=10;
  }
  x=constrain(x, -1.5*mx+50, 1.5*mx-50);
  y=constrain(y, -my, my);

  if (abs(x-px)>mx/80 || abs(y-py)>my/80) {
    x=px;
    y=py;
  }

  beginShape();
  fill(r, g, b);
  texture(man);
  vertex(x+mx/10, y-my/20, 0, 1, 0);
  vertex(x-mx/10, y-my/20, 0, 0, 0);
  vertex(x-mx/10, y+my/10, my*2/3, 0, 1);
  vertex(x+mx/10, y+my/10, my*2/3, 1, 1);
  endShape(CLOSE);

  println(t, dt, pt);
  t+=dt;
  if (t>=20 || t<=0) {
    dt=-dt;
  }
  if (t>pt) {
    beginShape();
    fill(255);
    texture(life);
    vertex(x-mx/2, y-my/20, 0, 1, 0);
    vertex(x-mx/12-mx/2, y-my/20, 0, 0, 0);
    vertex(x-mx/12-mx/2, y+my/20, 0, 0, 1);
    vertex(x-mx/2, y+my/20, 0, 1, 1);
    endShape(CLOSE);
  }
  pt=t;
}

void ending() {
  fill(255);
  stroke(0);
  beginShape();
  texture(ending);
  vertex(-10*mx, -10*my, -4800, 0, 0);
  vertex(-10*mx, 10*my, -4800, 0, 1);
  vertex(10*mx, 10*my, -4800, 1, 1);
  vertex(10*mx, -10*my, -4800, 1, 0);
  endShape(CLOSE);
}

void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
  float angle = 0;
  float angleIncrement = TWO_PI / sides;
  pushMatrix();
  beginShape(QUAD_STRIP);
  rotateX(PI/2);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape();
  popMatrix();

  if (topRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);
    vertex(0, 0, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }
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

/* void keyPressed() {
 if (keyCode == LEFT) {
 kbl=true;
 } else if (keyCode == RIGHT) {
 kbr=true;
 }
 if (keyCode == UP) {
 kbu=true;
 } else if (keyCode == DOWN) {
 kbd=true;
 }
 }
 
 void keyReleased() {
 if (keyCode == LEFT) {
 kbl = false;
 }
 if (keyCode == DOWN) {
 kbd=false;
 }
 if (keyCode == RIGHT) {
 kbr = false;
 }
 if (keyCode == UP) {
 kbu = false;
 }
 if (keyCode == 'R') {
 z=0;
 }
 } */

void mouseClicked() {
  z=0;
  speed=30;
  x=0;
  y=0;
  r=200;
  g=200;
  b=200;
}
