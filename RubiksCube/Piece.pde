class Piece {
  PMatrix3D m;
  int x;
  int y;
  int z;
  Sticker[] stickers = new Sticker[6];
  
  public Piece(PMatrix3D m, int x, int y, int z) {
    this.m = m;
    this.x = x;
    this.y = y;
    this.z = z;
    
    if (x == mult) {
      stickers[1] = new Sticker(new PVector(mult,0,0), orange);
    } else if (x == -mult) {
      stickers[3] = new Sticker(new PVector(-mult,0,0), red);
    }
    if (y == mult) {
      stickers[0] = new Sticker(new PVector(0,mult,0), white);
    } else if (y == -mult) {
      stickers[5] = new Sticker(new PVector(0,-mult,0), yellow);
    }
    if (z == mult) {
      stickers[4] = new Sticker(new PVector(0,0,mult), green);
    } else if (z == -mult) {
      stickers[2] = new Sticker(new PVector(0,0,-mult), blue);
    }
  }
  
  
  void show() {
    noFill();
    stroke(0);
    strokeWeight(.1);
    pushMatrix();
    applyMatrix(m);
    for(Sticker s: stickers) {
      if(s == null) {continue;}
      s.show();
    }
    popMatrix();
  }
  
  void updatePos(int x, int y, int z) {
    m.reset();
    m.translate(x, y, z);
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void turnFace(int dir, int prime) {
    switch(dir) {
      
      case back: 
        for (Sticker s : stickers) {
          if(s == null) {continue;}
          s.turnZ(prime * -HALF_PI);
        }
        break;
        
      case front: 
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnZ(prime * HALF_PI);
        }
        break;
        
      case right:
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnX(prime * HALF_PI);
        }
        break;
      case left: 
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnX(prime * -HALF_PI);
        }
        break;
      case up: 
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnY(prime * HALF_PI);
        }
        break;
      case down:
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnY(prime * -HALF_PI);
        }
        break;
      case eslice:
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnY(prime * -HALF_PI);
        }
        break;
      case sslice:
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnZ(prime * HALF_PI);
        }
        break;
      case mslice:
        for (Sticker s: stickers) {
          if(s == null) {continue;}
          s.turnX(prime * -HALF_PI);
        }
        break;
      
    }
  }
  boolean isEqual(Piece p) {
    for (int i = 0; i < stickers.length; i++) {
      if (stickers[i] == null && p.stickers[i] == null) {continue;}
      if (stickers[i] ==null || p.stickers[i] == null || !stickers[i].isEqual(p.stickers[i])) {
        return false;
      }
    }
    return true;
  }
}
