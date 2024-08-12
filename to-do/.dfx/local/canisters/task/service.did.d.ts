import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export type Result = { 'ok' : string } |
  { 'err' : string };
export type Result_1 = { 'ok' : Task } |
  { 'err' : string };
export type Result_2 = { 'ok' : Array<Task> } |
  { 'err' : string };
export interface Task {
  'id' : TaskId,
  'status' : TaskStatus,
  'owner' : Principal,
  'description' : string,
}
export type TaskId = number;
export type TaskStatus = { 'pending' : null } |
  { 'completed' : null };
export interface _SERVICE {
  'addTask' : ActorMethod<[string], Result>,
  'addTaskForPrincipal' : ActorMethod<[string, Principal], Result>,
  'delTask' : ActorMethod<[TaskId], Result_1>,
  'getAllTasks' : ActorMethod<[], Array<Task>>,
  'getMyTasks' : ActorMethod<[], Result_2>,
  'getTaskById' : ActorMethod<[TaskId], Result_1>,
  'getTasksByOwner' : ActorMethod<[Principal], Array<Task>>,
  'updateTaskStatus' : ActorMethod<[TaskId, TaskStatus], Result>,
  'whoami' : ActorMethod<[], Principal>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
