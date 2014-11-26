import java.util.Vector;

Vector lines = new Vector();
Vector points = new Vector();

/// for animation
boolean animate = false;
int cntPt=0;
int cntLn=0;
int cnt = 0;
int cadence = 0; // lower the speed

void setup() {
  size(800, 800);
  smooth();

  // load to mem from file
  try {
    String linesS[] = loadStrings("data.txt");
    println("there are " + linesS.length + " lines");
    for (int i = 0; i < linesS.length; i++) {
      String l = linesS[i];
      if (l.contains("N")) {
        /// new line here
        lines.addElement((Vector) points.clone());
        points.clear();
      } else {
        String strPoint[] = l.split(",");
        println(strPoint);
        points.add(new Point(int(strPoint[0]), int(strPoint[1])));
      }
    }
  } 
  catch (Exception e) {
    println("file don't exist");
  }
}



void draw() {
  background(255);

  if (animate==false) {
    if (mousePressed) {
      // adding points to only one line, current array
      points.addElement(new Point(mouseX, mouseY));

      drawLine(points);
    }

    // this is live drawing
    // preview line that will be repeated


    for (int a=0; a<lines.size (); a++) {
      Vector pts = (Vector)lines.get(a);
      drawLine(pts);
    }
  } else { // animation!


    Vector ptsForDraw = (Vector)lines.get(cntLn);

    if (cntLn>0) {
      for (int i=0; i<cntLn; i++) drawLine((Vector)lines.get(i));
    } 

    drawLineTill(ptsForDraw, cntPt);

    if (cnt<cadence) {
      cnt++;
    } else {
      cnt = 0;

      if (cntPt<ptsForDraw.size()) {
        cntPt++;
      } else {
        if (cntLn != lines.size()-1)cntPt = 0;
        if (cntLn<lines.size()-1) {
          cntLn++;
        }
      }
    }
  }
}

void mouseReleased() {

  if (animate==false) {
    lines.addElement((Vector) points.clone());
    points.clear();
    println(lines.size());


    // saving to file

      Vector text = new Vector();
    for (int a=0; a<lines.size (); a++) {
      Vector pts = (Vector)lines.get(a);

      for (int b=0; b<pts.size (); b++) {
        Point currentP = (Point)pts.get(b);
        text.addElement(new String(str(currentP.x) + "," + str(currentP.y)));
      }
      text.addElement(new String("N"));
    }

    String[] data = new String[text.size()];
    for (int i=0; i<text.size (); i++) {
      String textLine = (String)text.get(i);
      data[i] = textLine;
    }
    saveStrings("data.txt", data);
  }
}


void drawLine(Vector pts) {

  for (int i=1; i<pts.size (); i++) {
    Point point = (Point)pts.get(i);
    Point lastP = (Point)pts.get(i-1);
    if (i>0) {
      float d = dist(point.x, point.y, lastP.x, lastP.y);
      // stroke size adjustement
      float maxSize = 3.0;
      float minSize = 0.1;
      if (d>maxSize) d = maxSize;
      d = map(d, 0, maxSize, maxSize, minSize);
      strokeWeight(d);
      line(point.x, point.y, lastP.x, lastP.y);
    }
    lastP = point;
  }
}


void drawLineTill(Vector pts, int limit) {

  for (int i=1; i<limit; i++) {
    Point point = (Point)pts.get(i);
    Point lastP = (Point)pts.get(i-1);
    if (i>0) {
      float d = dist(point.x, point.y, lastP.x, lastP.y);
      // stroke size adjustement
      float maxSize = 3.0;
      float minSize = 0.1;
      if (d>maxSize) d = maxSize;
      d = map(d, 0, maxSize, maxSize, minSize);
      strokeWeight(d);
      line(point.x, point.y, lastP.x, lastP.y);
    }
    lastP = point;
  }
}


class Point {
  int x, y;
  float strokeW = 1.0;

  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  Point(int x, int y, float strokeW) {
    this.x = x;
    this.y = y;
    this.strokeW = strokeW;
  }
}


void keyReleased() {
  if (keyCode == 32) { // spacebar animation
    animate = true;
    println("animate!");
  }
}

