int numberOfDots = 30;
int minLinks = 6;
int maxLinks = 14;

int[][] links = new int[numberOfDots][maxLinks];           // which dots are linked
float[][] XYCoords = new float[numberOfDots][2];    // current XY coordinates of dots
long prevFrameCount;
long currentFrameCount;

int[][] status = new int[numberOfDots][2];    // status of each dot

float[][] destXYCoords = new float[numberOfDots][2];    // destination XY coordinates of dots

int[] waitTime = new int[numberOfDots];  //stores the remaining wait time for paused dots

void setup(){
  size(400,400); //canvas size
  linkDots();
  setFirstCoords();
  
  for (int i = 0; i< numberOfDots; i++){  //set destination coordinate for all dots
    setDestCoords(i);
  }
}

void draw(){
  background(255);
  drawDots();
  drawLinks();
  
  //drawCenterLinks();
  //ellipse(200, 200, 6, 6);
  
  for (int x=0; x<numberOfDots; x++){
    moveDot(x,0);
    moveDot(x,1);
    editDotStatus(x);
    checkDotStatus(x);
    }
}

/*
define number of dots - done
define which dots are linked together (each must have 3 or more connections) - done

plot starting co-ordinates for each dot - done
plot co-ordinates for dot to navigate to - done

draw lines between linked dots - done

wait between 5 and 50 seconds - done
move dots until co-ordinate is reached

when co-ordinate reached, 
wait between 5 and 50 seconds then pick a new co-ordinate
- must be -25 to +25 from current x and y and be within 10px from canvas edge
*/

void linkDots(){        // randomly select which dots are linked together
  for (int x=0; x<numberOfDots; x++){
    float a = random(minLinks,maxLinks);
    int numLinks = int(a);
    println(x + " linked to: ");
    for (int y=0; y < numLinks; y++){
      float b = random(numberOfDots);
      int c = int(b);
      while(c == x){      // while that link has already been picked then pick again
       b = random(numberOfDots);
       c = int(b);
      }
      links[x][y] = c;
      print(c + ", ");
    }
     println("");
  }
}

void drawDots(){    // draw the dots
  for (int x=0; x<numberOfDots ; x++){    
      fill(0);
      ellipse(XYCoords[x][0], XYCoords[x][1], 6, 6);    //draw circle
    }
}

void setFirstCoords(){      // select start X Y coordinates of each dot
  for (int x=0; x<numberOfDots; x++){
    float v = random(2);
    float w = random(2);
    int a = int(v);
    int b = int(w);
    XYCoords[x][0] = pickGrid(a);
    XYCoords[x][1] = pickGrid(b);
  }
}

void setDestCoords(int x){      // select new X Y coordinates of each dot
    float v = random(2);
    float w = random(2);
    int a = int(v);
    int b = int(w);
    destXYCoords[x][0] = pickGrid(a);
    destXYCoords[x][1] = pickGrid(b);
    //println(x + " " + destXYCoords[x][0] + " " + destXYCoords[x][1]);
}

void setWaitTime(int x){      // set wait time before moving
    float a = random(4,15);
    int b = int(a);
    waitTime[x] = b;
}

void drawLinks(){        // draw lines between linked dots
  for (int x=0; x<numberOfDots; x++){
    for (int y=0; y<maxLinks; y++){
      if (links[x][y] > 0){
        line(XYCoords[x][0], XYCoords[x][1], XYCoords[y][0], XYCoords[y][1]);
      }
    }
  }
}

void drawCenterLinks(){        // draw lines to center
  for (int x=0; x<numberOfDots; x++){
        line(XYCoords[x][0], XYCoords[x][1], 200, 200);
  }
}

void moveDot(int v, int xy){
  if (XYCoords[v][xy] < destXYCoords[v][xy]){ 
    XYCoords[v][xy]++;
  }
  else if (XYCoords[v][xy] > destXYCoords[v][xy]){ 
    XYCoords[v][xy]--;
  }
  
}

void editDotStatus(int x){
    if(XYCoords[x][0] > destXYCoords[x][0]){
      if((XYCoords[x][0] - destXYCoords[x][0]) <1){
        status[x][0] = 1;
      }
  }
    if(XYCoords[x][0] <= destXYCoords[x][0]){
      if((destXYCoords[x][0] - XYCoords[x][0]) <1){
        status[x][0] = 1;
      }
  }
  if(XYCoords[x][1] > destXYCoords[x][1]){
      if((XYCoords[x][1] - destXYCoords[x][1]) <1){
        status[x][1] = 1;
      }
  }
    if(XYCoords[x][1] <= destXYCoords[x][1]){
      if((destXYCoords[x][1] - XYCoords[x][1]) <1){
        status[x][1] = 1;
      }
  }
}

void checkDotStatus(int x){
  if(status[x][0] == 1 && status[x][1] == 1){
    setDestCoords(x);
    status[x][0] = 0;
    status[x][1] = 0;
  }
}

float pickGrid(int x){
  float y = 0;
  if (x==0){
    y = random(40,140);
  }
  /*if (x==1){
    y = random(160,220);
  }*/
  if (x==1){
    y = random(260,360);
  }
  return y;
}
