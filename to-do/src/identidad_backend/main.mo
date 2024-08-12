import Principal "mo:base/Principal"; //para metodo whoami

actor {

  // esta implicito:  //reservado para adicionar mas mas adelante
  type Message = {
    caller: Principal
  };

  // el metodo para saber quien esta mandando a llamar este metodo
  // lo normal y para verificar el metodo que se esta mandando a llamar:
  public query (msg) func whoAmI(): async Principal {
    return msg.caller;
  };

  // msg funciona para metodo query como update
  var name: Text ="";

  // la sentencia completa para los metodos es:
  // public shared ...
  public query (_msg) func getname() : async Text {
    return "Hello, " # name # "!";
  };
  public shared (_msg) func setName(newName: Text) : async Text { 
      // se adiciona shared para usar (msg)
      // aunque no le coloquemos msg, es informacion del contexto de
      // quien se manda a llamar
    name := newName;
    return "Hello, " # name # "!";
  };
};
