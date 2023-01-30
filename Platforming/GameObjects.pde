class FGameObjects extends FBox {

  final int L = -1;
  final int R = 1;

  FGameObjects() {
    super(gridSize, gridSize);
  }


  void act() {
  }

  FGameObjects(int w, int h) {
    super(w, h);
  }

  boolean IsTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }
}
