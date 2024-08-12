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
export interface _SERVICE {
  'addProfile' : ActorMethod<[Profile], undefined>,
  'getProfile' : ActorMethod<[string], GetProfileResult>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
