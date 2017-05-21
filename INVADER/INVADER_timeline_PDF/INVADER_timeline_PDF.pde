//--------------------------------------------------
import processing.pdf.*;

int LENGTH;
String [][] csv;

void setup() {
  size(2000, 2000);
  background(255);
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
  float s = Float.parseFloat(csv[0][0]);
  float e = Float.parseFloat(csv[LENGTH-1][0]);
  float t;
  float l;

  float x;
  float y;
  float x0;
  float y0;

  for (int i = 0; i <= LENGTH-1; i += 1) {
    t = Float.parseFloat(csv[i][0]);
    l = 2000*2000*(t-s)/(e-s);
    x0 = l/2000;
    y0 = l%2000;
    beginShape();
    vertex(x0, y0);
    for (int j = 3; j < 40; j += 2) {
      x = x0 + Float.parseFloat(csv[i][j])/10;
      y = y0 + Float.parseFloat(csv[i][j+1])/10;
      vertex(x, y);
    } 
    endShape();
    beginShape();
    vertex(x0, y0);
    for (int j = 2; j < 40; j += 2) {
      x = x0 - Float.parseFloat(csv[i][j])/10;
      y = y0 - Float.parseFloat(csv[i][j+1])/10;
      vertex(x, y);
    } 
    endShape();
  } 
  // save
  endRecord();
}