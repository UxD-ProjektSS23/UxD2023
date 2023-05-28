class Grid {
  
  int spaces;
  
  public Grid (int size) {
    spaces = size;
  }
  
  void display(){
    stroke(126);
    strokeWeight(10);
    
    //draw enough lines to make the required spaces in the grid
    for (int i = 0; i < spaces+1; i++) {
    line(0, i*fieldsize, 1000, i*fieldsize);
    line(i*fieldsize, 0, i*fieldsize, 1000);
    }
  }
}
