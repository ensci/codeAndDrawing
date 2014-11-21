//Fait par Hugo Moissinac
import processing.pdf.*;
import java.util.Calendar;

int formResolution = 20;//Nombre de points de contrôle
int stepSize =15;//Facteur de deformation
int nbLine = 60; //Nombre de lignes
float x1, x2, y1, y2;
float[] x = new float[formResolution];
float[] y = new float[formResolution];
boolean savePDF = false;
float strWt=0.5; // Largeur de ligne
int strk=150; // Couleur de ligne

void setup() {
  size(2400, 600);
  beginRecord(PDF, timestamp()+".pdf"); /* A modifier : 
  enregistre tous les tracés depuis l'ouverture du programme.*/
  background(250);
  strokeWeight(strWt);
  stroke(strk);
  noFill();
  noLoop();

}

void draw() {
}

void mousePressed() {
  println("mousePressed");
  pushMatrix();
  background(250);
  strWt=0.5;
  strk=150;
  initLine();
  blocLines();
  redraw();
  popMatrix();
}

//Calcul et dessine le bloc de ligne.
void blocLines() {
  if (savePDF) {
    savePDF = false;
    println("save as a pdf");
    endRecord();
  }
  for (int j=0; j<nbLine; j++) {
      strokeWeight(strWt);
        stroke(strk);
    //Tracer une courbe
    beginShape();
    curveVertex(x[0], y[0]);
    for (int i=0; i<formResolution; i++) {
      curveVertex(x[i]+j*8, y[i]);
    }
    curveVertex(x[formResolution-1], y[formResolution-1]);
    endShape();
    // Calculer la suivante : mouvement brownien
    for (int i=0; i<formResolution; i++) {
      x[i] += random(-stepSize, stepSize);
      y[i] += random(-stepSize, stepSize);
    }
    strWt+=0;
    if(strk>5)
    strk-=3;
    if(strk<100){
      strWt+=0.01;
    }
  }
}
//Entre les coordonées de la première ligne dans un tableau
void initLine() {
  x1=mouseX;
  x2=mouseX+1000;
  y1=mouseY;
  y2=mouseY;
  for (int i=0; i<formResolution; i++) {
    x[i] = lerp(x1, x2, i/(float)formResolution);
    y[i] = lerp(y1, y2, i/(float)formResolution);
  }
}

void keyReleased() {
  if (key == 'p' || key == 'P') savePDF = true;
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

