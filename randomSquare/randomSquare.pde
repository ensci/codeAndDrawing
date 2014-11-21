// Tristan Filhol, ensci les ateliers, gpl 2014

import processing.pdf.*;

boolean record = false;


void setup() {
  size(800, 800);
  //noLoop();
  smooth();
}

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void draw() {
  
   if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }
  
  int space = 20; // espace entre les carrés
  int size = 400;
  int posX = 200;
  int posY = 200;

  background(255);
  noFill();
  for (int i=1; i<=9; i++) {
    rectA(posX+i*space, posY+i*space, size-i*space*2, size-i*space*2);
  }
  
  if (record) {
    endRecord();
    record = false;
    println("pdf saved!");
  }

}

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void rectA(int x, int y, int w, int h) { // w->largeur h->hauteur

  int precision = 20; // espace entre les points (mofifie toutes les valeurs par la suite)


  float px = 0; //(previousX = 0) le X précédent
  float py = 0; //(previousY = 0) le Y précédent

  // 1) Horizontal haut --------------------------------------------------------------------

  for (int i=x; i<= (x+w); i+=precision) {
    
    
    
    int a = int(random(3));       // aléatoire des points :
    int b = 0;                    // le point a une chance sur 4 de prendre
                                  //  une valeur de -2 à 2
    if (a==0) {                   // 
      b = int(random(-2,2));      //    
    }
    // -------------------------- 2ème aléatoire
    int a1 = int(random(2));
    int b1 = 0;
    
    if (a1==0) {
      b1 = int(random(-2,2));
    }
    // -------------------------- 3ème aléatoire
    float b2 = random(-1.1,1.1);
    

    //tracer la ligne qui relie les points entre eux 
    if (i>x) {
      line(i, y+b+b1+b2, px, py);
    }

    //tracer les points 
    //ellipse(i, y+b+b1+b2, 1, 1);
    px = i;
    py = y+b+b1+b2;
  }

  // 2) Horizontal bas ----------------------------------------------------------------------    

  for (int i=x; i<= (x+w); i+=precision) {
   
   int a = int(random(3));       // aléatoire des points :
   int b = 0;                    // le point a une chance sur 4 de prendre
                                 //  une valeur de -3 à 3
   if (a==0) {                   // 
     b = int(random(-2,2));      // 
   }
   // -------------------------- 2ème aléatoire
   int a1 = int(random(2));
   int b1 = 0;
    
   if (a1==0) {
     b1 = int(random(-2,2));
   }
    // -------------------------- 3ème aléatoire
    float b2 = random(-1.1,1.1);
   

    //tracer la ligne qui relie les points entre eux 
    if (i>x) {
      line(i, y+h+b+b1+b2, px, py+h);
    }

    //tracer les points 
    //ellipse(i, y+h+b+b1+b2, 1, 1);       
    px = i;
    py = y+b+b1+b2;
  }



  // 3) Vertical gauche ----------------------------------------------------------------------

  for (int i=y; i<= (y+h); i+=precision) {
   
   int a = int(random(3));       // aléatoire des points :
   int b = 0;                    // le point a une chance sur 4 de prendre
                                 //  une valeur de -3 à 3
   if (a==0) {                   // 
     b = int(random(-2,2));      // 
   }
   // -------------------------- 2ème aléatoire
   int a1 = int(random(2));
   int b1 = 0;
    
   if (a1==0) {
     b1 = int(random(-2,2));
   }
    // -------------------------- 3ème aléatoire
    float b2 = random(-1.1,1.1);

    //tracer la ligne qui relie les points entre eux 
    if (i>y) {
      line(x+b+b1+b2, i, px, py );
    }

    //tracer les points 
    //ellipse(x+b+b1+b2, i, 1, 1);
    px = x+b+b1+b2;
    py = i;
  }


  // 4) Vertical droite ----------------------------------------------------------------------

  for (int i=y; i<= (y+h); i+=precision) {
   
   int a = int(random(3));       // aléatoire des points :
   int b = 0;                    // le point a une chance sur 4 de prendre
                                 //  une valeur de -3 à 3
   if (a==0) {                   // 
     b = int(random(-2,2));      // 
   }
   // -------------------------- 2ème aléatoire
   int a1 = int(random(2));
   int b1 = 0;
    
   if (a1==0) {
     b1 = int(random(-2,2));
   }
   // -------------------------- 3ème aléatoire
   float b2 = random(-1.1,1.1);
   
   
    //tracer la ligne qui relie les points entre eux      
    if (i>y) {
      line(x+w+b+b1+b2, i, px+w, py);
    }

    //tracer les points
    //ellipse (x+w+b+b1+b2, i, 1, 1);
    px = x+b+b1+b2;
    py = i;
  }
    
}

void keyReleased() {
  if (keyCode==32) {
    saveFrame();
    record = true;
    println("bitmap saved!");
  }
}






