float[][] vecToMatrix(Vector4D v){
  float[][] m = new float[4][1];
  m[0][0] = v.x;
  m[1][0] = v.y;
  m[2][0] = v.z;
  m[3][0] = v.w;
  return m;
}

PVector matrixToVec(float[][] m){
  PVector v = new PVector();
  v.x = m[0][0];
  v.y = m[1][0];
  v.z = m[2][0];
  return v;
}

Vector4D matrixToVec4D(float[][] m){
  Vector4D v = new Vector4D(0,0,0,0);
  v.x = m[0][0];
  v.y = m[1][0];
  v.z = m[2][0];
  v.w = m[3][0];
  return v;
}

PVector matmul(float[][] a, Vector4D b){
  float[][] m = vecToMatrix(b);
  return matrixToVec(matmul(a,m));
}

Vector4D matmul(float[][] a, Vector4D b, boolean fourth){
  float[][] m = vecToMatrix(b);
  return matrixToVec4D(matmul(a,m));
}

float[][] matmul(float[][] a, float[][]b){
  int colsA = a[0].length;
  int rowsA = a.length;
  int colsB = b[0].length;
  int rowsB = b.length;
  if (colsA != rowsB){
    println("Columns of A must match rows of B in size");
    return null;
  }
  
  float result[][] = new float[rowsA][colsB];
  for (int i = 0; i < rowsA; i++){
    for (int j = 0; j < colsB; j++){
      float sum = 0;
      for (int k = 0; k < colsA; k++){
        sum += a[i][k] * b[k][j];
      }
      result[i][j] = sum;
    }
  }
  return result;
}

void PrintMatrix(float[][] m){
  int cols = m[0].length;
  int rows = m.length;
  println(rows + "x" + cols);
  println("----------------");
  for (int i = 0; i < rows; i++){
    for (int j = 0; j < rows; j++){    
      print(m[i][j] + " ");
    }
    println();
  }
  println();
}
