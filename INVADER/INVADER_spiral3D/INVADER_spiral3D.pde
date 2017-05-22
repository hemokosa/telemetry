//--------------------------------------------------
int LENGTH;
String [][] csv;

float lat = 0.0;
float lon = 0.0;
float alt = 0.0;

void setup() {
  size(2000, 2000, P3D);
  smooth();
  background(255);

  curveTightness(0.4);
  strokeWeight(1);
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
  rotateX(-PI/8);
  //rotateY(-PI/4);
  //rotateZ(PI/4);

  float x, y, z;
  beginShape();
  for (int i = 0; i < LENGTH; i++) {

    lat = int(Float.parseFloat(csv[i][41]));
    lon = int(Float.parseFloat(csv[i][42]));
    alt = int(Float.parseFloat(csv[i][43]));

    x = width / 2500.0 * (alt+500) * cos(radians(lon)) * cos(radians(lat));
    y = width / 2500.0 * (alt+500) * sin(radians(lon)) * cos(radians(lat));
    z = width / 2500.0 * (alt+500) * sin(radians(lat));

    curveVertex(x, y, z);
  }
  endShape();
  // save
  save("output.tiff");
}