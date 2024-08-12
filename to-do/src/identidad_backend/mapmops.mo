import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Result "mo:base/Result";
import Types "./types";
import Map "mo:map/Map";
import { thash } "mo:map/Map";
import Validation "./validation";
import Iter "mo:base/Iter";
import TaskActor "canister:task";

actor MainActor{

  stable var profiles = Map.new<Text, Types.Profile>();


    public func addProfile(newProfile: Types.Profile): async Result.Result<Text, Text> {
        let isNameValid = Validation.validateName(newProfile.username);
        let isEmailValid = Validation.validateEmail(newProfile.email);
        
        if (isNameValid and isEmailValid) {   //
            Debug.print("adding profile: " # newProfile.username);
            Map.set(profiles, thash, newProfile.username, newProfile);
            return #ok("Profile successfully added");
        } else {
            Debug.print("No se adicionó el registro");
            return #err("Profile not registered, the name or email is invalid");
        };
    };

    public query (msg) func getProfile(username: Text): async Types.GetProfileResult {
        if(Principal.isAnonymous(msg.caller)) return #err(#userNotAuthenticated);

        let maybeProfile = Map.get(profiles, thash, username);

        switch(maybeProfile) {
            case(null) {#err(#userDoesNotExist)};    
            case(?profile) {#ok(profile)};
        };
    };

    public func delProfile (username: Text) : async Types.GetProfileResult {
        //if(Principal.isAnonymous(msg.caller)) return #err(#userNotAuthenticated);

        let maybeProfile = Map.get(profiles, thash, username);

        switch(maybeProfile) {
            case(null) {#err(#userDoesNotExist)};    
            case(?profile) {
                Map.delete(profiles, thash, username);
                Debug.print("Se borro el registro");
                return #ok(profile);
                };
        }
    };

    public query func getProfiles(): async [Types.Profile]{
        //let profileIter = profiles.vals();
        let profileIter = Map.vals(profiles);
        return Iter.toArray(profileIter);
     };


    // public func addTaskToProfile(username: Text, description: Text): async Result.Result<Text, Text>{
    //     let maybeProfile = Map.get(profiles, thash, username);

    //     switch (maybeProfile){
    //         case(null) { return #err("User does not exist")};
    //         case(?profile) {
    //             let result = await TaskActor.addTaskForPrincipal(description, profile.owner);

    //             switch(result){
    //                 case(#ok(_)){

    //                     let updateProfile: Types.Profile = {
    //                         username = profile.username;
    //                         email = profile.email;
    //                         owner = profile.owner;
    //                         tasks = profile.tasks; //Array.append(profile.tasks, [newTask]);
    //                     };

    //                   //Map.set(profiles, thash, newProfile.username, newProfile);
    //                     Map.set(profiles, thash, username, updateProfile);
    //                     Debug.print("Tarea agregada");
    //                     return #ok("Task added succcessfully");
    //                 };
    //                 case (#err(msg)) {
    //                     return #err("The task was not added: " # msg);
    //                 };
    //             };
    //         };
    //     };
    // };
            //modulo a probar para que  tareas este solo en task
    public func addTaskToProfile(username: Text, description: Text): async Result.Result<Text, Text> {
        let maybeProfile = Map.get(profiles, thash, username);

        switch (maybeProfile) {
            case(null) { return #err("User does not exist")};
            case(?profile) {
                // Agregar tarea directamente en el módulo TaskActor
                let result = await TaskActor.addTaskForPrincipal(description, profile.owner);

                switch(result) {
                    case(#ok(_)) {
                        Debug.print("Tarea agregada");
                        return #ok("Task added successfully");
                    };
                    case (#err(msg)) {
                        return #err("The task was not added: " # msg);
                    };
                }
            };
        }
    };

    //listar las tareas por usuario
    public shared func listTasksForUser(username: Text): async Result.Result<[Types.Task], Text> {
        let maybeProfile = Map.get(profiles, thash, username);

        switch (maybeProfile) {
            case (null) {
                return #err("User does not exist");
            };
            case (?profile) {
                // Llamamos a la función en el canister `task.mo`
                let tasks = await TaskActor.getTasksByOwner(profile.owner);

                return #ok(tasks); //retorna la lista de tareas
            };
        }
    };


};

