int mx, my;
float x, y, z, speed;
float X, Y;

float cx, cy, cw, ch, cd, cr;

boolean kbl, kbr, kbu, kbd;

PImage sky, cloud, cloudy, rainy, building, tower, missile, man;


void setup() {
  size(800, 600, P3D);
  background(170, 200, 250);
  rectMode(CENTER);
  textureMode(NORMAL);
  mx=width/2;
  my=height*2/3;
  x=0;
  y=0;
  z=0;
  speed=20;
  kbl=false;
  kbr=false;
  kbr=false;
  kbd=false;

  cloudy= loadImage("cloud.jpg");
  rainy= loadImage("rainy.jpg");
  tower= loadImage("tower.jpg");
  missile= loadImage("missile.jpg");
  sky = loadImage("sky.jpg");
  man = loadImage("man.jpg");
}

void draw() {
  background(170, 200, 250);
  X=mx-x;
  Y=my-y;
  translate(X, Y, 200);
  lights();
  fill(255);

  sky();
  //flyingObj();
  myself();
  missile();
  Dcloud(-50, Y, z-600, 50);


  z+=speed;
  speed+=0.001;

  //print(speed);
  //print("   ");
  //println(z);
}

void sky() {
  fill(255);
  stroke(0);
  beginShape();
  texture(sky);
  vertex(-12*mx, -12*my, -4800, 0, 0);
  vertex(-12*mx, 12*my, -4800, 0, 1);
  vertex(12*mx, 12*my, -4800, 1, 1);
  vertex(12*mx, -12*my, -4800, 1, 0);
  endShape(CLOSE);
  cloud(0, 0, 40, 20, z, rainy);
  building(tower, 0, 0, 400, 720, 5200-z);

  fill(130, 20);
  for (int j=-100; j<=300; j+=100) {
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
  cloud(50, 40, 40, 20, 100, cloudy);
  cloud(50, 40, 40, 20, 500, rainy);
  cloud(50, 40, 40, 60, 1000, missile);
  Dcloud(-50, 40, 600, 50);
}

void missile() {
  fill(200,0,0);
  stroke(100, 0, 0, 40);
  translate(50, 40, z-1000);
  drawCylinder(30, 0, 150, 20);
}

void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
  float angle = 0;
  float angleIncrement = TWO_PI / sides;
  beginShape(QUAD_STRIP);
  rotateX(PI/2);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape();

  // If it is not a cone, draw the circular top cap
  if (topRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);

    // Center point
    vertex(0, 0, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }
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

void Dcloud(float cx, float cy, float cd, float cr) {
  fill(100);
  noStroke();
  pushMatrix();
  translate(random(cx, cx+5), random(cy, cy+5), z-cd);
  sphere(cr);
  popMatrix();
}
void building(PImage building, float cx, float cy, float cw, float ch, float cd) {
  fill(255, 0);
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
  fill(200,0);
  noStroke();
  directionalLight(200,200,200,0,200,20);

  if (kbl==true) {
    x-=3;
  } else if (kbr==true) {
    x+=3;
  }
  if (kbu==true) {
    y-=3;
  } else if (kbd==true) {
    y+=3;
  }
  x=constrain(x, -1.5*mx, 1.5*mx);
  y=constrain(y, -my, my);

  beginShape();
  texture(man);
  vertex(x+30, y, 0, 1, 0);
  vertex(x-30, y, 0, 0, 0);
  //vertex(x-30,y+20,-z);
  //vertex(x+30,y+20,-z);
  vertex(x-30, y+20, 200, 0, 1);
  vertex(x+30, y+20, 200, 1, 1);
  endShape(CLOSE);
}

void keyPressed() {
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
}

void mouseClicked() {
  z=0;
  speed=2;
  x=0;
  y=0;
}
