class FBridge extends FGameObjects {

  FBridge(float x, float y) {
    super();
    setPosition(x, y);
    setName("bridge");
    attachImage(bridge);
    setStatic(true);
  }

  void act() {
    if (IsTouching("player")) {
      setStatic(false);
      setSensor(true);
    }
    //if (IsTouching("player2")) {
    //  setStatic(false);
    //  setSensor(true);
    //}
  }
}
