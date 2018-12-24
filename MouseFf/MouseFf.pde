FF[][] ffs;
Particle[] particles;
int noParticles = 10;

void setup(){
  size (1000, 1000);
  // colorMode(HSB,PI,100,100);
  ffs = new FF[width][height];
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++){
      ffs[x][y] = new FF(x, y);
    }
  }
  
  particles = new Particle[noParticles];
  for (int i = 0; i < noParticles; i++){
    particles[i] = new Particle();
  }
}

void draw() {
  background(0);
  loadPixels();
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++){
      
      ffs[x][y].update();
      //ffs[x][y].show();
    }
  }
  updatePixels();
  
  for (Particle p : particles){
    p.checkEdges();
    p.move(ffs[floor(p.loc.x)][floor(p.loc.y)].force);
      for (Particle q : particles){
        if (p != q){
          Particle old_q = new Particle();
          q.copy(old_q);
          q.checkCollision(p);
          p.checkCollision(old_q);
        }
      }
    
    
    p.show();
  }
}

class FF{
  PVector loc;
  PVector force;
  PVector mouse;
  
  FF(float x_, float y_){
    loc = new PVector (x_, y_);
    force = new PVector(0,0);
    rectMode(CENTER);
    
  }
  
  void update(){
    mouse = new PVector(mouseX, mouseY);
    force = PVector.sub(mouse, loc);
    force.x /= width;
    force.y /= height;
  }
  
  void show(){
    //noStroke();
    float angle = force.heading()/2;
    if (sin(force.heading()) < 0){
      angle += PI;
    }
    
    //fill(angle, force.mag()*100, 100);
    //rect(loc.x - cellWidth/2, loc.y - cellWidth/2, cellWidth, cellWidth);
    int pix = floor(loc.x) + width * floor(loc.y);
    
    pixels[pix] = color(angle, force.mag()*100, 100);
  }
  
}

class Particle{
  PVector loc;
  PVector vel;
  PVector acc;
  float topSpeed;
  float radius;
  float friction;
  float mass;
  
  Particle(){
    loc = new PVector(random(width),random(height));
    vel = new PVector(0,0);//new PVector(random(10), random(10));
    acc = new PVector(0,0);
    mass = random(5, 15);
    topSpeed = 20;
    radius = mass;
    friction = 0.999;
  }
  
  void move(PVector force){
    acc = force.div(mass).mult(1);
    vel.add(acc);
    vel.limit(topSpeed);
    vel.mult(friction);
    loc.add(vel);
  }  
  
  void checkCollision(Particle other){
    float diffSq = PVector.sub(loc,other.loc).magSq();
    if (diffSq < (radius + other.radius) * (radius + other.radius)*0.99){
      float multi = 2 * other.mass/(mass + other.mass) * PVector.dot(PVector.sub(vel, other.vel), PVector.sub(loc, other.loc)) / diffSq;
      vel = PVector.sub(vel, PVector.sub(loc, other.loc).mult(multi));
      loc.add(vel) ;
    }
  }
  
  void checkEdges() {
    if (loc.x > width - radius){
      vel.x = - vel.x;
      loc.x = width - radius;
    }
      
    if (loc.x < radius){
      vel.x = - vel.x;
      loc.x = radius;
    }
    
    if (loc.y > height - radius){
      vel.y = - vel.y;
      loc.y = height - radius;
    }
      
    if (loc.y < radius){
      vel.y = - vel.y;
      loc.y = radius;
    }
  }
  
  void copy(Particle copied){
    copied.loc = loc;
    copied.vel = vel;
    copied.acc = acc;
    copied.topSpeed = topSpeed;
    copied.radius = radius;
    copied.friction = friction;
    copied.mass = mass;
  }
  
  void show(){
    noStroke();
    fill(255);
    ellipse(loc.x, loc.y, radius, radius);
  }
}
