void keyPressed() {
  if (!solveStarted && (key == 'e' || key == 'd' || key == 'i' || key == 'k' || key == 'j' || key == 'f' || key == 's' || key == 'l' || key == 'h' || key == 'g' || key == 'w' ||
                                                   key == 'o' || key == '2' || key == '9' || key == '1' || key == '0' || key == '.' || key == 'x' || key == '5' || key == '6' ||
                                                   key == 'u' || key == 'm' || key == 'v' || key == ',' || key == 'c' || key == 'z' || key == '/')) {
        startTime = System.nanoTime();
        solveStarted = true;
      }
  switch (key) {
    //NORMAL MOVES
    case 'e':
      left(-1);
      break;
    case 'd':
      left(1);
      break;
    case 'i':
      right(1);
      break;
    case 'k':
      right(-1);
      break;
    case 'j':
      up(1);
      break;
    case 'f':
      up(-1);
      break;
    case 's':
      down(1);
      break;
    case 'l':
      down(-1);
      break;
    case 'h':
      front(1);
      break;
    case 'g':
      front(-1);
      break;
    case 'w':
      back(1);
      break;
    case 'o':
      back(-1);
      break;
    
    //SLICES
    //E SLICE
    case '2':
      eslice(1);
      break;
    case '9':
      eslice(-1);
      break;
    //S SLICE
    case '1':
      sslice(-1);
      break;
    case '0':
      sslice(1);
      break;
    //M SLICE
    case '.':
    case 'x':
      mslice(-1);
      break;
    case '5':
    case '6':
      mslice(1);
      break;
      
    
    //ROTATIONS
    // z rotations
    case 'p':
      zRotate(1);
      break;
    case 'q':
      zRotate(-1);
      break;
    // y rotations
    case ';':
      yRotate(1);
      break;
    case 'a':
      yRotate(-1);
      break;
    //x rotations
    case 'b':
    case 'n':
      xRotate(-1);
      break;
    case 't':
    case 'y':
      xRotate(1);
      break;
      
      
   //WIDE MOVES
   //Rw
   case 'u':
     right(1);
     mslice(-1);
     break;
   case 'm':
     right(-1);
     mslice(1);
     break;
   //Lw
   case 'v':
     left(1);
     mslice(1);
     break;
   case 'r':
     left(-1);
     mslice(-1);
     break;
   //Uw
   case ',':
     up(1);
     eslice(-1);
     break;
   case 'c':
     up(-1);
     eslice(1);
     break;
   //Dw
   case 'z':
     down(1);
     eslice(1);
     break;
   case '/':
     down(-1);
     eslice(-1);
     break;
     
   //SCRAMBLE
   case ' ':
     if (isSolved()){
     startSolve();
     }
     break;
   //BUG TESTING
   case '=':
     setup();
     break;
  }
  
}
