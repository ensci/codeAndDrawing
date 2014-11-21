/*code Paul appert. Plein de bisous. ensci 2014 */





import processing.pdf.*;
boolean record = false;
  int nPas = 50;
  int nPas2 = 3;
  
   int la1x = 300;
  int la1y = 200;

  
  int L = 558;  //685
  int l = 561;
  

Courbe left; 
Courbe2 middle;
Courbe right;

Courbe3 up;
Courbe4 middle2;
Courbe3 down;

void setup () {
  size(1800, 1000);
 
  left = new Courbe(la1x, la1y, la1x, la1y+l*1/3, la1x, la1y+l*2/3, la1x, la1y+l);
  middle = new Courbe2(la1x+(L*1/2), la1y, la1x+(L*1/2), la1y+(l*1/3), la1x+(L*1/2), la1y+(l*2/3), la1x+(L*1/2), la1y+(l*3/3));  
  //middle1 = new Courbe2(la1x+(L*2/3), la1y, la1x+(L*2/3), la1y+(l*1/3), la1x+(L*2/3), la1y+(l*2/3), la1x+(L*2/3), la1y+(l*3/3));
  right = new Courbe(la1x+L, la1y, la1x+L, la1y+(l*1/3), la1x+L, la1y+(l*2/3), la1x+L, la1y+(l*3/3));

  up =  new Courbe3(la1x, la1y, la1x+L*1/3, la1y, la1x+L*2/3, la1y, la1x+L, la1y);
  middle2 = new Courbe4(la1x, la1y+l*1/2, la1x+L*1/3, la1y+l*1/2, la1x+L*2/3, la1y+l*1/2, la1x+L, la1y+l*1/2);
  down = new Courbe3(la1x,la1y+l, la1x+L*1/3,la1y+l,la1x+L*2/3,la1y+l, la1x+L,la1y+l);
}

void draw () {

 if (record) {
    beginRecord(PDF, "frame-####.pdf"); 
  }

  background(255);
  left.drawCourbe();
  middle.drawCourbe2();
  right.drawCourbe();
  up.drawCourbe3();
  middle2.drawCourbe4();
  down.drawCourbe3();
  
  //stroke(255,0,0);
  //line(left.aX, left.aY, right.aX, right .aY);
  //line(left.eX, left.eY, right.eX, right .eY);
  


  for (int i=0; i< nPas; i++) {
    int aX = int(map(i, 0,nPas, left.aX, middle.aX)); 
    int aY = int(map(i, 0,nPas, left.aY, middle.aY));
    int x0 = int(map(i, 0,nPas, left.x0, middle.x0));
    int y0 = int(map(i, 0,nPas, left.y0, middle.y0));
    int x1 = int(map(i, 0,nPas, left.x1, middle.x1));
    int y1 = int(map(i, 0,nPas, left.y1, middle.y1));
    int eX = int(map(i, 0,nPas, left.eX, middle.eX));
    int eY = int(map(i, 0,nPas, left.eY, middle.eY));
    
   
    
    Courbe c = new Courbe(aX,aY,x0,y0,x1,y1,eX,eY);
    c.hideControls();
    
    c.drawCourbe();
  }
  
   for (int i=0; i< nPas; i++) {
    int aX = int(map(i, 0,nPas, middle.aX, right.aX)); 
    int aY = int(map(i, 0,nPas, middle.aY, right.aY));
    int x0 = int(map(i, 0,nPas, middle.x0, right.x0));
    int y0 = int(map(i, 0,nPas, middle.y0, right.y0));
    int x1 = int(map(i, 0,nPas, middle.x1, right.x1));
    int y1 = int(map(i, 0,nPas, middle.y1, right.y1));
    int eX = int(map(i, 0,nPas, middle.eX, right.eX));
    int eY = int(map(i, 0,nPas, middle.eY, right.eY));
    
        Courbe c = new Courbe(aX,aY,x0,y0,x1,y1,eX,eY);
    c.hideControls();
    
    c.drawCourbe();
  }
  
  for (int i=0; i< nPas2; i++) {
    int aX = int(map(i, 0,nPas2, up.aX, middle2.aX)); 
    int aY = int(map(i, 0,nPas2, up.aY, middle2.aY));
    int x0 = int(map(i, 0,nPas2, up.x0, middle2.x0));
    int y0 = int(map(i, 0,nPas2, up.y0, middle2.y0));
    int x1 = int(map(i, 0,nPas2, up.x1, middle2.x1));
    int y1 = int(map(i, 0,nPas2, up.y1, middle2.y1));
    int eX = int(map(i, 0,nPas2, up.eX, middle2.eX));
    int eY = int(map(i, 0,nPas2, up.eY, middle2.eY));
    
   
    
    Courbe4 c = new Courbe4(aX,aY,x0,y0,x1,y1,eX,eY);
    c.hideControls();
    
    c.drawCourbe4();
  }
  
  for (int i=0; i< nPas2; i++) {
    int aX = int(map(i, 0,nPas2, middle2.aX, down.aX)); 
    int aY = int(map(i, 0,nPas2, middle2.aY, down.aY));
    int x0 = int(map(i, 0,nPas2, middle2.x0, down.x0));
    int y0 = int(map(i, 0,nPas2, middle2.y0, down.y0));
    int x1 = int(map(i, 0,nPas2, middle2.x1, down.x1));
    int y1 = int(map(i, 0,nPas2, middle2.y1, down.y1));
    int eX = int(map(i, 0,nPas2, middle2.eX, down.eX));
    int eY = int(map(i, 0,nPas2, middle2.eY, down.eY));
    
        Courbe4 c = new Courbe4(aX,aY,x0,y0,x1,y1,eX,eY);
    c.hideControls();
    
    c.drawCourbe4();
  }
  
  if (record) {
 endRecord();
 println("saved PDF");
  record = false;
 }
}


void mouseReleased() {
  left.stopInteraction();
  middle.stopInteraction();
  right.stopInteraction();
  up.stopInteraction();
  middle2.stopInteraction();
  down.stopInteraction();
}

void keyPressed() {
  if (key=='n' ) {
    nPas++;
  }
  
  if (key=='m' ) {
    nPas2++;
  }
}


void keyReleased() {
  if (keyCode==32) {
    
    record = true;
}
 if (key=='n' ) {
    nPas++;
  }
  if (key=='o' ) {
    nPas--;
  }
  if (key=='m' ) {
    nPas2++;
  }
  if (key=='l' ) {
    nPas2--;
  }
  if (key=='+' ) {
    L++;
  }
  if (key=='-' ) {
    L--;
  }
  if (key=='2' ) {
    l++;
  }if (key=='1' ) {
    l--;
  }
}
