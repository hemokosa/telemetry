//--------------------------------------------------
import processing.pdf.*;

int LENGTH;
String [][] csv;

int time;
float lat = 0.0;
float lon = 0.0;
float alt = 0.0;
float val = 0.0;
float lat0, lon0, alt0;

ArrayList history = new ArrayList();
float distthresh = 200.0;

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
  float x0, y0;
  x0 = 1000.0;
  y0 = 1000.0;

  for (int i = 0; i < LENGTH; i += 1) {
    time = int(Float.parseFloat(csv[i][1]));
    lat = int(Float.parseFloat(csv[i][41]));
    lon = int(Float.parseFloat(csv[i][42]));
    alt = int(Float.parseFloat(csv[i][43]));
    val = int(Float.parseFloat(csv[i][34]));

    x0 = 2.4 * alt * sin(radians(lon))+1000.0;
    y0 = 2.4 * alt * cos(radians(lon))+1000.0;
    //x0 = map(sin(radians(lon)), -1, 1, 0, 2000);
    //y0 = map(sin(radians(lat)), -1, 1, 0, 2000);

    PVector d = new PVector(x0, y0, 0);
    history.add(0, d);

    for (int p = 0; p < history.size (); p++) {
      PVector v = (PVector) history.get(p);
      float joinchance = (float)p/history.size() + d.dist(v)/distthresh;
      //        print(p);
      //        print(", ");
      //        println(joinchance);
      if (joinchance < random(0.8)) line(d.x, d.y, v.x, v.y);
    }
  }
  // save
  endRecord();
}