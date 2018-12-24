class Point{
  
  float x, y;
  
  Point(float x_, float y_){
    x = x_;
    y = y_;
  }
  
}

//---------------------------------------------------------------------------------

class Rectangle{
  float x, y;
  float w, h;
  
  Rectangle(float x_, float y_, float w_, float h_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  Rectangle(Rectangle other){
    this.x = other.x;
    this.y = other.y;
    this.w = other.w;
    this.h = other.h;
  }
  
  Boolean contains(Point p){
    return(
    p.x >= x - w && 
    p.x <= x + w &&
    p.y >= y - h &&
    p.y <= y + h);
  }
  
  boolean intersects(Rectangle range){
    return!(
    range.x - range.w > this.x + this.w ||
    range.x + range.w < this.x - this.w ||
    range.y - range.h > this.y + this.h ||
    range.y + range.h < this.y - this.h);
  }
  
  boolean intersects(Circle range){
    float xDist = abs(range.x - this.x);
    float yDist = abs(range.y - this.y);
    float edges = (xDist - w)*(xDist - w) + (yDist - h)*(yDist - h);
    if (xDist > (range.r + w) || yDist > (range.r + h)){
      return false;
    }
    if (xDist <= w || yDist <= h){
      return true;
    }
    return edges <= range.rSq;
  }
}

//---------------------------------------------------------------------------------

class Circle{
  float x, y, r;
  float rSq;
  
  Circle(float x_, float y_, float r_){
    x = x_;
    y = y_;
    r = r_;
    rSq = this.r * this.r;
  }
  
  Circle (Circle other){
    this.x = other.x;
    this.y = other.y;
    this.r = other.r;
    this.rSq = other.rSq;
  }
  
  Boolean contains(Point p){
    float distSq = (p.x - this.x)*(p.x - this.x) + (p.y - this.y)*(p.y - this.y);
    return distSq <= rSq;
  }
}

//---------------------------------------------------------------------------------

class QuadTree{
  Rectangle boundary;
  int capacity;
  ArrayList<Point> points;
  boolean isDivided;
  
  QuadTree northWest, northEast, southWest, southEast;
  
  QuadTree(Rectangle b, int n){
    this.boundary = new Rectangle(b);
    this.capacity = n;
    this.isDivided = false;
    this.points = new ArrayList<Point>();
  }
 
 
  void subdivide(){
    
    float x = this.boundary.x;
    float y = this.boundary.y;
    float w = this.boundary.w * 0.5;
    float h = this.boundary.h * 0.5;
    
    Rectangle ne = new Rectangle(x + w, y - h, w, h);
    Rectangle nw = new Rectangle(x - w, y - h, w, h);
    Rectangle se = new Rectangle(x + w, y + h, w, h);
    Rectangle sw = new Rectangle(x - w, y + h, w, h);
    
    this.northWest = new QuadTree(nw, this.capacity);
    this.northEast = new QuadTree(ne, this.capacity);
    this.southWest = new QuadTree(sw, this.capacity);
    this.southEast = new QuadTree(se, this.capacity);
    isDivided = true;
  }
  
  
  Boolean insert(Point p){
    if(!this.boundary.contains(p)){
      return false;
    }
    if (points.size() < this.capacity){
      points.add(p);
      return true;
    }
      
    if(!isDivided){
      subdivide();
    }
    
    return(
    northEast.insert(p)||
    northWest.insert(p)||
    southEast.insert(p)||
    southWest.insert(p));
  }
  
  ArrayList<Point> query(Rectangle range, ArrayList<Point> found){
    if (found == null){
      found = new ArrayList<Point>();
    }
    if (this.boundary.intersects(range)){
      
      for (Point p : points){
        if (range.contains(p)){
          found.add(p);
        }
      }
      
      if (isDivided){
        northWest.query(range, found);
        northEast.query(range, found);
        southWest.query(range, found);
        southEast.query(range, found);
      }
    }
    return found;
  }
  
  
  void show(){
    noFill();
    stroke(255);
    strokeWeight(1);
    rectMode(CENTER);
    rect(this.boundary.x, this.boundary.y, this.boundary.w*2, this.boundary.h*2);
    
    if (isDivided){
      this.northEast.show();
      this.northWest.show();
      this.southEast.show();
      this.southWest.show();
    }
    stroke(255, 0, 100);
    strokeWeight(4);
    for (Point p : points){
      point(p.x, p.y);
    }
  }
  
  ArrayList<Point> query(Circle range, ArrayList<Point> found){
    if (found == null){
      found = new ArrayList<Point>();
    }
    if (this.boundary.intersects(range)){
      
      for (Point p : points){
        if (range.contains(p)){
          found.add(p);
        }
      }
      
      if (isDivided){
        northWest.query(range, found);
        northEast.query(range, found);
        southWest.query(range, found);
        southEast.query(range, found);
      }
    }
    return found;
  }
}
