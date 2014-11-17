Elm.Main = Elm.Main || {};
Elm.Main.make = function (_elm) {
   "use strict";
   _elm.Main = _elm.Main || {};
   if (_elm.Main.values)
   return _elm.Main.values;
   var _op = {},
   _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Main",
   $Basics = Elm.Basics.make(_elm),
   $Keyboard = Elm.Keyboard.make(_elm),
   $Signal = Elm.Signal.make(_elm),
   $Text = Elm.Text.make(_elm);
   var display = function (game) {
      return $Text.asText(game);
   };
   var handlePageChange = F2(function (_v0,
   g) {
      return function () {
         switch (_v0.ctor)
         {case "_Tuple2":
            return _U.replace([["page"
                               ,_U.cmp(_v0._0.x,
                               0) > 0 ? g.page + 1 : _U.cmp(_v0._0.x,
                               0) < 0 ? g.page - 1 : g.page]
                              ,["selection"
                               ,_U.cmp(_v0._0.y,
                               0) > 0 ? g.selection + 1 : _U.cmp(_v0._0.y,
                               0) < 0 ? g.selection - 1 : g.selection]],
              g);}
         _E.Case($moduleName,
         "between lines 12 and 17");
      }();
   });
   var handle = function (input) {
      return handlePageChange(input);
   };
   var input = A2($Signal._op["~"],
   A2($Signal._op["<~"],
   F2(function (v0,v1) {
      return {ctor: "_Tuple2"
             ,_0: v0
             ,_1: v1};
   }),
   $Keyboard.arrows),
   $Keyboard.keysDown);
   var game = {_: {}
              ,page: 0
              ,selection: 0};
   var main = A2($Signal._op["<~"],
   display,
   A3($Signal.foldp,
   handle,
   game,
   input));
   _elm.Main.values = {_op: _op
                      ,game: game
                      ,input: input
                      ,handlePageChange: handlePageChange
                      ,handle: handle
                      ,display: display
                      ,main: main};
   return _elm.Main.values;
};