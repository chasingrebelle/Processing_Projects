class Circle{
  float x;
  float y;
  float radius;
  float growthRate;
  boolean collided;
  
  Circle(float x_, float y_){
    x = x_;
    y = y_;
    radius = 0;
    growthRate = 2/iterations;
    collided = false;
  }
  
  void checkCollision(Circle other){
    if (collided == true){
      return;
    }
    float xDiff = x - other.x;
    float yDiff = y - other.y;
    if(yDiff * yDiff + xDiff * xDiff < (radius + other.radius)*(radius + other.radius)){
      collided = true;
    }
  
  }
  
  void update(){
    if (collided != true){
      radius += growthRate;
    }
    stroke(255,10);
    fill(255,10);
    ellipse(x, y, 2 * radius, 2 * radius);
  }
}
