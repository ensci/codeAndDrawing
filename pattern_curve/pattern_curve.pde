int nX =52;
int nY = 52;
float rot[] = new float[nX*nY];

void setup() {
  size(800, 800);
    frameRate(2);
  for (int i=0; i< rot.length; i++) rot[i] = 0;
  //blendMode(MULTIPLY);
  calculateRotation(rot);
}

void draw() {
  //  blendMode(SUBTRACT);
  background(255);
  
 
 {
  pushMatrix(); //pastilles rouges//
  translate(-width/2.0, -height/2.0);
  //float r = map(mouseY, 0,height, 0,TWO_PI);
  //rotate(-0.1);
  translate(width/2.0-200, height/2.0);
  fill(128,20);  
 
  for (int i=0; i<nX; i++) {
    for (int j=0; j<nY; j++) {
      pushMatrix();
      translate(i*80, j*80);
      rotate(rot[j*30+i]);
      //fill(240,12,34,220);
      
      stroke(240,12,34,220);
      strokeWeight(12);
      bezier(65, 20, 20, 20, 60, 40, 15, 60);
      popMatrix();
    }
  }
  popMatrix();
}
  
  pushMatrix(); // pastilles bleues//
  translate(-width/2.0, -height/2.0-60);
  rotate(0.05);
  translate(width/2.0, height/2.0); 

  for (int i=0; i<nX; i++) {
    for (int j=0; j<nY; j++) {
      pushMatrix();
      translate(i*70, j*70);

      //fill(20,25,55,230);
      stroke(20,25,55,230);
      rotate(rot[j*14+i]);

      strokeWeight(12);
      bezier(65, 20, 20, 20, 60, 70, 15, 60);
      popMatrix();
    }
  }
  popMatrix();
  
}

void calculateRotation(float l[]) {
  for (int i=0; i< l.length; i++) l[i] = random(0, 1);
}

void keyReleased() {
  if (keyCode==32) {
    saveFrame();
    println("sauvegardé!");
  }
}


