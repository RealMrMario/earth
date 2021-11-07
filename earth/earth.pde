JSONObject j;
JSONArray positionsJson;
Table table;
earth_render earth = new earth_render();
PVector yAxis = new PVector(0, 1, 0);
PVector zAxis = new PVector(0, 0, 1);
float r = 200;
PVector p1;
PVector p3;
PVector p2;
float rotation = 0;
float satAngle;

JSONObject pos1;// = positionsJson.getJSONObject(0);
JSONObject pos2;// = positionsJson.getJSONObject(1);

float sat1Lon;// = pos1.getFloat("satlongitude");
float sat1Lat;// = pos1.getFloat("satlatitude");

float sat2Lon;// = pos2.getFloat("satlongitude");
float sat2Lat;// = pos2.getFloat("satlatitude");

void setup()
{
  size(600, 600, P3D);
  earth.setup();
  j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=QWJMXJ-VTXV99-SX5CWX-4SPH");
  positionsJson = j.getJSONArray("positions");


  pos1 = positionsJson.getJSONObject(0);
  pos2 = positionsJson.getJSONObject(1);
  sat1Lon = pos1.getFloat("satlongitude");
  sat1Lat = pos1.getFloat("satlatitude");

  sat2Lon = pos2.getFloat("satlongitude");
  sat2Lat = pos2.getFloat("satlatitude");
  println(sat1Lon, sat1Lat);
  println(sat2Lon, sat2Lat);
}
void draw() {

 

  //Stjålet fra Shiffman ;-)

  float theta = radians(sat1Lon);
  float phi = radians(sat1Lat) + PI;

  // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
  float x1 = (r+ 30) * cos(theta) * cos(phi);
  float y1 = -(r+ 30) * sin(theta);
  float z1 = -(r+ 30) * cos(theta) * sin(phi);
   p1 = new PVector(x1, y1, z1);

  float theta2 = radians(sat2Lon);
  float phi2 = radians(sat2Lat) + PI;


  float x2 = (r+ 30) * cos(theta2) * cos(phi2);
  float y2 = -(r+ 30) * sin(theta2);
  float z2 = -(r+ 30) * cos(theta2) * sin(phi2);

  p2 = new PVector(x2, y2, z2);
  p3= new PVector();
  float ha = PVector.angleBetween(p1,p2);
  satAngle+= ha;
  
  
  p3 = p1.cross(p2);
  earth.display();
  rotation +=0.01;

  //how does it work? It is magic
  //latt
  pushMatrix();
  translate(width*0.5, height*0.5, -800);
  rotate(satAngle, p3.x, p3.y, p3.z);
  // rotate(rotation, zAxis.x, zAxis.y, zAxis.z);
  translate(p2.x, p2.y, p2.z);
  box(20);
  popMatrix();
}
