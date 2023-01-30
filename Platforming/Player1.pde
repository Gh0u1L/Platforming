class FPlayer extends FGameObjects {

  //int Invincible = 30;
  int frame;
  int direction;
  final int L = -1;
  final int R = 1;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(0, 1343);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }

  void act() {
    Input();
    collisions();
    animate();
    IFrames();
  }

  void Input() {
    float vx = getVelocityX();
    float vy = getVelocityY();
    if (abs(vy) < 0.1) {
      action = idle;
    }
    if (akey) {
      setVelocity(-250, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(250, vy);
      action = run;
      direction = R;
    }
    if (wkey && BG (player)) {
      setVelocity(vx, -400);
    }
    if (abs(vy) > 0.1)
      action = jump;
  }


  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) {
        attachImage (action[frame]);
      }
      if (direction == L) attachImage (reverseImage(action[frame]));
      frame++;
    }
  }


  boolean BG(FPlayer map) {
    ArrayList<FContact> contactList = player.getContacts();
    int i = 0;
    while (i < contactList.size()) {
      FContact myContact = contactList.get(i);
      if (myContact.contains(map)) {
        return true;
      }
      i++;
    }
    return false;
  }

  void collisions() {
    if (IsTouching("spike") && BG == true) {
      Lives--;
      Invincible = 0;
    }
    if (Lives <= 0) {
      setPosition(0, 1343);
      Lives = 10;
    }
    if (IsTouching("Lava") && BG == true) {
      Lives--;
      Invincible = 0;
    }
    if (IsTouching("Thwomp") && BG == true) {
      Lives = Lives - 10;
      Invincible = 0;
    }
    if (IsTouching("Hammer") && BG == true) {
      Lives--;
      Invincible = 0;
    }
  }

  void IFrames() {
    if (Invincible < 30) {
      BG = false;
    } else {
      BG = true;
    }
    Invincible++;
  }
}
