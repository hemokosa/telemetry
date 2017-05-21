/*
**      ARTSAT API Sample Program 
**
**      Original Copyright (C) 2014 KUBOTA Akihiro.<kubotaa@tamabi.ac.jp>
**      All rights reserved.
**
**      Version     1.0
**      Website     http://artsat.jp/
**      E-mail      info@artsat.jp
**
**      This source code is for Processing2+.
**
**      ARTSAT_API_JSON_Sample.pde
**
**      ------------------------------------------------------------------------
**
**      GNU GENERAL PUBLIC LICENSE (GPLv3)
**
**      This program is free software: you can redistribute it and/or modify
**      it under the terms of the GNU General Public License as published by
**      the Free Software Foundation, either version 3 of the License,
**      or (at your option) any later version.
**      This program is distributed in the hope that it will be useful,
**      but WITHOUT ANY WARRANTY; without even the implied warranty of
**      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
**      See the GNU General Public License for more details.
**      You should have received a copy of the GNU General Public License
**      along with this program. If not, see <http://www.gnu.org/licenses/>.
**
**      このプログラムはフリーソフトウェアです。あなたはこれをフリーソフトウェア財団によって発行された
**      GNU 一般公衆利用許諾書（バージョン 3 か、それ以降のバージョンのうちどれか）が定める条件の下で
**      再頒布または改変することができます。このプログラムは有用であることを願って頒布されますが、
**      *全くの無保証* です。商業可能性の保証や特定目的への適合性は、言外に示されたものも含め全く存在しません。
**      詳しくは GNU 一般公衆利用許諾書をご覧ください。
**      あなたはこのプログラムと共に GNU 一般公衆利用許諾書のコピーを一部受け取っているはずです。
**      もし受け取っていなければ <http://www.gnu.org/licenses/> をご覧ください。
*/


/*
**      Get Time, Lat, Lon, Alt Data from ARTSAT API (JSON)
*/

JSONObject json, sensors;
JSONArray results;

long time;
float lat, lon, alt;

void setup() {
  noLoop();
}

void draw() {
  json = loadJSONObject("http://api.artsat.jp/invader/sensor_data.json?sensor=lat,lon,alt");
  
  results = json.getJSONArray("results");
  sensors = results.getJSONObject(0).getJSONObject("sensors");
  time = results.getJSONObject(0).getInt("time");
  
  lat = sensors.getFloat("lat");
  lon = sensors.getFloat("lon");
  alt = sensors.getFloat("alt");
  
  String date = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss z").format(new java.util.Date (time*1000L));

  println(date + ", " + lat + ", " + lon + ", " + alt);
}

