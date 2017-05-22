//--------------------------------------------------
int LENGTH;
String [][] csv;

int time;
float lat = 0.0;
float lon = 0.0;
float alt = 0.0;
float val = 0.0;

void setup() {
  size(800, 800, P3D);
  smooth();
  background(255);
  colorMode(HSB, 360);
  blendMode(BLEND);
  //blendMode(DIFFERENCE);
  curveTightness(0.4);
  strokeWeight(width/20.0);
  //strokeWeight(1);
  strokeCap(ROUND);
  strokeJoin(ROUND);
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
  LENGTH = lines.length;
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
  translate(0.5*width, 0.5*width, 0.0);
  rotateX(PI/8);
  //rotateY(-PI/4);
  //rotateZ(PI/4);

  float x, y, z;
  for (int i = 0; i < LENGTH-5; i++) {
    beginShape();
    for (int j = 0; j < 4; j++) {
      time = int(Float.parseFloat(csv[i+j][1]));
      lat = int(Float.parseFloat(csv[i+j][41]));
      lon = int(Float.parseFloat(csv[i+j][42]));
      alt = int(Float.parseFloat(csv[i+j][43]));
      val = int(Float.parseFloat(csv[i+j][34]));

      x = width / 2500.0 * (alt+500) * cos(radians(lon)) * cos(radians(lat));
      y = width / 2500.0 * (alt+500) * sin(radians(lon)) * cos(radians(lat));
      z = width / 2500.0 * (alt+500) * sin(radians(lat));

      stroke(map(val, -10, 20, 120, 0), 360, 360, 200); // color
      //stroke(0, 0, map(val, -10, 15, 0, 255), 120); // gray
      curveVertex(x, y, z);
    }
    endShape();
  }
  // save
  save("output.tiff");
}