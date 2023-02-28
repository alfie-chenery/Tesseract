//Tesseract be like 4D hypercube noises
float size = 150;
float angle = 0;
Vector4D[] points = new Vector4D[16];

void setup(){
  size (800,800,P3D);
  stroke(255);
  points[0] = new Vector4D(-1,-1,-1,1);
  points[1] = new Vector4D(1,-1,-1,1);
  points[2] = new Vector4D(1,1,-1,1);
  points[3] = new Vector4D(-1,1,-1,1);
  points[4] = new Vector4D(-1,-1,1,1);
  points[5] = new Vector4D(1,-1,1,1);
  points[6] = new Vector4D(1,1,1,1);
  points[7] = new Vector4D(-1,1,1,1);
  
  points[8] = new Vector4D(-1,-1,-1,-1);
  points[9] = new Vector4D(1,-1,-1,-1);
  points[10] = new Vector4D(1,1,-1,-1);
  points[11] = new Vector4D(-1,1,-1,-1);
  points[12] = new Vector4D(-1,-1,1,-1);
  points[13] = new Vector4D(1,-1,1,-1);
  points[14] = new Vector4D(1,1,1,-1);
  points[15] = new Vector4D(-1,1,1,-1);
}

void draw(){
  background(0);
  translate(width/2,height/2);
  rotateX(-HALF_PI);//replace with a rotation matrix later down for rotate X
  //rotateX(angle);
  //rotateY(angle);
  //rotateZ(angle);
  PVector[] projected3D = new PVector[16];
  
  float distance = 2;
  
  for (int i = 0; i < points.length; i++){
    Vector4D v = points[i];
    strokeWeight(15);
    noFill();
    
    float[][] rotationXY = {
      {cos(angle),-sin(angle),0,0},
      {sin(angle),cos(angle),0,0},
      {0,0,1,0},
      {0,0,0,1}
    };
    
    float[][] rotationZW = {
      {1,0,0,0},
      {0,1,0,0},
      {0,0,cos(angle),-sin(angle)},
      {0,0,sin(angle),cos(angle)},
    };
    
    //add more rotation matricies to experiment with
    
    Vector4D rotated = matmul(rotationXY, v, true);
    rotated = matmul(rotationZW, rotated, true);
    
    
    float w = 1/(distance -rotated.w);
    
    float[][] projectionMat = {
      {w,0,0,0},
      {0,w,0,0},
      {0,0,w,0}
    };
    
    PVector projected = matmul(projectionMat, rotated);
    projected.mult(size);
    projected3D[i] = projected;
    
    point(projected.x, projected.y, projected.z);
  }
  
  ////connecting points
  //new method - connect points which are unit distance (within some delta)
  for(int i=0; i<16; i++){
    for(int j=0; j<16; j++){
      float dx = points[i].x - points[j].x;
      float dy = points[i].y - points[j].y;
      float dz = points[i].z - points[j].z;
      float dw = points[i].w - points[j].w;
      if(sqrt(sq(dx)+sq(dy)+sq(dz)+sq(dw)) < distance + 0.01){
        connect(0,i,j,projected3D);
      }
    }
  }
  
  //for (int i = 0; i < 4; i++){
  //  connect(0, i, (i+1) % 4, projected3D);
  //  connect(0, i+4, ((i+1) % 4)+4, projected3D);
  //  connect(0, i, i+4, projected3D);
  //} 
  
  //for (int i = 0; i < 4; i++){
  //  connect(8, i, (i+1) % 4, projected3D);
  //  connect(8, i+4, ((i+1) % 4)+4, projected3D);
  //  connect(8, i, i+4, projected3D);
  //} 
  
  //for (int i = 0; i < 8; i++){
  //  connect(0, i, i+8, projected3D);
  //} 
  
  
  angle += 0.01;
}

void connect(int offset, int i, int j, PVector[] points){
  PVector a = points[i+offset];
  PVector b = points[j+offset];
  strokeWeight(1);
  line(a.x,a.y,a.z,b.x,b.y,b.z);
}
