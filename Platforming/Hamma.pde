class FHamma extends FGoomba {

  FHamma(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setName("Hamma");
    setRotatable(false);
  }

  void act() {
    AXE();
    animate();
    move();
    collide();
  }

  void AXE() {
    int count = 0;
    if (count >= 120) count = 0;
    if (frameCount % 60 == 0) {
      FBox Hammer = new FBox(gridSize, gridSize);
      Hammer.setPosition(getX(), getY());
      Hammer.attachImage(hammer);
      Hammer.setSensor(true);
      if (direction == R) Hammer.setVelocity(100, -500);
      if (direction == L) Hammer.setVelocity(-100, -500);
      Hammer.setAngularVelocity(500);
      Hammer.setName("Hammer");
      count++;
      world.add(Hammer);
    }
  }

  void animate() {
    if (frame >= Hamma.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(Hamma[frame]);
      if (direction == L) attachImage(reverseImage(Hamma[frame]));
      frame++;
    }
  }
}
