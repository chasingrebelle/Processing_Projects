float friction = 1;
float drag = 0.9999;
float gravity = 0.5;
int pts = 6;
int stcks = 5;

ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Stick> sticks = new ArrayList<Stick>();

void setup(){
  size(800,600);
  for (int i = 0; i < pts; i++){
    float randx = random(350, width - 350);
    float randy = random(100, 300);
    Point p = new Point(randx, randy, randx + random(-5, 5), randy + random(-5, 5));
    points.add(p);
  }
  for (int i = 0; i < stcks; i++){
    if(i < stcks - 1){
      Stick s = new Stick(points.get(i), points.get(i + 1), distance(points.get(i), points.get(i + 1)));
      sticks.add(s);
    }else{
      Stick s = new Stick(points.get(stcks), points.get(0), distance(points.get(stcks), points.get(0)));
      sticks.add(s);
    }
    //if(i < stcks - 1){
    //  Stick s = new Stick(points.get(i), points.get(i + 2), distance(points.get(i), points.get(i + 2)));
    //  sticks.add(s);
    //}else{
    //  Stick s = new Stick(points.get(stcks - 3), points.get(0), distance(points.get(stcks - 3), points.get(0)));
    //  sticks.add(s);
    //}
  }
  //Stick s1 = new Stick(points.get(2), points.get(0), distance(points.get(2), points.get(0)));
  //sticks.add(s1);
  //Stick s2 = new Stick(points.get(1), points.get(3), distance(points.get(1), points.get(3)));
  //sticks.add(s2);
}

void draw(){
  background(0);
  for (Point p : points){
    p.updatePoint();
    p.renderPoint();
  }
  for (Stick s : sticks){
    s.updateStick();
    s.renderStick(); //<>//
  }
  
}

float distance(Point a, Point b){
  float dist = sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
  return dist;
}

class Point{
  
  float x;
  float y;
  float oldX;
  float oldY;
  
  Point(float x_, float y_, float oldX_, float oldY_){
    x = x_;
    y = y_;
    oldX = oldX_;
    oldY = oldY_;
  }
  
  void updatePoint(){
    float vx = x - oldX;
    float vy = y - oldY;
    oldX = x;
    oldY = y;
    x += vx * drag;
    y += vy * drag;
    y += gravity;
    
    if(x > width){
      x = width;
      oldX = x + vx * friction;
    }else if(x < 0){
      x = 0;
      oldX = x + vx * friction;
    }
    if(y > height){
      y = height;
      oldY = y + vy * friction;
    }else if(y < 0){
      y = 0;
      oldY = y + vy * friction;
    }
  }
  
  void renderPoint(){
    strokeWeight(8);
    stroke(255);
    point(x, y);
  }
}

class Stick{
  Point p0;
  Point p1;
  //float maxLength;
  //float minLength;
  float idealLength;
  
  Stick(Point pa, Point pb, float idealLength_){
    p0 = pa; p1 = pb; 
    //maxLength = maxLength_; minLength = minLength_; 
    idealLength = idealLength_;
  }
  
  void updateStick(){
    float dx = p1.x - p0.x;
    float dy = p1.y - p0.y;
    float dist = sqrt(dx*dx + dy*dy);
    float diff = this.idealLength - dist;
    float percent = diff / dist / 2;
    float offsetX = dx * percent;
    float offsetY = dy * percent;
    p0.x -= offsetX;
    p0.y -= offsetY;
    p1.x += offsetX;
    p1.y += offsetY;
  }
  
  void renderStick(){
    stroke(255);
    strokeWeight(2);
    line(p0.x, p0.y, p1.x, p1.y);
  }
}
