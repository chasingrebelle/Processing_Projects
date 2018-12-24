Circle[] circles;

int noCircles = 10;
float iterations = 10;


void setup(){
  size(1000,1000);
  background(0);
  
  circles = new Circle[noCircles];
  for (int i = 0; i < noCircles; i++){
    circles[i] = new Circle(random(width),random(height));
  }
}



void draw(){
  background(0);
  
  for (int i = 0; i < iterations/i; i++){
  
    for (Circle c : circles){
      for (Circle d : circles){
        if (c != d){
          c.checkCollision(d);
        }
      }
      c.update();
    }
  }
  
}
