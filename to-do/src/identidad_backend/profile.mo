//import HashMap "mo:base/HashMap";  // por el Map de mops ya no necesitamos
//import Hash "mo:base/Hash";
//import Nat "mo:base/Nat";
//import Iter "mo:base/Iter"; // por el Map de mops ya no necesitamos
import Text "mo:base/Text";
//import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Types "./types";
import Map "mo:map/Map";
import { thash } "mo:map/Map";
 //nhash ... de natural
 //thash ... de texto
 //phash ... para principal
 

actor {
//todos los type son custom type

//   type Profile ={
//     username: Text;
//     email: Text;
//   };

  // let profiles = HashMap.HashMap<Text, Types.Profile>(5, Text.equal, Text.hash);
  //                               //el Nat puede ser Text Principal ...

  //               tipo de indice , tipo de dato
  let profiles = Map.new<Text, Types.Profile>();
  //let profiles = HashMap.HashMap<Text, Types.Profile>(5, Text.equal, Text.hash);
                                //el Nat puede ser Text Principal ...

  public func addProfile(newProfile: Types.Profile): (){
    Debug.print("adding profiel: " # newProfile.username);
    //let nextId = getNextID();
    Map.set(profiles, thash, newProfile.username, newProfile);
                    //utils

    //profiles.put(newProfile.username, newProfile);

  };

  // public query func getProfiles(): async [Types.Profile]{
  //   let profileIter = profiles.vals();
  //   return Iter.toArray(profileIter)
  // };

    // type GetProfileResultOk = Profile; //hereda la estructura de otro type

    // type GetProfileResultErr = { //es un varian, ahora con 2 opciones
    //     #userDoesNotExist;
    //     #userNotAuthenticated;
    // };

    // type GetProfileResult = Result.Result<GetProfileResultOk, GetProfileResultErr>;
    //                                     //es igual que Profile
    //veamos la autenticacion como la gestion de errores:

    public query (msg) func getProfile(username: Text): async Types.GetProfileResult {
        if(Principal.isAnonymous(msg.caller)) return #err(#userNotAuthenticated);
                                                            //variante

        let maybeProfile = Map.get(profiles, thash, username);

        switch(maybeProfile) {
            case(null) {#err(#userDoesNotExist)};    
            case(?profile) {#ok(profile)};
            //     cuando trae dato, y lo pone en una nueva variable
            // llamada profile 
        };
    };

        // public query func getProfile(username: Text): async ?Profile {

        // return profiles.get(username);
        // };

}
