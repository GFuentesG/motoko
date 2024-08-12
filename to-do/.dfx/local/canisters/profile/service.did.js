export const idlFactory = ({ IDL }) => {
  const Profile = IDL.Record({
    'username' : IDL.Text,
    'owner' : IDL.Principal,
    'email' : IDL.Text,
  });
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
  return IDL.Service({
    'addProfile' : IDL.Func([Profile], [], ['oneway']),
    'getProfile' : IDL.Func([IDL.Text], [GetProfileResult], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
