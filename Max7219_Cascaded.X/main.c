#include <stdio.h>
#include <stdlib.h>
//------------------------------------------------------------------------------
#include "ascii_chars.h"
#include "MAX7219.h"
//------------------------------------------------------------------------------

int main(int argc, char** argv) 
{

MAX7219_init(5);
    
    // Mostrar cada palabra y agregar un retraso de 1 segundo
    MAX7219_displayText("Bien");
    MAX7219_init(5);
    MAX7219_init(5);
    MAX7219_init(5);
    MAX7219_displayText("ienv");
    MAX7219_init(5);
    MAX7219_init(5);

    MAX7219_displayText("enve");
    MAX7219_init(5);
    MAX7219_init(5);

  
    MAX7219_displayText("nven");
    MAX7219_init(5);
    MAX7219_init(5);
   

    MAX7219_displayText("veni");
    MAX7219_init(5);
    MAX7219_init(5);
  
   

    MAX7219_displayText("enid");
    MAX7219_init(5);
    MAX7219_init(5);


    MAX7219_displayText("nido");
    MAX7219_init(5);
    MAX7219_init(5);
    
     MAX7219_displayText("idos");
    MAX7219_init(5);
    MAX7219_init(5);
   MAX7219_init(5);
    
   
 

 
  while(1)
  {
   
   
      MAX7219_displayText("UNP ");
     MAX7219_init(5);
    MAX7219_init(5);
      MAX7219_init(5);
    MAX7219_init(5);
   

   

       
      
      

    

    


  }
  
  return (EXIT_SUCCESS);
}
//-----------------------------------------
