void setup() {
  size(800, 800); 
  smooth();
  frameRate(1);
}

void draw() {
  background(0);
  noFill();

{
 /* for (float i=0; i<20; i++) {
    ellipse(width/2.0, height/2.0, 20*i, 20*i);
    //noStroke();
      blendMode(BLEND);
//fill(random(250),random(100));
    fill(158, 23, 48, 70);
  }
      //fill(19, 82, 69, 60);
  //fill(random(255),random(255),random(255), 60);
  //ellipse(width/2.0, height/2.0, 400, 400);*/
}
 for (float i=0; i<20; i++) {
    ellipse(width/2.0, 180+ i*12.0, 18*i, 18*i);
    noStroke();
    blendMode(BLEND);
  //fill(random(255),random(255),random(255), random(100));
    //fill(15,80,74, 80);
    fill(150, 28, 58, 90);
  }
  
  for (float j=0; j<20; j++) {
    ellipse(width/2.0, 620- j*12.0, 18*j, 18*j);
    noStroke();
//fill(random(255),random(255),random(255), random(120));
    //fill(150, 28, 58, 40);
    fill(15,80,84, 60);
  }

}


void keyReleased() {
  if (keyCode==32) {
    saveFrame();
    println("Sauvegardé!");
  }
} 

