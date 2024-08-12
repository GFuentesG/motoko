import Principal "mo:base/Principal";
import Result "mo:base/Result";

//type Result<ok, Err> = {#ok : Ok; #err : Err} // esun varian un valor
// cuaneo es ok y cuando es error
//este Result es el segundo del de abajo:
actor {


    public query (msg) func greet(): async Result.Result<Text, Text> {
        //                                                ok     err
        if (Principal.isAnonymous(msg.caller)) return #err("No tienes acceso");

        return #ok("Hello World!!!")
    }
}