class Sticker {
  PVector normal;
  color c;
  
  public Sticker(PVector normal, color c) {
    this.normal = normal;
    this.c = c;
  }
  
  void turnX(float angle) {
    PVector v = new PVector();
    v.y = round(normal.y * cos(angle) - normal.z * sin(angle));
    v.z = round(normal.y * sin(angle) + normal.z * cos(angle));
    v.x = normal.x;
    normal = v;
  }
  
  
  void turnY(float angle) {
    PVector v = new PVector();
    v.x = round(normal.x * cos(angle) - normal.z * sin(angle));
    v.z = round(normal.x * sin(angle) + normal.z * cos(angle));
    v.y = normal.y;
    normal = v;
  }
  
  
  void turnZ(float angle) {
    PVector v = new PVector();
    v.x = round(normal.x * cos(angle) - normal.y * sin(angle));
    v.y = round(normal.x * sin(angle) + normal.y * cos(angle));
    v.z = normal.z;
    normal = v;
  }
  
  void show() {
    pushMatrix();
    fill(c);
    noStroke();
    rectMode(CENTER);
    translate(normal.x/2, normal.y/2, normal.z/2);
    if (abs(normal.x) > 0) {
      rotateY(HALF_PI);
    } else if (abs(normal.y) > 0){
      rotateX(HALF_PI);
    }
    square(0,0,0.8*mult);
    popMatrix();
  }
  
  boolean isEqual(Sticker s) {
    return (normal.equals(s.normal) && c == s.c);
  }
  
}
