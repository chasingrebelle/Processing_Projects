class Particle{

  PVector loc;
  PVector vel;
  PVector acc;
  PVector grav;
  PVector force;
  float radius;
  float MaxVel;
  float bounceLoss;
  
  Particle(float x_, float y_){
    loc = new PVector(x_, y_);
    vel = new PVector(random(4) - 2, random(4) - 2);
    acc = new PVector(0,0);
    grav = new PVector(0, 0.1);
    force = new PVector(0,0);
    MaxVel = 10;
    radius = 10;
    bounceLoss = 0.9;
  }
  
  void checkEdges() {
    if (loc.x > width - radius){
      vel.x = - vel.x * bounceLoss;
      loc.x = width - radius;
    }
    if (loc.x < radius){
      vel.x = - vel.x * bounceLoss;
      loc.x = radius;
    }
    if (loc.y > height - radius){
      vel.y = - bounceLoss * vel.y;
      vel.x = sqrt(bounceLoss) * vel.x;
      loc.y = height - radius;
    }
    if (loc.y < radius){
      vel.y = - vel.y * bounceLoss;
      vel.x = vel.x * sqrt(bounceLoss);
      loc.y = radius;
    }
  }
  
  void move(){
    checkEdges();
    acc = grav.add(force);
    vel.add(acc);
    vel.limit(MaxVel);
    loc.add(vel);
  }
  
  void show(){
    noStroke();
    fill(255);
    ellipse(loc.x, loc.y, radius, radius);
  }
  
}
