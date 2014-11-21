// Quentin Bitran Cosmic Language// déchiffrage expérimentale des oscillations du champ magnétique de la comète Tchouri.

float cnt = 0;
import ddf.minim.*;
ParticleSystem ps;
float aX = 400;
float aY = 400;
float x=width/3;
float y=height/3;
float xchange=1;
float ychange=1;
int expirationTime = 3000;
long tagTime;
PFont font;
boolean showComete = false;
float f=0.1;
PImage img;
float comet=1;


Minim minim;
AudioPlayer song;

void setup() {
  background(0, 0, 0);
  size(800, 800);
  frameRate(360);
  smooth();
  minim = new Minim(this);
  ps = new ParticleSystem(new PVector(width/2, 5, 50));
  tagTime = millis();
  font = loadFont("OCRAStd-48.vlw");
  img = loadImage("screen-0040.jpg");
  
  
  
  // this loads mysong.wav from the data folder
  song = minim.loadFile("Rosetta_s Comet  Oscillations.mp3");
  song.play();
}

void stop() {
  song.close();
  minim.stop();
  
  super.stop();
}


void draw() {
  noStroke();
  
  fill(0, 0, 0, 80);
  rect(0, 0, width, height);
  fill(#E5E3E3,50);
  //image(img,0,0);
  //tint(255,comet);
  //comet+=0.1;
  textFont(font,15);
  long number = millis()*10000;
  text(str(number), 10, 20);
  text("Cosmic language\n67P/Chryomov-Gerasimenko\nesaoperations", 10, 40);
  
  
  
  pushMatrix();
  translate(width/2, height/2);

  rotate(radians(frameCount/2));
  for (float i = -280; i < 280; i++) {
    float x = i+random(sin(radians(i-frameCount)))*10;
    float y = sin(radians(i+frameCount))*10;
    float d = random(abs(map(x, -280, 280, -50, 50)));
    ellipse(x, y, d, d);
  }
  popMatrix();


  stroke(255);
  double vM, vN1, vN2, vN3;
  vM =random(10);
  vN1 =5;
  vN2 =random(6);
  vN3 = random(10);
  stroke(254, 254, 254);
  strokeWeight(1);
  drawSuperformula(400, 400, 15, 15, vM, vN1, vN2, vN3, 400, true);
  pushMatrix();
  translate(0, 400);
  ps.addParticle();
  ps.run();
  popMatrix();


  float r=random(60);
  if (r==1) {
    vM =random(50);
    vN1 =random(200);
    vN2 =random(10);
    vN3 = 100;
  }
  aX += random(-10, 10);
  aY += random(-10, 10);
  aX = constrain(aX, 0, width);
  aY = constrain(aY, 0, height);
  pushMatrix();
  translate(aX, aY);
  drawSuperformula(0, 0, 2, 2, vM, vN1, vN2, vN3, 400, false);
  popMatrix();


  vM =random(5);
  vN1 =random(20);
  vN2 =5;
  vN3 =90;
  pushMatrix();
  rotate(cnt);
  drawSuperformula(400, 400, 2, 2, vM, vN1, vN2, vN3, 400, false);
  cnt+=0.03;
  popMatrix();



  vM =random(50);
  vN1 =200;
  vN2 =5;
  vN3 =500;
  pushMatrix();
  rotate(cnt);
  drawSuperformula(400, 400, 2, 2, vM, vN1, vN2, vN3, 400, true);
  cnt+=0.1;
  popMatrix();



  if (millis() > tagTime+expirationTime) {
    showComete = true;  

    //tagTime = millis();
  }

  if (showComete) {
    pushMatrix(); 
    translate(400, 400); 
    vM =random(10);
    vN1 =5;
    vN2 =random(60);
    vN3 = random(500);
    drawSuperformula(600, 600, 15, 15, vM, vN1, vN2, vN3, 400,true);
    popMatrix();
  }

  vM =random(5);
  vN1 =10;
  vN2 =100;
  vN3 =500;
  pushMatrix();
  rotate(cnt);
  drawSuperformula(400, 400, 2, 2, vM, vN1, vN2, vN3, 400, false);
  cnt-=0.01;
  popMatrix();
}

void drawSuperformula(float centerX, float centerY, double valueA, double valueB, double valueM, double valueN1, double valueN2, double valueN3, int points, boolean l) {

  int prevx = Integer.MAX_VALUE;
  int prevy = Integer.MAX_VALUE;


  double twicePi = 2 * Math.PI;

  double NP = points;

  for (int i=0;i<=NP;i++) {
    double theta = i * twicePi / NP;
    int x, y;
    double r;
    double t1, t2;

    // double a=1,b=1;

    t1 = Math.cos(valueM * theta / 4) / valueA;
    t1 = Math.abs(t1);
    t1 = Math.pow(t1, valueN2);
    t2 = Math.sin(valueM * theta / 4) / valueB;
    t2 = Math.abs(t2);
    t2 = Math.pow(t2, valueN3);
    r = Math.pow(t1+t2, 1/valueN1);
    if (Math.abs(r) == 0) {
      x = 0;
      y = 0;
    }
    else {
      r = 1 / r;
      x = (int) (r * Math.cos(theta));
      y = (int) (r * Math.sin(theta));
    }

    if (prevx==Integer.MAX_VALUE) {
      prevx = x;
    }

    if (prevy==Integer.MAX_VALUE) {
      prevy = y;
    }

    if (l) {
      //stroke(153,153,0);
      line(prevx+centerX, prevy+centerY, 
      x+centerX, y+centerY);
      line(prevx+centerX, (-prevy)+centerY, 
      x+centerX, (-y)+centerY);
    }
    else {
      // fill(153,153,0);
      ellipse (x+centerX, y+centerY, 2, 2);
    }
    prevx=x;
    prevy=y;
  }
}
void keyReleased() {

  if (keyCode==32) {
    saveFrame();
    print("saved");
  }
}
// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}



// A simple Particle class

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.1);
    velocity = new PVector(random(-1, 1), random(-3, 0));
    location = l.get();
    lifespan = 850.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 0.61;
  }

  // Method to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(location.y, random(5), 5, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}

void mousePressed() {
  loop();  // Holding down the mouse activates looping
}

void mouseReleased() {
  noLoop();  // Releasing the mouse stops looping draw()
}

