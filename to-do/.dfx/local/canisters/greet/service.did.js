export const idlFactory = ({ IDL }) => {
  const Result = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({ 'greet' : IDL.Func([], [Result], ['query']) });
};
export const init = ({ IDL }) => { return []; };
