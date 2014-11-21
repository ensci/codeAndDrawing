  //Paramétrage du bloc "général"-------------------------------------------------------------------------------------------------------------------------------------------------

import processing.pdf.*; //Début de l'enregistrement en .pdf
import java.util.Vector;
boolean record = false; //Datatype for the Boolean values true and false. It is common to use boolean values with control statements to determine the flow of a program.
                        //The first time a variable is written, it must be declared with a statement expressing its datatype.

Polygon selector = new Polygon(); //Polygone de sélection

float spiralPointsX[] = new float[629]; //Nombre de points qui dessinent la spirale pris en compte par le polygone de sélection
float spiralPointsY[] = new float[629];


  //Paramétrage du bloc de "fond" avec dessin de l'ellipse-------------------------------------------------------------------------------------------------------------------------------------------------

void setup() { 
  size(800, 800); //Réglage dimension plan de travail
  smooth(); //Traitement appliqué pour un trait plus doux 

  int x = 0; //Données de x
  int y = 0; //Données de y
  float px = 0; //Données du x précedent, le zéro est pris en compte
  float py= 0; //Données du y précedent
  float r = 50; //Rayon
  for (float t=0; t<TWO_PI; t+=0.6) {
    float ax = x + r*cos(t); //Formule de l'ellipse wikipedia {x = u + a cos t - avec t appartient à R
    float ay = y + r*sin(t); //                               {y = v + b sin t
    stroke(5, 5, 5); //Trait de contour gris sombre partiellement transparent
    fill (255, 255, 255); //Remplissage de l'ellipse
    ellipse (ax, ay, 3, 1); //Dimension de l'ellipse
    selector.addPoint(ax, ay); //
    if (t> 0.0) {
      stroke(200, 200, 200);
      line(ax, ay, px, py);
    }


    px = ax;
    py = ay;
  }


  spirale(0.5);
}


  //Paramétrage du bloc "dessin"--------------------------------------------------------------------------------------------------------------------------------------------------

void draw() {

  if (record) {
    beginRecord(PDF, "frame-####.pdf"); //Sous bloc d'enregistrement en .pdf
  }

  background(255); //Couleur de fond
  
  
  //Déformation de la spirale-------------------------------------------------------------------------------------------------------------------------------------------------

  for (int i=1; i< spiralPointsX.length; i++) {
    line(spiralPointsX[i], spiralPointsY[i], spiralPointsX[i-1], spiralPointsY[i-1]);
    if (selector.isInside(spiralPointsX[i], spiralPointsY[i])) {
      fill(255, 0, 0);
      ellipse( spiralPointsX[i], spiralPointsY[i], 4, 4); //Les points sélectionnés apparaissent par une spirale rouge (fill(255,0,0);)
      spiralPointsX[i]+=random(-2,2); //On reprend les coordonnées de la spirale (voir "paramétrage bloc spirale")
      spiralPointsY[i]+=random(-2,2); //On applique à chaque point compris dans la zone de sélection du polygone une amplitude aléatoire de déplacement
    }
  }


  //Dessin de sélection ----------------------------------------------------------------------------------------------------------------------------------------------------------
  
  int cnt = 0; //Nom d'une nouvelle variable
  float r = 50.0;
  for (float t=0; t<TWO_PI; t+=0.6) {
    float ax = mouseX + r*cos(t);
    float ay = mouseY + r*sin(t);
    selector.setX(cnt, ax);
    selector.setY(cnt, ay);

    if (t>0.0) {
      line(selector.getX(cnt), selector.getY(cnt), selector.getX(cnt-1), selector.getY(cnt-1));
    }

    cnt++; //On rajoute +1 à chaque variable nommée "cnt"
  }
  line(selector.getX(0), selector.getY(0), selector.getX(selector.getSize()-1), selector.getY(selector.getSize()-1));


  //Fin enregistrement en .pdf----------------------------------------------------------------------------------------------------------------------------------------------------
  
  if (record) {
    endRecord();
    record = false;
    println("pdf saved!");
  }
}

void keyReleased() {
  if (keyCode==32) { //Numéro de la touche "espace"
    saveFrame();
    record = true;
    println("bitmap saved!"); //Si on appuie sur la touche "espace", l'aperçue est enregistré en .pdf et .tiff
  }
} 

  //Paramétrage du bloc "spirale"----------------------------------------------------------------------------------------------------------------------------------------------------
void spirale(float pas) {
  float r1 = 10;
  float r2 = 30;
  float px = 0;
  float py= 0;
  float transparence = 0.0;
  int nPoint = 0;
  for (float t=0; t<TWO_PI*50; t+=pas) {
    float x = width/2 + r1*cos(t);
    float y = height/2 + r2*sin(t); 
    r1+=0.5;
    r2+=0.5;

    spiralPointsX[nPoint] = x;
    spiralPointsY[nPoint] = y;

    px = x;
    py = y;

    nPoint++;
  }
}

