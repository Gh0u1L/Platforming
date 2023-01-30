import fisica.*;
FWorld world;

int Lives;
int Invincible = 30;

color Indigo = #3f48cc;
color Turq = #00a8f3;
color grey = #585858;
color yellow = #fff200;
color orangeFire = #ff3a17;
color pink = #ff30a9;
color treeGreen = #54ff4b;
color iceBlock = #83f7ff;
color treeBrown = #ce5c0a;
color white = #FFFFFF;
color black = #000000;
color green = #00FF00;
color red = #FF0000;
color blue = #0000FF;
color orange = #F0A000;
color brown = #996633;
color purple = #cb19cb;
color trampolinePurple = #b83dba;

PImage map, ice, stone, treeTrunk, treeIntersect, treetop, treetopE, treetopW, spike, bridge, hammer, tramp, Thwomp, bedgeThwomp;
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] idle1;
PImage[] jump1;
PImage[] run1;
PImage[] action1;
PImage[] action;
PImage[] fire;
PImage[] goomba;
PImage[] Hamma;
int gridSize = 32;
float Z = 2;
boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey;
boolean BG;
FPlayer player;
//FPlayer2 player2;
ArrayList<FGameObjects> terrain;
ArrayList<FGameObjects> enemies;


void setup() {
  size (1600, 1600);
  Fisica.init(this);

  terrain = new ArrayList<FGameObjects>();
  enemies = new ArrayList<FGameObjects>();

  loadImages();
  loadWorld(map);
  loadPlayer();
  Lives = 10;
}

void loadImages() {
  map = loadImage("level1.png");
  ice = loadImage("ice.png");
  treeTrunk = loadImage("tree_trunk.png");
  ice.resize(32, 32);
  stone = loadImage("stone.png");
  treeIntersect = loadImage("tree_intersect.png");
  treetop = loadImage("treetop_center.png");
  treetopE = loadImage("treetop_e.png");
  treetopW = loadImage("treetop_w.png");
  spike = loadImage("spike.png");
  bridge = loadImage("bridge_center.png");
  hammer = loadImage("hammer.png");
  tramp = loadImage("trampoline.png");
  bedgeThwomp = loadImage("thwomp0.png");
  Thwomp = loadImage("thwomp1.png");

  Hamma = new PImage[2];
  Hamma[0] = loadImage("hammerbro0.png");
  Hamma[1] = loadImage("hammerbro1.png");

  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  fire = new PImage[6];
  fire[0] = loadImage("lava0.png");
  fire[1] = loadImage("lava1.png");
  fire[2] = loadImage("lava2.png");
  fire[3] = loadImage("lava3.png");
  fire[4] = loadImage("lava4.png");
  fire[5] = loadImage("lava5.png");

  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  action = idle;
  
  //idle1 = new PImage[2];
  //idle1[0] = loadImage("Luigi1.png");
  //idle1[1] = loadImage("Luigi1.png");
  //idle1[1].resize(gridSize, gridSize);
  //idle1[0].resize(gridSize, gridSize);

  //jump1 = new PImage[1];
  //jump1[0] = loadImage("Luigi2.png");
  //jump1[0].resize(gridSize, gridSize);

  //run1 = new PImage[3];
  //run1[0] = loadImage("Luigi5.png");
  //run1[0].resize(gridSize, gridSize);
  //run1[1] = loadImage("Luigi2.png");
  //run[1].resize(gridSize, gridSize);

  //action1 = idle1;
}

void loadWorld(PImage img) {
  world = new FWorld(-1000, -1000, 5000, 5000);
  world.setGravity(0, 980);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y);
      color s = img.get(x, y+1);
      color w = img.get(x-1, y);
      color e = img.get(x+1, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      if (c == black) {
        b.attachImage(stone);
        b.setFriction(10);
        b.setName("stone");
        world.add(b);
      } else if (c == grey) {
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == iceBlock) {
        b.attachImage(ice);
        b.setFriction(0);
        b.setName("ice");
        world.add(b);
      } else if (c == treeBrown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("treetrunk");
        world.add(b);
      } else if (c == treeGreen && s == treeBrown) {
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
      } else if (c == treeGreen && w == treeGreen && e == treeGreen) {
        b.attachImage(treetop);
        b.setFriction(6);
        b.setName("treetop");
        world.add(b);
      } else if (c == treeGreen && w != treeGreen) {
        b.attachImage(treetopW);
        b.setFriction(6);
        b.setName("treetop");
        world.add(b);
      } else if (c == treeGreen && e != treeGreen) {
        b.attachImage(treetopE);
        b.setFriction(6);
        b.setName("treetop");
        world.add(b);
      } else if (c == purple) {
        b.attachImage(spike);
        b.setFriction(10);
        b.setRestitution(1);
        b.setName("spike");
        world.add(b);
      } else if (c == pink) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == orangeFire) {
        FLava L = new FLava(x*gridSize, y*gridSize);
        terrain.add(L);
        world.add(L);
      } else if (c == trampolinePurple) {
        b.attachImage(tramp);
        b.setFriction(5);
        b.setRestitution(3);
        b.setName("trampoline");
        world.add(b);
      } else if (c == Indigo) {
        FThwomp T = new FThwomp(x*gridSize, y*gridSize);
        enemies.add(T);
        world.add(T);
      } else if (c == Turq) {
        FHamma H = new FHamma(x*gridSize, y*gridSize);
        enemies.add(H);
        world.add(H);
      }
    }
  }
}
void loadPlayer() {
  player = new FPlayer();
  //player2 = new FPlayer2();
  //world.add(player2);
  world.add(player);
}

void draw() {
  background(white);
  drawWorld();
  actWorld();
  ShowLives();
  Ibar();
}

void Ibar() {
  if (Invincible < 30) {
    rectMode(CORNER);
    noStroke();
    fill(black);
    rect(785, 740, 30, 15);
    fill(red);
    rect(785, 740, Invincible, 15);
    rectMode(CENTER);
  }
}

void ShowLives() {

  if (Lives <= 3) {
    fill(red);
  } else if (Lives <= 6) {
    fill(yellow);
  } else {
    fill (green);
  }

  textSize(75);
  text(""+Lives+"", 100, 100);
}

void actWorld() {
  player.act();
  //player2.act();

  for (int i = 0; i < terrain.size(); i++) {
    FGameObjects TR = terrain.get(i);
    TR.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObjects EN = enemies.get(i);
    EN.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*Z+width/2, -player.getY()*Z+height/2);
  scale(Z);
  world.step();
  world.draw();
  popMatrix();
}
