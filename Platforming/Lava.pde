class FLava extends FGameObjects {

  int frame;

  FLava(float x, float y) {
    super();
    frame = 0;
    setPosition(x, y);
    setName("Lava");
    setRotatable(false);
  }

  void act() {
    animate();
    frame = (int) random(1, 6);
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(fire[frame]);
      frame++;
    }
  }
}
