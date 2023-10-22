class Circle {
  
  int x, y;
  color colorhex;
  
  // Constructor
  public Circle(int xpos, int ypos, color hexcolor) {
    x = xpos;
    y = ypos;
    colorhex = hexcolor;
  }
  
  void display() {
    noStroke();
    fill(colorhex);
    circle(x*fieldsize+fieldsize/2-offset, y*fieldsize+fieldsize/2, fieldsize/2);
  }
  
  void move (int dir) {
    //move in the direction of the gicen keycode
    switch(dir) {
      case UP:
        y = y<1 ? 0 : y-1;
        break;
      case DOWN:
        y = y>3 ? 4 : y+1;
        break;
      case RIGHT:
        x = x>3 ? 4 : x+1;
        break;
      case LEFT:
        x = x<1 ? 0 : x-1;
        break;
      default:
        break;
    }
  }
}
