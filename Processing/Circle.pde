class Circle {
 
  int x, y;
  
  // Constructor
  public Circle(int xpos, int ypos) {
    x = xpos;
    y = ypos;
  }
  
  void display() {
    noStroke();
    fill(#F6FF08);
    circle(x*fieldsize+100, y*fieldsize+100, 100);
  }
  
  void move (int dir) {
    //move in the direction of the gicen keycode
    switch(dir) {
      case UP: 
        y = y-1;
        break;
      case DOWN: 
        y = y+1;
        break;
      case RIGHT: 
        x = x+1;
        break;
      case LEFT: 
        x = x-1;
        break;
      default:
        break;
    }
  }
}
