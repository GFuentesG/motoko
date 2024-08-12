export const idlFactory = ({ IDL }) => {
  const Profile = IDL.Record({
    'username' : IDL.Text,
    'owner' : IDL.Principal,
    'email' : IDL.Text,
  });
  const Result_2 = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  const GetProfileResultOk = IDL.Record({
    'username' : IDL.Text,
    'owner' : IDL.Principal,
    'email' : IDL.Text,
  });
  const GetProfileResultErr = IDL.Variant({
    'userNotAuthenticated' : IDL.Null,
    'userDoesNotExist' : IDL.Null,
  });
  const GetProfileResult = IDL.Variant({
    'ok' : GetProfileResultOk,
    'err' : GetProfileResultErr,
  });
  const Result_1 = IDL.Variant({ 'ok' : IDL.Vec(Profile), 'err' : IDL.Text });
  const TaskId = IDL.Nat32;
  const TaskStatus = IDL.Variant({
    'pending' : IDL.Null,
    'completed' : IDL.Null,
  });
  const Task = IDL.Record({
    'id' : TaskId,
    'status' : TaskStatus,
    'owner' : IDL.Principal,
    'description' : IDL.Text,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Vec(Task), 'err' : IDL.Text });
  return IDL.Service({
    'addProfile' : IDL.Func([Profile], [Result_2], []),
    'addTaskToProfile' : IDL.Func([IDL.Text, IDL.Text], [Result_2], []),
    'delProfile' : IDL.Func([IDL.Text], [GetProfileResult], []),
    'getProfile' : IDL.Func([IDL.Text], [GetProfileResult], ['query']),
    'getProfiles' : IDL.Func([], [Result_1], ['query']),
    'listTasksForUser' : IDL.Func([IDL.Text], [Result], []),
    'whoami' : IDL.Func([], [IDL.Principal], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
