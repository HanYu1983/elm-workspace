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
   $Color = Elm.Color.make(_elm),
   $Graphics$Collage = Elm.Graphics.Collage.make(_elm),
   $Keyboard = Elm.Keyboard.make(_elm),
   $List = Elm.List.make(_elm),
   $Set = Elm.Set.make(_elm),
   $Signal = Elm.Signal.make(_elm),
   $Text = Elm.Text.make(_elm),
   $Time = Elm.Time.make(_elm);
   var updateInput = F2(function (_v0,
   game) {
      return function () {
         return _U.replace([["onKeyHold"
                            ,_v0.keys]
                           ,["onKeyDown"
                            ,A2($Set.diff,
                            _v0.keys,
                            game.onKeyHold)]
                           ,["onKeyUp"
                            ,A2($Set.diff,
                            game.onKeyHold,
                            _v0.keys)]],
         game);
      }();
   });
   var update = function (input) {
      return updateInput(input);
   };
   var input = function () {
      var comp = F2(function (n,
      delta) {
         return {_: {}
                ,dt: delta
                ,keys: $Set.fromList(n)};
      });
      return A2($Signal._op["~"],
      A2($Signal._op["<~"],
      comp,
      $Keyboard.keysDown),
      $Time.fps(30));
   }();
   var game = {_: {}
              ,entities: _L.fromArray([{_: {}
                                       ,position: {ctor: "_Tuple2"
                                                  ,_0: 0.0
                                                  ,_1: 0.0}}
                                      ,{_: {}
                                       ,position: {ctor: "_Tuple2"
                                                  ,_0: 10.0
                                                  ,_1: 0.0}}])
              ,onKeyDown: $Set.fromList(_L.fromArray([]))
              ,onKeyHold: $Set.fromList(_L.fromArray([]))
              ,onKeyUp: $Set.fromList(_L.fromArray([]))};
   var main = A2($Signal._op["<~"],
   $Text.asText,
   A3($Signal.foldp,
   update,
   game,
   input));
   var clearGrey = A4($Color.rgba,
   111,
   111,
   111,
   0.6);
   var displayPlayer = function (_v2) {
      return function () {
         return $Graphics$Collage.move(_v2.position)(A2($Graphics$Collage.filled,
         clearGrey,
         A2($Graphics$Collage.ngon,
         4,
         60)));
      }();
   };
   var display = function (game) {
      return A2($Graphics$Collage.collage,
      300,
      300)(A2($List.map,
      displayPlayer,
      game.entities));
   };
   _elm.Main.values = {_op: _op
                      ,clearGrey: clearGrey
                      ,game: game
                      ,input: input
                      ,updateInput: updateInput
                      ,update: update
                      ,displayPlayer: displayPlayer
                      ,display: display
                      ,main: main};
   return _elm.Main.values;
};