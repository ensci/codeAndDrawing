// Tristan Filhol, ensci les ateliers, gpl 2014

import processing.pdf.*;

boolean record = false;           //false : ça mouline

Form form[] = new Form[25];       // 
int cnt=0;                        //compteur de frame = 0
int selection = 0;

int selectionList[] = {
  -1, -1
};

// -----------------------------------------------------------------------------------

void setup() {

  size(1100, 750);
  //noLoop();

  for (int i=0; i<5; i++) {
    for (int j=0; j<5; j++) {
      form[j*5+i] = new Form(120*i+260, 120*j+85);
    }
  }


  for (int i=0; i<selectionList.length; i++) selectionList[i] = -1;

  selection = int(random(0, 26));
  stroke(255, 0, 0);
  //frameRate(25);
}

// -----------------------------------------------------------------------------------

void draw() {



  if (record) {
    beginRecord(PDF, "frame-####.pdf");
  }

  background(255);
  
//           [] [] [] [] []
//           [] [] [] [] []
//           [] [] [] [] []
//           [] [] [] [] []
//           [] [] [] [] []

// on dessine les 25 traits  
  for (int i=0; i<5; i++) {
    for (int j=0; j<5; j++) {

      if (selectionList[0]==(j*5+i) || (selectionList[1]==(j*5+i))) {
        form[j*5+i].drawForm(true);
      } else {
        form[j*5+i].drawForm(false);
      }
// quand on utilise la souris, on peut stopper une des 25 images (en plus de celle arrêtée aléatoirement)
      if (mousePressed) {                   
        if (isTouch(mouseX, mouseY, i*120+260, j*120+85, 120, 120)) {
          selectionList[1]= j*5+i;
        }
      }
    }
  }


// dégradé 
  noStroke();
  fill(255, 60);
  rect(0, 750-545, width, 665);
  rect(0, 750-425, width, 545);
  rect(0, 750-315, width, 425);
  rect(0, 750-195, width, 305);

// compteur de frame : l'image est mémorisée pendant 50 à 200 frame
  if (cnt<int(random(50, 200))) {
    cnt++;
  } else {
    cnt = 0; 

// un des 25 traits est choisi aléatoirement pour être mémorisé et arrêté
    selectionList[0] = int(random(0, 26));
    selectionList[1] = -1;
  }


  if (record) {                   // PDF
    endRecord();
    record = false;
    println("pdf saved!");
  }
}

// -----------------------------------------------------------------------------------



boolean isTouch(int x, int y, int rx, int ry, int w, int h) {
  if ((x>rx) && (x<rx+w) && (y>ry) && (y<ry+h)) {
    return true;
  } else {
    return false;
  }
}


void keyReleased() {                   // PDF

  if (keyCode==32) {
    saveFrame();
    record = true;
    println("bitmap saved!");
  }
}

// -----------------------------------------------------------------------------------

class Form {



  int a1, a2, b1, b2, c1, c2, d1, d2, e1, e2, f1, f2;
  int x, y;

  Form(int x, int y) {

    this.x = x;
    this.y = y;

    a1 = getValue(x);
    a2 = getValue(y);

    b1 = getValue(x);
    b2 = getValue(y);

    c1 = getValue(x);
    c2 = getValue(y);

    d1 = getValue(x);
    d2 = getValue(y);

    e1 = getValue(x);
    e2 = getValue(y);

    f1 = getValue(x);
    f2 = getValue(y);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  void drawForm(boolean stop) {



    if (stop==false) {
      a1 = getValue(x);
      a2 = getValue(y);

      b1 = getValue(x);
      b2 = getValue(y);

      c1 = getValue(x);
      c2 = getValue(y);

      d1 = getValue(x);
      d2 = getValue(y);

      e1 = getValue(x);
      e2 = getValue(y);

      f1 = getValue(x);
      f2 = getValue(y);
    }
    stroke(0);
    line(a1, a2, b1, b2);
    line(b1, b2, c1, c2);
    line(c1, c2, d1, d2);
    line(d1, d2, e1, e2);
    line(e1, e2, f1, f2);
  }

  int getValue(int v) {
    return int(random(v, v+95));
  }
}
