class FThwomp extends FGameObjects {

  FThwomp(float x, float y) {
    super(gridSize*2, gridSize*2);
    setPosition(x+gridSize/2, y+gridSize/2);
    setName("Thwomp");
    setRotatable(false);
    setStatic(true);
    attachImage(bedgeThwomp);
  }

  void act() {
    target();
  }

  void target() {
    if (player.getX() > getX() - 50 && player.getX() < getX()) {
      setStatic(false);
      attachImage(Thwomp);
    }
    //if (player2.getX() > getX() - 50 && player2.getX() < getX()) {
    //  setStatic(false);
    //  attachImage(Thwomp);
    //}
  }
}
