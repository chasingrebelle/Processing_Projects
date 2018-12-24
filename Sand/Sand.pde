int noParticles = 5;
Particle[] particles;

void setup(){
  size(600, 400);
  particles = new Particle[noParticles];
  
  for (int i = 0; i < noParticles; i++){
    particles[i] = new Particle(random(width), random(height)); //<>//
  }

}

void draw(){
  background(0);
  for (Particle p : particles){ //<>//
    p.move(); //<>//
    p.show();
  }
  println(frameRate);
}
