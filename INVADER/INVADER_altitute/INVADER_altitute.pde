//--------------------------------------------------

int LENGTH;
String [][] csv;

JSONObject json, sensors;
JSONArray results;

float time;
float lat = 0.0;
float lon = 0.0;
float alt = 0.0;

String out;
PrintWriter output;

void setup() {
  size(50, 50);
  background(255);
  noStroke();
  noLoop();

  output = createWriter("output.txt"); 

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
  // lines
  for (int i = 0; i < LENGTH; i++) {
    time = Float.parseFloat(csv[i][1]);
    getAPI(int(time));
    out = str(i) + ", " + str(lat) + ", " + str(lon) + ", " + str(alt);
    println(i);
    output.println(out);   
  }
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
}

void getAPI(int t) { 
  json = loadJSONObject("http://api.artsat.jp/invader/sensor_data.json?sensor=lat,lon,alt&time="+str(t));

  results = json.getJSONArray("results");
  sensors = results.getJSONObject(0).getJSONObject("sensors");
  time = results.getJSONObject(0).getInt("time");

  lat = sensors.getFloat("lat");
  lon = sensors.getFloat("lon");
  alt = sensors.getFloat("alt");
}