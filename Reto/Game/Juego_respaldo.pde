
final int WIDTH = 40;
final int HEIGHT = 5;
int[][] level = new int[HEIGHT][WIDTH];

import processing.sound.*;
SoundFile file;
String audioName = "Musica_1.mp3";
String path;

import processing.serial.*; 
 
Serial port;  
char inByte;
int val;

Player p1;
Player2 p2;

boolean right = false, left = false, up = false,x1=false,z=false;
 
 
 //SETUP/////////////////////////////
void setup() {
  size(595,420);
  //De donde va a caer
  p1 = new Player(WIDTH*5,HEIGHT*10);
  p2 = new Player2(WIDTH*10,HEIGHT*10);
  port = new Serial(this, "COM4", 9600); 

    //Musica
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.play();
}
void draw() {
  
  PImage bck; 
  bck = loadImage("Fondo2.png");
  background(bck);
  if (0 < port.available()){  // If data is available to read,
    val = port.read();
  }
 if (val==254){
   println(val);
     inByte='w';
     
   }
      inByte = 'z'; 
 else if(val==255){
   println(val);
     inByte='d';
}
   inByte = 'z'; 
 
   
   switch(inByte) {
    case 'd': right = true; break;
    case 'a': left = true; break;
    case 'w': up = true; break;
    case 'x': x1 = true; break;
    case 'z': z = true; break;
  
  }
p1.update();
  p1.display();
  p2.update();
  p2.display();
}//END DRAW///////////////////////////

 boolean place_free(int xx,int yy) {
   xx = int(floor(xx));
   yy = int(floor(yy));
  if (yy < height-height/8) {
      return true;
  }
  return false;
}
