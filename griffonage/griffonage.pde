// GRIFONNAGE + Éric Dugast + 21.11.2014
// sauvegarder en pdf
import processing.pdf.*;
boolean record = false;
// timer interval
final int WAIT_TIME = (int) (30.0 * 1000); // 30 seconds
int startTime;

// bordure des zones
int border = 24;

// ----- PREMIERE ZONE -----
// position de départ du premier point de la courbe
float x = 400;
float y = 300;
// position de départ du deuxième point da la courbe
float x1 = random(x-200, x+200);
float y1 = random(y-200, y+200);

// ----- SECONDE ZONE -----
// position de départ du premier point de la courbe
float x2 = 900;
float y2 = 400;
// position de départ du deuxième point da la courbe
float x3 = random(x2-200, x2+200);
float y3 = random(y2-200, y2+200);

void setup() {
  background(255);
  size(displayWidth, displayHeight);
  smooth();
  beginRecord(PDF, "high-###.pdf");
}

void draw() {
  stroke(0);
  fill(255);

  // ---------- 1ERE COURBE ---------
  // premier point la courbe
  x += random(-4, 4);
  y += random(-4, 4);
  x = constrain(x, border, (width/2)-(border/2));
  y = constrain(y, border, height-border);
  
  // second point de la courbe
  x1 += random(-4, 4);
  y1 += random(-4, 4);
  x1 = constrain(x1, border, (width/2)-(border/2));
  y1 = constrain(y1, border, height-border);

  // longueur entre les extrémités de la courbe
  float d = dist(x, y, x1, y1);
  // distance maximale possible
  float maxD = dist(0, 0, width/2, height);
  // courbe
  maCurve(x, y, x1, y1, d, maxD);

  // ---------- 2ND COURBE ---------
  // premier point de la courbe
  x2 += random(-4, 4);
  y2 += random(-4, 4);
  x2 = constrain(x2, (width/2)+(border/2), width-border);
  y2 = constrain(y2, border, height-border);
  
  // second point de la courbe
  x3 += random(-5, 5);
  y3 += random(-5, 5);
  x3 = constrain(x3, (width/2)+(border/2), width-border);
  y3 = constrain(y3, border, height-border);
  
  // longueur entre les extrémités de la courbe
  float d2 = dist(x1, y1, x2, y2);
  // courbe
  maCurve(x2, y2, x3, y3, d2, maxD);

  // enregistre l'image
  if (record) { 
    endRecord();
    record = false;
    saveFrame("low-###.png");
    println("Sauvegardé!"); 
    beginRecord(PDF, "high-###.pdf");
  }

  // enregistrement automatique selon interval
  if (hasFinished()) {
    endRecord();
    record = false;
    saveFrame("low-###.png");
    println("[sauvegarde] +" + WAIT_TIME/1e3 + "s"); 
    beginRecord(PDF, "high-###.pdf");
    startTime = millis();
  }
}

void maCurve(float pointX, float pointY, float pointX1, float pointY1, float d, float maxD){
  // milieu de la courbe
  float midX = (pointX+pointX1)/2;
  float midY = (pointY+pointY1)/2;
  // amplitude du point de control
  float belly = map(d, 0, maxD, 0.01, 0.05);
  beginShape();
  curveVertex(pointX, pointY);
  curveVertex(pointX, pointY);
  curveVertex(pointX1, pointY1);
  curveVertex(pointX-belly, pointY1+belly);
  endShape();
}

void keyReleased() {
  if (keyCode==32) {
    record = true;
    println("-----> Portion sauvegardée!");
  }
}

boolean hasFinished() {
  return millis() - startTime > WAIT_TIME;
}

/*boolean sketchFullScreen() {
  return true;
}*/
