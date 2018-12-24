class Point{
  
  float x;
  float y;
  
  Point(float x_, float y_){
    x = x_;
    y = y_;
  }
  
  void show(){
    strokeWeight(1);
    point(x,y);
  }
  
}
