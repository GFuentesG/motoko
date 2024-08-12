export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'printPrincipal' : IDL.Func([IDL.Principal], [IDL.Text], ['query']),
    'whoami' : IDL.Func([], [IDL.Principal], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
