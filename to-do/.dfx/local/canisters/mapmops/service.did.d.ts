import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export type GetProfileResult = { 'ok' : GetProfileResultOk } |
  { 'err' : GetProfileResultErr };
export type GetProfileResultErr = { 'userNotAuthenticated' : null } |
  { 'userDoesNotExist' : null };
export interface GetProfileResultOk {
  'username' : string,
  'owner' : Principal,
  'email' : string,
}
export interface Profile {
  'username' : string,
  'owner' : Principal,
  'email' : string,
}
export type Result = { 'ok' : Array<Task> } |
  { 'err' : string };
export type Result_1 = { 'ok' : Task } |
  { 'err' : string };
export type Result_2 = { 'ok' : Array<Profile> } |
  { 'err' : string };
export type Result_3 = { 'ok' : string } |
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
  'addProfile' : ActorMethod<[Profile], Result_3>,
  'addTaskToProfile' : ActorMethod<[string, string], Result_3>,
  'delProfile' : ActorMethod<[string], GetProfileResult>,
  'getProfile' : ActorMethod<[string], GetProfileResult>,
  'getProfiles' : ActorMethod<[], Result_2>,
  'getTaskDetails' : ActorMethod<[TaskId], Result_1>,
  'listTasksForUser' : ActorMethod<[string], Result>,
  'whoami' : ActorMethod<[], Principal>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
