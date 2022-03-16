class Player {
  int x,y;
  float xSpeed,ySpeed;
  float accel,deccel;
  float maxXspd,maxYspd;
  float xSave,ySave;
  int xRep,yRep;
  float gravity;
  float state;
  float stateRate;
  float stateShift;
  int charXShift;
  int charYShift;
  int pace;
  
  Player(int _x, int _y ) {
    x = _x;
    y = _y;
    xSpeed = 0;
    ySpeed = 0;
    accel = 0.5;
    deccel = 0.5;
    maxXspd = 2;
    maxYspd = 12;
    xSave = 0;
    ySave = 0;
    xRep = 0;
    yRep = 0;
    gravity = 0.3;
    stateRate = .1;
    stateShift = 2;
    charXShift = 22;
    charYShift = 42;
    pace = 2;
  }
  
  void update() {
    //Aqui ponemos lo que hará la imagen
    if ( (right) ) {
      xSpeed += accel;
      if ( xSpeed > maxXspd ) {
        xSpeed = maxXspd;
      }
      state = state + stateRate;
            if (state >2) {
            state =  stateRate;
           }
    }
    //MOV
    else if ( (left) ) {
      xSpeed -= accel;
      if ( xSpeed < -maxXspd ) {
        xSpeed = -maxXspd;
      }
      state = state - stateRate;
            if (state <-2) {
            state = - stateRate;
           }
    }
        //Movimiento especial
    else if ( x1)  {
      //state=3;
      //cout<<state;
     // state=state;
     state =3;
      state = state + stateRate;
            if (state >6) {
           state =  stateRate;
           }
     }
     else if ( z)  {
      state=0;
      }
    else { //neither right or left pressed, decelerate
      state = 0;
      if ( xSpeed > 0 ) {
        xSpeed -= deccel;
        if ( xSpeed < 0 ) {
           xSpeed = 0;
        }
      }
      if ( xSpeed < 0 ) {
        xSpeed += deccel;
        if ( xSpeed > 0 ) {
           xSpeed = 0;
        }
      }
    }
     
    if ( (/*pos==*/up) ) {
      if ( !place_free(x,y+pace) && !place_free(x+charXShift,y+pace)) {
        ySpeed = -4.3;
      }
    }
    ySpeed += gravity;
    
    int signX = (xSpeed<0) ? -pace : pace;
    int signY = (ySpeed<0) ? -pace : pace;
                 println("signX is" + signX);
                 println("signY is" + signY);
        
    xRep += floor(abs(xSpeed));
    yRep += floor(abs(ySpeed));
                 println(xRep);
                 println("yRep is" + yRep);             
                 
    for ( ; yRep > 0; yRep-- ) {
      if ( place_free(x,y+signY) && place_free(x+charXShift,y+signY)) {
        y += signY;
      }
      else {
        ySpeed = 0;
      }
    }
    
    
    for ( ; xRep > 0; xRep-- ) {
      if ( place_free(x+signX,y-charYShift) && place_free(x+signX,y) ) {
        x += signX;
    }
    else{
      xSpeed = 0;
    }
  }
  }
  void display() {//DISPLAY///////////////
    
    //LEFTA
    if (state <0 && state >=-1){
     PImage leftB; //Almacenamos la imagen
     leftB = loadImage("Andromeda_Pos5x.png");//loadImage("lefta.png");
     image(leftB, x, y-charYShift);
    }// END LEFTA
    
    //LEFTB
     else if (state <-1 && state >=-2){ 
     PImage leftB;
     leftB = loadImage("Andromeda_Pos3x.png");//loadImage("leftb.png");
     image(leftB, x, y-charYShift);
    }// END LEFTB
    
     //RIGHTA
      else if (state >0 && state <=1){
      PImage rightA;
     rightA = loadImage("Andromeda_Pos3x.png");//loadImage("righta.png");
     image(rightA, x,y-charYShift);
    }// END RIGHTA
    
    //RIGHTB
     else if (state >1 && state <=2){
     PImage rightB;
     rightB = loadImage("Andromeda_Pos4x.png");//loadImage("rightb.png");
     image(rightB, x, y-charYShift);
    }// END RIGHTB
    
    //STILL
    else if(state==0){
     PImage still;
     still = loadImage("Andromeda_Pos_1x.png");//loadImage("still.png"); Primera imagen
     image(still, x, y-charYShift);
    }//END STILL
    //Moviemiento especial
    if (state >3 && state <=4){
     PImage Jeza; //Almacenamos la imagen
     Jeza = loadImage("Mov3.png");//loadImage("lefta.png");
     image(Jeza, x, y-charYShift);
    }// END LEFTA
    
    //LEFTB
     else if (state >1 && state <=2 && key=='x'){ 
     PImage leftA;
     leftA = loadImage("Mov1.png");//loadImage("leftb.png");
     image(leftA, x, y-charYShift);
    }// END LEFTB


    
    
  }//END DISPLAY///////////////////
  

}//END CLASS///////////////////////
