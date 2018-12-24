class Boid{
  PVector pos;
  PVector vel;
  float vision;
  
  Boid(){
    pos = new PVector(random(0, width), random(0, height));
    vel = new PVector(random(-1 * maxSpeed, maxSpeed), random(-1 * maxSpeed, maxSpeed));
    vision = 100;
  }
  
  void show(){
    stroke(255);
    strokeWeight(8);
    point(pos.x, pos.y);
    
    noFill();
    strokeWeight(1);
    ellipse(pos.x, pos.y, vision, vision);
    
    line(pos.x, pos.y, pos.x + vel.x * 20, pos.y + vel.y * 20);
  }
  
  void move(){
    clumping();
    // avoidance();
    schooling();
    limitVel();
    pos.add(vel);
    limitPos();
  }
  
  void clumping(){
    PVector vec = new PVector(0, 0);
    for (Boid b : birds){
      if (b == this){
        continue;
      }
      vec.add(b.pos);
    }
    vec.div(noBirds - 1);
    stroke(255,0,0);
    point(vec.x, vec.y);
    vel.add(vec.sub(pos));
  }
  
  void avoidance(){
    PVector vec = new PVector(0, 0);
    for (Boid b : birds){
      if (b == this){
        return;
      }
    }
  }
  
  void schooling(){
    PVector vec = new PVector(0, 0);
    for (Boid b : birds){
      if (b == this){
        continue;
      }
      vec.add(b.vel);
    }
    vec.div(noBirds-1);
    vel.add(vec.sub(vel));
  }
  void limitPos(){
    if (pos.x < 0){
      pos.x = 0;
      vel.x *= -1;
    }
    
    if (pos.x > width){
      pos.x = width;
      vel.x *= -1;
    }
    
    if (pos.y < 0){
      pos.y = 0;
      vel.y *= -1;
    }
    
    if (pos.y > height){
      pos.y = height;
      vel.y *= -1;
    }
  }
  
  void limitVel(){
    if (vel.x > maxSpeed){
      vel.x = maxSpeed;
    } 
    if (vel.x < -1 * maxSpeed){
      vel.x = -1 * maxSpeed;
    } 
    if (vel.y > maxSpeed){
      vel.y = maxSpeed;
    } 
    if (vel.y < -1 * maxSpeed){
      vel.y = -1 * maxSpeed;
    } 
  }
}
