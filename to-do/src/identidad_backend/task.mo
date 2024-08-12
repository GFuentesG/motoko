import Text "mo:base/Text";
import Types "./types";
import Array "mo:base/Array";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
//import MainActor "canister:mapmops";

actor TaskActor{

    stable var taskIdCounter: Nat32 = 0; // contador de tareas
    stable var tasks: [Types.Task] = [];

    //adicionar una tarea por el usuario
    public shared (msg) func addTask(description: Text): async Result.Result<Text, Text> {
        let caller = msg.caller; 
        return await internalAddTask(description, caller);
    };

    //adicionar una tarea por el administrador
    public func addTaskForPrincipal(description: Text, owner: Principal): async Result.Result<Text, Text> {
        return await internalAddTask(description, owner);
    };

    //funcion privada donde se crea la tarea
    private func internalAddTask(description: Text, owner: Principal): async Result.Result<Text, Text> {
        let newTaskId = taskIdCounter;
        taskIdCounter += 1;

        let newTask: Types.Task = {
            id = newTaskId;
            description = description;
            status = #pending;
            owner = owner;
        };

        tasks := Array.append(tasks, [newTask]); //agrega la nueva tarea a la lista
        return #ok("Task added successfully");
    };

    //buscar tareas por id para el administrador
    // public query func getTaskById(taskId: Types.TaskId): async ?Types.Task {
    //     return Array.find<Types.Task>(tasks, func (task){ task.id == taskId });
    // };


    // Función para obtener una tarea por ID, considerando permisos
    public query (msg) func getTaskById(taskId: Types.TaskId): async Result.Result<Types.Task, Text> {
        let caller = msg.caller;  // Obtenemos el Principal del actor que llama a la función

        // Buscamos la tarea por su ID
        let maybeTask = Array.find<Types.Task>(tasks, func (task) { task.id == taskId });

        switch (maybeTask) {
            case null
                return #err("Task not found");

            case (?task)
                // Si el solicitante es el propietario de la tarea o un canister (usuario especial)
                if (task.owner == caller or Principal.isAnonymous(caller)) {
                    return #ok(task);
                } else {
                    return #err("You do not have permission to view this task");
                };
        };
    };








    //listar todas las tareas del propio usuario
    public query (msg) func getMyTasks(): async [Types.Task] { 
        let caller = msg.caller; // Obtiene el Principal del usuario
        let userTasks = Array.filter<Types.Task>(tasks, func (task) { task.owner == caller });
        return userTasks;
    };

    //listar todas las tareas por usuario para administracion
    public query func getTasksByOwner(owner: Principal): async [Types.Task] { 
        let userTasks = Array.filter<Types.Task>(tasks, func (task){ 
            task.owner == owner
            });
        return userTasks;
    };

    //listar todas las tereas por usuario para administracion, de ser vacio muestra todo
    public query func getTasks(owner: ?Principal): async [Types.Task] {
        switch (owner) {
            case (null) {
                // Devuelve todas las tareas si el owner es null
                return tasks;
            };
            case (?principal) {
                // Devuelve las tareas asociadas al principal dado
                let userTasks = Array.filter<Types.Task>(tasks, func (task) {
                    task.owner == principal
                });
                return userTasks;
            };
        };
    };








    public func completeTask(taskId: Types.TaskId): async Result.Result<Text, Text>{
        let maybeTask = Array.find<Types.Task>(tasks,func (task){task.id == taskId});

        switch(maybeTask){
            case(null) {return #err("Task not found")};
            case(?task){
                let updateTask: Types.Task = {
                    id = task.id;
                    description = task.description;
                    status = #completed;
                    owner = task.owner;
                };
                tasks := Array.map<Types.Task, Types.Task>(tasks, func (t) {
                    if(t.id == taskId) {
                        updateTask;
                    }else{
                        t;
                    } 
                });

                return #ok("Task market as completed");
            
            };
        };
    };

    //cambiar el status de una tarea por el usuario
    public shared (msg) func updateTaskStatus(taskId: Types.TaskId, newStatus: Types.TaskStatus): async Result.Result<Text, Text> {
        let caller = msg.caller;  //*** Tomamos el principal del usuario logueado

        var taskFound: Bool = false;  //*** Flag para indicar si la tarea fue encontrada

        var updatedTasks: [Types.Task] = [];  //*** Lista para almacenar tareas actualizadas

        for (i in Iter.range(0, Array.size(tasks) - 1)) {  //*** Recorremos las tareas por índice
            let task = tasks[i];

            if (task.id == taskId and task.owner == caller) {  //*** Verificamos ID y propietario
                taskFound := true;

                if (task.status == newStatus) {
                    return #err("Task is already in the requested status");  //*** Si la tarea ya está en el estado solicitado
                } else {
                    let updatedTask: Types.Task = {
                        id = task.id;
                        description = task.description;
                        owner = task.owner;
                        status = newStatus;  //*** Actualizamos solo el estado de la tarea
                    };
                    updatedTasks := Array.append(updatedTasks, [updatedTask]);  //*** Agregamos la tarea actualizada a la lista
                }
            } else {
                updatedTasks := Array.append(updatedTasks, [task]);  //*** Agregamos tareas no actualizadas a la lista
            }
        };

        if (taskFound) {
            tasks := updatedTasks;  //*** Actualizamos la lista de tareas con las tareas actualizadas
            return #ok("Task status updated successfully");  //*** Confirmación de éxito
        } else {
            return #err("Task not found or you do not own this task");
        }
    }








}
    