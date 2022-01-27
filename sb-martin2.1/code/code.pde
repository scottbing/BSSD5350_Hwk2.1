import processing.pdf.*;

HelperFunctions hf = new HelperFunctions();

//Lesson 1.1
//Code taken from Daniel Shiffman's video below and modified with comments
// https://www.voutube.com/watch?v=o8dffr286os&list=PL6Uak5uKONDGXWAL99560YA D78 fM&index=9

int backgroundColor = 180;
int strokeW = 1;
int factor = height/16;
int padding = 20;
int x0, y0, x1, y1;    // Line start and end
float vpct = 0.29;     // Variation in line as %
float llength;         // Line length
float lthresh = 7.0;
int count = 0;


//setup is run one time when the program first starts
void setup() {
  //size(1024, 768, PDF, "color.pdf");  //size of canvas
  size(400, 400); //set the size of the screen.
  //strokeWeight(0);
  //strokeWeight (3);
  //stroke (97);
  frameRate(24);
  smooth(); //smoots animation from transition
  //Screen size must be set before the program is run!
  noLoop();  //only calls draw() once
}

//draw is called repeatedly and automatically for the life of the program after setup is called void draw() {
void draw() {
  ColorPalette randomC = new ColorPalette();
  swatchColor(randomC); //call to custom helper function below 
  //swatchColor(blendColors(color(randomC, randomC))); //call to custom helper function below 
  //hf.save("img", "["+String.valueOf(randomC.getBaseColor())+"]");
  //exit();
}

void swatchColor(ColorPalette cp) {
  vpct = 0.09;
  lthresh = 7;
  fill(cp.getBaseColor());
  rect(0, ( 0 * (height/16)), width, height/16);
  ldraw(0, ( 0 * (height/16)), width, ( 0 * (height/16)), lthresh, vpct);
  fill(cp.getAnalogues()[0]);
  rect(0, ( 1 * (height/16)), width, height/16); 
  ldraw(0, ( 1 * (height/16)), width, ( 1 * (height/16)), lthresh, vpct);
  fill(cp.getComplement());
  rect(0, ( 2 * (height/16)), width, height/16);
  ldraw(0, ( 2 * (height/16)), width, ( 2 * (height/16)), lthresh, vpct);
  fill(cp.getMonochromes()[1]);
  rect(0, ( 3 * (height/16)), width, height/16);
  ldraw(0, ( 3 * (height/16)), width, ( 3 * (height/16)), lthresh, vpct);
  fill(cp.getBaseColor());
  rect(0, ( 4 * (height/16)), width, height/16);
  ldraw(0, ( 4 * (height/16)), width, ( 4 * (height/16)), lthresh, vpct);
  fill(cp.getAnalogues()[1]);
  rect(0, ( 5 * (height/16)), width, height/16);
  ldraw(0, ( 5 * (height/16)), width, ( 5 * (height/16)), lthresh, vpct);
  fill(cp.getComplement());
  rect(0, ( 6 * (height/16)), width, height/16);
  ldraw(0, ( 6 * (height/16)), width, ( 6 * (height/16)), lthresh, vpct);
  fill(cp.getMonochromes()[0]);
  rect(0, ( 7 * (height/16)), width, height/16);
  ldraw(0, ( 7 * (height/16)), width, ( 7 * (height/16)), lthresh, vpct);
  
  fill(cp.getBaseColor());
  rect(0, ( 8 * (height/16)), width, height/16);
  ldraw(0, ( 8 * (height/16)), width, ( 8 * (height/16)), lthresh, vpct);
  fill(cp.getAnalogues()[0]);
  rect(0, ( 9 * (height/16)), width, height/16); 
  ldraw(0, ( 9 * (height/16)), width, ( 9 * (height/16)), lthresh, vpct);
  fill(cp.getComplement());
  rect(0, ( 10 * (height/16)), width, height/16);
  ldraw(0, ( 10 * (height/16)), width, ( 10 * (height/16)), lthresh, vpct);
  fill(cp.getMonochromes()[1]);
  rect(0, ( 11 * (height/16)), width, height/16);
  ldraw(0, (11 * (height/16)), width, ( 11 * (height/16)), lthresh, vpct);
  fill(cp.getBaseColor());
  rect(0, ( 12 * (height/16)), width, height/16);
  ldraw(0, ( 12 * (height/16)), width, ( 12 * (height/16)), lthresh, vpct);
  fill(cp.getAnalogues()[1]);
  rect(0, ( 13 * (height/16)), width, height/16);
  ldraw(0, ( 13 * (height/16)), width, ( 13 * (height/16)), lthresh, vpct);
  fill(cp.getComplement());
  rect(0, ( 14 * (height/16)), width, height/16);
  ldraw(0, ( 14 * (height/16)), width, ( 14 * (height/16)), lthresh, vpct);
  fill(cp.getMonochromes()[0]);
  rect(0, ( 15 * (height/16)), width, height/16);
  ldraw(0, ( 15 * (height/16)), width, ( 15 * (height/16)), lthresh, vpct);
  
}
  
void jaggedLine(float x1, float y1, float x2, float y2, int sparsity, float jitter){
 float dist = sqrt(sq(x2-x1) + sq(y2-y1));
 float lastX = x1;
 float lastY = y1;
 int offset = sparsity*strokeW;
 strokeCap(SQUARE);
 for (int i = offset; i <= dist-offset; i+=sparsity) {
    float x = lerp(x1, x2, i/dist);
    float y = lerp(y1, y2, i/dist);
    y += random(jitter);
    line(lastX, lastY, x, y);
    lastX = x;
    lastY = y; 
    strokeCap(ROUND); // at end so first cap is square still
 }
 strokeCap(SQUARE); // end of line needs to be square again
 //do from last x and y to the endpoint
 line(lastX, lastY, x2, y2);
}

void dottedLine(float x1, float y1, float x2, float y2) {
  float dist= sqrt(sq(x2-x1) + sq(y2-y1));
  strokeCap(ROUND);
  //line(x1, y1,x2, y2);
  int sparsity = 15;
  for (int i = 0; i <= dist; i+=sparsity) {
    float x = lerp(x1, x2, i/dist); //+40;
    float y = lerp(y1, y2, i/dist);
    point(x,y+random(5.0));
  }
}

color blendColors(color col, color bg) {
  //original psuedocode and math from this answer:
  // https://stackoverflow.com/a/2645218/255.0);
  float blendR = ((1.0 - (alpha(col)/255.0))*red(bg)/255.0) + (alpha(col)/255.0*red(col)/255.0);
  float blendG = ((1.0 - (alpha(col)/255.0))*green(bg)/255.0) + (alpha(col)/255.0*green(col)/255.0);
  float blendB = ((1.0 - (alpha(col)/255.0))*blue(bg)/255.0) + (alpha(col)/255.0*blue(col)/255.0);
  
  color blended = color(int(blendR*255), int(blendG+255), int(blendB*255));
  return blended;
}

void ldraw(int xs, int ys, int xe, int ye, float lthresh, float vpct)
{
    float ll, newLength, fraction;
    int xx, yy, nx, ny;
    
    ll = sqrt ( (xe-xs)*(xe-xs) + (ye-ys)*(ye-ys));
    xx = xs; yy = ys;
    while (true)        // Draw a line from (xx,yy) to (xe,ye)
    {
      newLength = random (lthresh, 2*lthresh);  // Draw a short segment
      fraction  = newLength/ll;                 // How much of the whole?
      nx = xx + (int) ((xe-xx) * fraction);
      if (random(1) < vpct) nx = nx + 1;
      else if (random(1) < vpct) nx = nx - 1;
      
      ny = yy + (int) ((ye-yy) * fraction);
      if (random(1) < vpct) ny = ny + 1;
      else if (random(1) < vpct) ny = ny - 1;
      

      line (xx, yy, nx, ny);
      xx = nx; yy = ny;
      ll = sqrt ( (xe-xx)*(xe-xx) + (ye-yy)*(ye-yy));
      if (ll <= lthresh)
      {
        line (xx, yy, xe, ye);
        return;
      }
    }
}
