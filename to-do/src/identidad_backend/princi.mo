import Principal "mo:base/Principal";
//import Text "mo:base/Text";

actor {

  // Función de prueba para verificar el usuario que invoca
  public query ({caller}) func whoami(): async Principal { //***
      
      return caller;
  };

  // Función para imprimir un Principal
  public query func printPrincipal(principal: Principal): async Text {
      return Principal.toText(principal); // Convierte el Principal a una representación textual
  };

}