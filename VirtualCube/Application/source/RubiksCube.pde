int size = 3;
PMatrix3D baseMat;
color[] colors = {#FFFFFF, #FE8D01, #009B48, #B90000, #0046AD, #FFD500};
public final color white = colors[0];
public final color orange = colors[1];
public final color green  = colors[2];
public final color red = colors[3];
public final color blue = colors[4];
public final color yellow = colors[5];

//Defining directions
public static final int up = 0;
public static final int left = 1;
public static final int front = 2;
public static final int right = 3;
public static final int back = 4;
public static final int down = 5;
public static final int eslice = 6;
public static final int sslice = 7;
public static final int mslice = 8;

Piece[] cube = new Piece[size*size*size];
Piece[] solvedState = new Piece[size*size*size];
public static final int mult = 14;


long currTime = 0;
long startTime = 0;
float displayTime = 0;

boolean solveStarted = true;
boolean currentOngoingSolve = false;




String scramble = new String();

void setup() {
 size(1000, 700, P3D);
 baseMat = getMatrix(baseMat);
  int index = 0;
  for (int i = -1; i <= 1; i++) {
     for (int j = -1; j <=1; j++) {
       for (int k = -1; k <= 1; k++) {
         PMatrix3D matrix = new PMatrix3D();
         matrix.translate(mult*i,mult*j,mult*k);
         solvedState[index] = new Piece(matrix, mult*i, mult*j, mult*k);
         cube[index++] =  new Piece(matrix, mult*i, mult*j, mult*k);
       }
     }
   }
}

void front(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].z == mult) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(cube[i].x, cube[i].y);
      cube[i].turnFace(front, prime);
      cube[i].updatePos(round(matrix.m02), round(matrix.m12), cube[i].z);
    }
  }
}

void back(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].z == -mult) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*-HALF_PI);
      matrix.translate(cube[i].x, cube[i].y);
      cube[i].turnFace(back, prime);
      cube[i].updatePos(round(matrix.m02), round(matrix.m12), cube[i].z);
    }
  }
}

void right(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].x == mult) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(cube[i].y, cube[i].z);
      cube[i].turnFace(right, prime);
      cube[i].updatePos(cube[i].x, round(matrix.m02), round(matrix.m12));
    }
  }
}

void left(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].x == -mult) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*-HALF_PI);
      matrix.translate(cube[i].y, cube[i].z);
      cube[i].turnFace(left, prime);
      cube[i].updatePos(cube[i].x, round(matrix.m02), round(matrix.m12));
    }
  }
}

void up(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].y == -mult) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(cube[i].x, cube[i].z);
      cube[i].turnFace(up, prime);
      cube[i].updatePos(round(matrix.m02), cube[i].y, round(matrix.m12));
    }
  }
}

void down(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].y == mult) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*-HALF_PI);
      matrix.translate(cube[i].x, cube[i].z);
      cube[i].turnFace(down, prime);
      cube[i].updatePos(round(matrix.m02), cube[i].y, round(matrix.m12));
    }
  }
}

void eslice(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].y == 0) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*-HALF_PI);
      matrix.translate(cube[i].x, cube[i].z);
      cube[i].turnFace(eslice, prime);
      cube[i].updatePos(round(matrix.m02), cube[i].y, round(matrix.m12));
    }
  }
}

void sslice(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].z == 0) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(cube[i].x, cube[i].y);
      cube[i].turnFace(sslice, prime);
      cube[i].updatePos(round(matrix.m02), round(matrix.m12), cube[i].z);
    }
  }
}

void mslice(int prime){
  for (int i = 0; i < cube.length; i++) {
    if(cube[i].x == 0) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*-HALF_PI);
      matrix.translate(cube[i].y, cube[i].z);
      cube[i].turnFace(mslice, prime);
      cube[i].updatePos(cube[i].x, round(matrix.m02), round(matrix.m12));
    }
  }
}

void zRotate(int prime) {
  for (int i = 0; i < cube.length; i++) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(cube[i].x, cube[i].y);
      cube[i].turnFace(front, prime); //front = same dir as a z rotation
      cube[i].updatePos(round(matrix.m02), round(matrix.m12), cube[i].z);
  }
}

void yRotate(int prime){
  for (int i = 0; i < cube.length; i++) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(cube[i].x, cube[i].z);
      cube[i].turnFace(up, prime);//up = same dir as y rotation
      cube[i].updatePos(round(matrix.m02), cube[i].y, round(matrix.m12));
  }
}

void xRotate(int prime){
  for (int i = 0; i < cube.length; i++) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(cube[i].y, cube[i].z);
      cube[i].turnFace(right, prime);//right = same dir as x rotation
      cube[i].updatePos(cube[i].x, round(matrix.m02), round(matrix.m12));
  }
}

void zRotateSS(int prime) {
  for (int i = 0; i < cube.length; i++) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(solvedState[i].x, solvedState[i].y);
      solvedState[i].turnFace(front, prime); //front = same dir as a z rotation
      solvedState[i].updatePos(round(matrix.m02), round(matrix.m12), solvedState[i].z);
  }
}

void yRotateSS(int prime){
  for (int i = 0; i < cube.length; i++) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(solvedState[i].x, solvedState[i].z);
      solvedState[i].turnFace(up, prime);//up = same dir as y rotation
      solvedState[i].updatePos(round(matrix.m02), solvedState[i].y, round(matrix.m12));
  }
}

void xRotateSS(int prime){
  for (int i = 0; i < cube.length; i++) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(prime*HALF_PI);
      matrix.translate(solvedState[i].y, solvedState[i].z);
      solvedState[i].turnFace(right, prime);//right = same dir as x rotation
      solvedState[i].updatePos(solvedState[i].x, round(matrix.m02), round(matrix.m12));
  }
}

void draw() {
  background(0);
  
  pushMatrix();
  camera(0,-200*mult,250*mult,   0,0,0,   0,1,0);
  scale(50);
  for (int i = 0; i < cube.length; i++) {
    cube[i].show();
  }
  popMatrix();
  
  this.setMatrix(baseMat);
  fill(255);
  textSize(30);
  text(scramble, 170, 50);
  currTime = System.nanoTime();
  if (!isSolved() && currentOngoingSolve && solveStarted) { //if there is a solve ongoing and also the solve has been started
    displayTime = (currTime - startTime)/1000000000.0;
  } else if (isSolved()){
    currentOngoingSolve = false;
  }
  //print(displayTime);
  text(displayTime, 900, 250);
}

boolean isSolved() {
  int count = 0;
  // LINES UP RED CENTER
  if (solvedState[4].y!=cube[4].y)  {
    count = 0;
    while (!solvedState[4].isEqual(cube[4]) && count < 4) {
      zRotateSS(1);
      count++;
    }
    count = 0;
    while (!solvedState[4].isEqual(cube[4]) && count < 4) {
      xRotateSS(1);
      count++;
    }
  } else {
    count = 0;
    while (!solvedState[4].isEqual(cube[4]) && count < 4) {
      yRotateSS(1);
      count++;
    }
  }
  //LINES UP WHITE CENTER
  count = 0;
  if (solvedState[4].y !=0) {
    while (!solvedState[16].isEqual(cube[16]) && count < 4) {
      yRotateSS(1);
      count++;
    }
  } 
  else if (solvedState[4].x !=0){
    while (!solvedState[16].isEqual(cube[16]) && count < 4) {
      xRotateSS(1);
      count++;
    }
  }
  else if (solvedState[4].z !=0)  {
    while (!solvedState[16].isEqual(cube[16]) && count < 4) {
      zRotateSS(1);
      count++;
    }
  }
  
    
  zRotate(1);
  zRotate(-1);
  
  for (int i = 0; i < cube.length; i++) {
    if (!cube[i].isEqual(solvedState[i])){
      return false;
    }
  }
  return true;
}

void startSolve() {
  setup();
  zRotate(1);
  zRotate(1);
  ScrambleGenerator scrambleGen = new ScrambleGenerator(20);
  scramble = scrambleGen.getScramble();   
  solveStarted = false;
  currentOngoingSolve = true;
}
