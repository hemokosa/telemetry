//--------------------------------------------------
import processing.pdf.*;

int LENGTH;
String [][] csv;

int time;
float lat = 0.0;
float lon = 0.0;
float alt = 0.0;

void setup() {
  size(2000, 2000);
  background(255);
  noFill();
  noLoop();

  int csvWidth=0;
  String lines[] = loadStrings("INVADER_telemetry.csv");

  //calculate max width of csv file
  for (int i=0; i < lines.length; i++) {
    String [] chars=split(lines[i], ',');
    if (chars.length>csvWidth) {
      csvWidth=chars.length;
    }
  }

  // create csv array based on # of rows and columns in csv file
  csv = new String [lines.length][csvWidth];
  LENGTH =lines.length; //
  println(LENGTH);
  //parse values into 2d array
  for (int i=0; i < lines.length; i++) {
    String [] temp = new String [lines.length];
    temp= split(lines[i], ',');
    for (int j=0; j < temp.length; j++) {
      csv[i][j]=temp[j];
    }
  }
}

void draw() {
  beginRecord(PDF, "output.pdf");

  // lines
  float x, y;
  x = 1000.0;
  y = 1000.0;

  curveTightness(0.01);
  strokeWeight(0.25);
  strokeCap(ROUND);
  strokeJoin(ROUND);
  
  beginShape();
  for (int i = 0; i < LENGTH; i += 1) {
    lat = int(Float.parseFloat(csv[i][41]));
    lon = int(Float.parseFloat(csv[i][42]));
    alt = int(Float.parseFloat(csv[i][43]));

    x = 2.0 * alt * sin(radians(lon))+1000.0;
    y = 2.0 * alt * cos(radians(lon))+1000.0;
    //x = map(sin(radians(lon)), -1, 1, 200, 1800);
    //y = map(sin(radians(lat)), -1, 1, 200, 1800);

    curveVertex(x, y);
  }
  endShape();
  // save
  endRecord();
}