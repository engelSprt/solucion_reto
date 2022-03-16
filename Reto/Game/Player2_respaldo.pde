class Player2 {
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
  
  Player2(int _x, int _y ) {
    x = _x;
    y = _y;
    xSpeed = 2;
    ySpeed = 2;
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
    if ( (keyPressed==true)&&(key=='d') ) {
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
    else if ( (keyPressed==true)&&(key=='a') ) {
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
    else if ( (keyPressed==true)&&(key=='x') ) {
      //state=3;
      //cout<<state;
     // state=state;
     state =3;
      state = state + stateRate;
            if (state >6) {
           state =  stateRate;
           }
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
     
    if ( (keyPressed==true)&&(key=='w') ) {
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
     leftB = loadImage("Hyoga_pos1i.png");//loadImage("lefta.png");
     image(leftB, x, y-charYShift);
    }// END LEFTA
    
    //LEFTB
     else if (state <-1 && state >=-2){ 
     PImage leftB;
     leftB = loadImage("Hyoga_pos2i.png");//loadImage("leftb.png");
     image(leftB, x, y-charYShift);
    }// END LEFTB
    
     //RIGHTA
      else if (state >0 && state <=1){
      PImage rightA;
     rightA = loadImage("Hyoga_pos1d.png");//loadImage("righta.png");
     image(rightA, x,y-charYShift);
    }// END RIGHTA
    
    //RIGHTB
     else if (state >1 && state <=2){
     PImage rightB;
     rightB = loadImage("Hyoga_pos2d.png");//loadImage("rightb.png");
     image(rightB, x, y-charYShift);
    }// END RIGHTB
    
    //STILL
    else if(state==0){
     PImage still;
     still = loadImage("Hyoga_pos1.png");//loadImage("still.png"); Primera imagen
     image(still, x, y-charYShift);
    }//END STILL
    //Moviemiento especial
    if (state >3 && state <=4){
     PImage Jeza; //Almacenamos la imagen
     Jeza = loadImage("Hyoga_special.png");//loadImage("lefta.png");
     image(Jeza, x, y-charYShift);
    }// END LEFTA
    
    //LEFTB

    
    
  }//END DISPLAY///////////////////
  

}//END CLASS///////////////////////
