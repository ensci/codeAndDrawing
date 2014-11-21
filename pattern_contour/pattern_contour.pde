int[] tailles = new int[900];

void setup () {
  size(970, 970);
  for (int i=0; i<tailles.length; i++) {
    tailles[i] = 30;
  }
  smooth();
}

void draw() {
  background(25, 55, 100);
  //  fill(0,55,255, 2);
  // rect(0,0, width, height);
  for (int i=0; i<30; i++) {
    for (int j=0; j<30; j++) {

      float a= 50+i*30;
      float b= 50+j*30;

      float d = dist(mouseX, mouseY, a, b);
      int selector = j*30+i;

      
      
      if (focused) {
        if (d < tailles[selector]/2.0) {
          if (tailles[selector]<200) {
            tailles[selector]+=2;
          }
        } else {
          if (tailles[selector] > 100) { 
            tailles[selector]-=2;
          }
        }
      }

      stroke(0);
      strokeWeight(1.8);
      //noStroke();
      fill(255);
      //noFill();
      ellipse(a, b, tailles[selector], tailles[selector]);
    }
  }
}
void keyReleased() {
  if (keyCode==32) {
    saveFrame();
    println("sauvegardé!");
  }
}

