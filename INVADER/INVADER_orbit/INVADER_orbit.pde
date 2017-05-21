//--------------------------------------------------
int LENGTH;
String [][] csv;

int time;
float lat = 0.0;
float lon = 0.0;
float alt = 0.0;
float val = 0.0;
float lat0, lon0, alt0;

void setup() {
  size(800, 800);
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
  float x, y;
  for (int i = 0; i < LENGTH-5; i++) {
    beginShape();
    for (int j = 0; j < 4; j++) {
      time = int(Float.parseFloat(csv[i+j][1]));
      lat = int(Float.parseFloat(csv[i+j][41]));
      lon = int(Float.parseFloat(csv[i+j][42]));
      alt = int(Float.parseFloat(csv[i+j][43]));
      val = int(Float.parseFloat(csv[i+j][34]));

      x = width / 2250.0 * (alt+500) * sin(radians(lon)) + width * 0.5;
      y = width / 2250.0 * (alt+500) * cos(radians(lon)) + width * 0.5;

      //x = map(lon, 0, 360, width*0.077, width*0.93);
      //y = map(lat, -70, 70, width*0.137, width*0.86);

      //strokeWeight(max(map(val, -10, 30, 0, 50), 0.01));
      stroke(map(val, -10, 30, 250, 0), 360, 360, 320);
      curveVertex(x, y);
    }
    endShape();
  }
  // save
  save("output.tiff");
}