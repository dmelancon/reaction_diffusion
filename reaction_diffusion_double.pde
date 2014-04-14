
int w=100;
int h=100;

double[][] aVal = new double[w][h];
double[][] bVal =  new double[w][h];
double[][] newA = new double[w][h];
double[][] newB = new double[w][h];

double[] lapA = new double[w*h];
double[] lapB = new double[w*h];
double diffusionA, diffusionB;
double reactionRateA, reactionRateB;
double replenishmentA, replenishmentB;
double diffusionRateA = 1.0;
double diffusionRateB = .5;
double feedRate = .0367;
double killRate = .0649;
double time = 1.0;
boolean isClicked = false;

void setup() {
  size(w, h);
  //frameRate(180);
  for (int x=0; x < w; x++) {
    for (int y=0; y < h; y++) {
      //      println("x: " + x );
      //      println("y: " + y);
      aVal[x][y] = 1.0;
      bVal[x][y] = 0.1;
    }
  }
}
void draw() {
  println(frameRate);
  //background(255);
  laplace();
  update();
  //colorMode(HSB);
  loadPixels();
   for (int x=0;x<w;x++) {
   for (int y=0;y<h;y++) {
   pixels[x+y*w] = color(newA[x][y]*255);
   
   }
   }
   updatePixels();
}


void update() {
  //laplace();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      diffusionA = diffusionRateA*lapA[x+y*w];
      diffusionB = diffusionRateB*lapB[x+y*w];
      reactionRateA = -aVal[x][y]*bVal[x][y]*bVal[x][y];
      reactionRateB = aVal[x][y]*bVal[x][y]*bVal[x][y];
      replenishmentA = feedRate*(1-aVal[x][y]);
      replenishmentB = -(killRate+feedRate)*bVal[x][y];
      newA[x][y] = aVal[x][y] +(diffusionA +reactionRateA + replenishmentA)*time;
      newB[x][y] = bVal[x][y] +(diffusionB +reactionRateB + replenishmentB)*time;
    }
  }
  aVal = newA;
  bVal = newB;
  //println(newA.length);
  //println(aVal.length);
}

void laplace() {
  for (int x = 1; x < w-1; x++) {
    for (int y = 1; y < h-1; y++) {
      double templapA =
        aVal[x][y+1] * .2+
        aVal[x][y-1]* .2+
        aVal[x+1][y]* .2+
        aVal[x-1][y]* .2+
        aVal[x+1][y+1]* .05+
        aVal[x-1][y+1]* .05+
        aVal[x+1][y-1]* .05+
        aVal[x-1][y-1]* .05+
        aVal[x][y]* -1.0;
      lapA[x+y*width] = templapA;
       templapB =
        bVal[x][y+1] * .2+
        bVal[x][y-1]* .2+
        bVal[x+1][y]* .2+
        bVal[x-1][y]* .2+
        bVal[x+1][y+1]* .05+
        bVal[x-1][y+1]* .05+
        bVal[x+1][y-1]* .05+
        bVal[x-1][y-1]* .05+
        bVal[x][y]* -1.0;
      lapB[x+y*width] = templapB;
    }
  }
}

void mousePressed() {

  //bVal[mouseX][mouseY]=1.0;
  for ( int x= mouseX-5; x<mouseX+5; x++) {
    for (int y=mouseY -5; y<mouseY+5; y++) {
      bVal[x][y] = 1.0;
    }
  }
  isClicked = true;
}

void mouseDragged() {
  if (isClicked == true) {
    for ( int x= mouseX-1; x<mouseX+1; x++) {
      for (int y=mouseY -1; y<mouseY+1; y++) {

        bVal[x][y] = 1.0;
      }
    }
  }
}

