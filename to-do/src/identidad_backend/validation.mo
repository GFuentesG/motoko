import Text "mo:base/Text";
import Debug "mo:base/Debug";
//import Iter "mo:base/Iter";

module{
    public func validateName(name: Text): Bool {
        var tieneTresLetras: Bool = false;
        var soloLetras: Bool = true;
        var contadorLetras: Int = 0;

        let iter = Text.toIter(name);
        for (char in iter) {
            if ((char >= 'A' and char <= 'Z') or (char >= 'a' and char <= 'z')) {
                contadorLetras += 1;
            } else {
                soloLetras := false;
            };
        };

        if (contadorLetras >= 3) {
            tieneTresLetras := true;
        };

        if (tieneTresLetras and soloLetras) {
            return true;
        } else {
            Debug.print("The name: " # name # " is invalid");
            return false;
        };
    };


public func validateEmail(email: Text): Bool {
        var hasAtSymbol = false;
        var hasDotAfterAt = false;
        var atIndex = -1;
        var dotIndex = -1;

        let length = Text.size(email);
        var i = 0;

        // Recorrer cada carácter del texto del email
        for (char in Text.toIter(email)) {
            if (char == '@') {
                if (hasAtSymbol) {
                    // Si ya se ha encontrado un '@', no es un email válido
                    
                    return false;
                } else {
                    hasAtSymbol := true;
                    atIndex := i;
                };
            };

            if (char == '.' and hasAtSymbol and i > atIndex) {
                hasDotAfterAt := true;
                dotIndex := i;
            };

            i += 1;
        };

        // Validar posiciones de '@' y '.'
        if (hasAtSymbol and hasDotAfterAt and atIndex > 0 and dotIndex > atIndex + 1 and (length > 0) and dotIndex < length - 1) {
            return true;
        } else {
            Debug.print("The email: " # email # " is invalid");
            return false;
        };
    };
    
}









    // public func validateEmail(email: Text): Bool {
    //     let emailRegex = new RegExp ("^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$");
    //     if (emailRegex.test(email) == false){
    //         Debug.print("El email: " # email # " es invalido");
    //         return false;
    //     };
    //     return true;
    // };
