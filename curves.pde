int n = 250;
float[] p = {0, 0, 173, 324, 473, 261, 615, 665};
float roadWidth = 100;

PVector[] roadLeft = new PVector[n];
PVector[] roadRight = new PVector[n];
PVector[] roadMid = new PVector[n];
float dt = 1.0/n;

int f = 0;

void setup() {
  size(600, 600);
  background(255);
  
  genRoadPoints();
}

void genRoadPoints() {
  float t = 0;

  for (int i = 0; i < n; i++) {
    float x = curvePoint(p[0], p[2], p[4], p[6], t);
    float y = curvePoint(p[1], p[3], p[5], p[7], t);
    roadLeft[i] = new PVector(x, y);

    float tx = curveTangent(p[0], p[2], p[4], p[6], t);
    float ty = curveTangent(p[1], p[3], p[5], p[7], t);
    float tMag = sqrt(tx*tx + ty*ty);    
    tx *= roadWidth / tMag;
    ty *= roadWidth / tMag;
    roadRight[i] = new PVector(x-ty, y+tx);
    
    roadMid[i] = new PVector((x+x-ty)/2, (y+y+tx)/2);
    t += dt;
  }
}


void draw() {
  background(255);
  fill(0);

  for (int i = 0; i < n-1; i++) {
    line(roadLeft[i].x, roadLeft[i].y, roadLeft[i+1].x, roadLeft[i+1].y);
    line(roadRight[i].x, roadRight[i].y, roadRight[i+1].x, roadRight[i+1].y);
  }

  fill(255, 0, 0);
  if (f < n) {
    circle(roadMid[f].x, roadMid[f].y, 20);
    f++;
  }
  else 
    noLoop();


}
