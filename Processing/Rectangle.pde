class Rectangle {
 
  int x, y;
  int dir;
  
  // Constructor
  public Rectangle(int xpos, int ypos) {
    x = xpos;
    y = ypos;
  }
  
  void move (int dir) {
    //move in the direction of the given keycode
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
  
  void display() {
    noStroke();
    fill(#FF0808);
    rect (x*fieldsize+50, y*fieldsize+50, fieldsize-100, fieldsize-100);
  }
  
  int getx(){
    return x;
  }
  
  int gety(){
    return y;
  }
  
}
