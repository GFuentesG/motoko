export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
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
  const Result_1 = IDL.Variant({ 'ok' : Task, 'err' : IDL.Text });
  const Result_2 = IDL.Variant({ 'ok' : IDL.Vec(Task), 'err' : IDL.Text });
  return IDL.Service({
    'addTask' : IDL.Func([IDL.Text], [Result], []),
    'addTaskForPrincipal' : IDL.Func([IDL.Text, IDL.Principal], [Result], []),
    'delTask' : IDL.Func([TaskId], [Result_1], []),
    'getAllTasks' : IDL.Func([], [IDL.Vec(Task)], ['query']),
    'getMyTasks' : IDL.Func([], [Result_2], ['query']),
    'getTaskById' : IDL.Func([TaskId], [Result_1], ['query']),
    'getTasksByOwner' : IDL.Func([IDL.Principal], [IDL.Vec(Task)], ['query']),
    'updateTaskStatus' : IDL.Func([TaskId, TaskStatus], [Result], []),
    'whoami' : IDL.Func([], [IDL.Principal], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
