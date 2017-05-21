//--------------------------------------------------
import processing.pdf.*;

int LENGTH;
String [][] csv;

void setup() {
  size(3508, 3508);
  background(255);
  noStroke();
  noLoop();

  int csvWidth=0;
  String lines[] = loadStrings("INVADER_telemetry_selected.csv");

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
  float x;
  stroke(0);
  for (int i = 0; i < LENGTH; i++) {
    x = 3508.0 * i / LENGTH;
    line(x, 0, x, Float.parseFloat(csv[i][15])*4);
    line(x, 3508, x, 3508-(Float.parseFloat(csv[i][14])*4));
    line(0, x, (Float.parseFloat(csv[i][9])+Float.parseFloat(csv[i][13]))*4, x);
    line(width, x, width-((Float.parseFloat(csv[i][8])+Float.parseFloat(csv[i][12]))*4), x);
  }

  // save
  endRecord();
}