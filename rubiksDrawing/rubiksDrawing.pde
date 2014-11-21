//Nicolas Peugnet
color red = color(255, 0, 0);  //Definition des 6 couleurs
color green = color(0, 200, 0);
color blue = color(50, 50, 200);
color yellow = color(255, 255, 0);
color orange = color(255, 180, 0);
color white = color(255, 255, 255);
int[] colors = {red, green, blue, yellow, orange, white};
int selection = int(random(6));
int new_color = colors[selection];
int window = 750;
int number = 30;
int size = window/number;
int padding = (window-size*number)/2;
int[][] grid = new int[number][number];  // Declare 2D array
int[] patternColors = {colors[5],colors[3],colors[2]};
int patternX = int(random(number));
int patternY = int(random(number));
int moveX =0;
int moveY =0;

void setup() {
  size(window, window);
  moveX =0;
  moveY =0;
  patternX = int(random(number));
  patternY = int(random(number));
  for (int i = 0; i < number; i++) {
    for (int j = 0; j < number; j++) {
      selection = int(random(6));
      grid[i][j] = colors[selection];
    }
  }
  grid[patternX][patternY] = color(0,220,200);
}

void draw() {
  background(230, 230, 230); 
  for (int i=0; i<number; i++) {  //boucle de test des valeurs de detection
    for (int j=0; j<number; j++) {
      int x=moveX+padding+i*size;  //rangement des valeurs dans des variables
      int y=moveY+padding+j*size;
      int w=size;
      int h=size;
      noStroke();
      fill(grid[i][j]);
      rect(x, y, w, h);  //dessin du carré
      if (mousePressed == true) {
        if ((mouseX > (moveX+padding+patternX*size)) && (mouseX < (moveX+padding+patternX*size+size)) && (mouseY > (moveY+padding+patternY*size)) && (mouseY < (moveY+padding+patternY*size+size))) {
          setup();
        } else {
          if ((mouseX > x) && (mouseX < x+w) && (mouseY > y) && (mouseY < y+h)) { //si les coordonnees de la souris correspondent a celles du carré...
            grid[i][j] = new_color; //change la couleur du carré selectionne dans le tableau
          } 
        }
      }  
    }
  }
}

void Menu() {
  while (mousePressed == false) {
    
  }
}
    

void keyPressed() {
  if (key == 'r' || key == 'R') {
    new_color = red;
  }
  if (key == 'g' || key == 'G') {
    new_color = green;
  }
  if (key == 'b' || key == 'B') {
    new_color = blue;
  }
  if (key == 'y' || key == 'Y') {
    new_color = yellow;
  }
  if (key == 'o' || key == 'O') {
    new_color = orange;
  }
  if (key == 'w' || key == 'W') {
    new_color = white;
  }
  if (key == 32) {
    setup();
  }
  if (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT  || key == 'p' || key == 'm') {
    if (key == 'p') {
      size ++;  //Grossit les carrés
      /*moveX *=(size/(number/2));
      moveY *=(size/(number/2));*/
    }
    if (key == 'm') {
      if (size >1) {
        size --;  //rapetisse les carrés
        /*moveX /=(size/(number/2));
        moveY /=(size/(number/2)); */
      }
    }
    if (keyCode == DOWN) {
      moveY -=size/3+2; 
    }
    if (keyCode == UP) {
      moveY +=size/3+2;
    }
    if (keyCode == RIGHT) {
      moveX -=size/3+2;
    }
    if (keyCode == LEFT) {
      moveX +=size/3+2;
    }
    padding = (window-size*number)/2;
  }
}
  
