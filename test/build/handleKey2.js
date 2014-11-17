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
   var updateBullet = F3(function (game,
   entity,
   list) {
      return function () {
         var updated = _U.replace([["position"
                                   ,function () {
                                      var $ = entity.position,
                                      x = $._0,
                                      y = $._1;
                                      return {ctor: "_Tuple2"
                                             ,_0: x + 1
                                             ,_1: y};
                                   }()]],
         entity);
         return A2($List._op["::"],
         updated,
         list);
      }();
   });
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
      $Time.fps(1));
   }();
   var Bullet = {ctor: "Bullet"};
   var updatePlayer = F3(function (game,
   entity,
   list) {
      return function () {
         var updated = _U.replace([["position"
                                   ,A2($Set.member,
                                   38,
                                   game.onKeyHold) ? function () {
                                      var $ = entity.position,
                                      x = $._0,
                                      y = $._1;
                                      return {ctor: "_Tuple2"
                                             ,_0: x
                                             ,_1: y + 1};
                                   }() : A2($Set.member,
                                   40,
                                   game.onKeyHold) ? function () {
                                      var $ = entity.position,
                                      x = $._0,
                                      y = $._1;
                                      return {ctor: "_Tuple2"
                                             ,_0: x
                                             ,_1: y - 1};
                                   }() : A2($Set.member,
                                   37,
                                   game.onKeyHold) ? function () {
                                      var $ = entity.position,
                                      x = $._0,
                                      y = $._1;
                                      return {ctor: "_Tuple2"
                                             ,_0: x - 1
                                             ,_1: y};
                                   }() : A2($Set.member,
                                   39,
                                   game.onKeyHold) ? function () {
                                      var $ = entity.position,
                                      x = $._0,
                                      y = $._1;
                                      return {ctor: "_Tuple2"
                                             ,_0: x + 1
                                             ,_1: y};
                                   }() : entity.position]],
         entity);
         return A2($Set.member,
         32,
         game.onKeyDown) ? A2($List._op["::"],
         updated,
         A2($List._op["::"],
         {_: {}
         ,entityType: Bullet
         ,position: {ctor: "_Tuple2"
                    ,_0: 0.0
                    ,_1: 0.0}},
         list)) : A2($List._op["::"],
         updated,
         list);
      }();
   });
   var Player = {ctor: "Player"};
   var game = {_: {}
              ,entities: _L.fromArray([{_: {}
                                       ,entityType: Player
                                       ,position: {ctor: "_Tuple2"
                                                  ,_0: 0.0
                                                  ,_1: 0.0}}])
              ,onKeyDown: $Set.fromList(_L.fromArray([]))
              ,onKeyHold: $Set.fromList(_L.fromArray([]))
              ,onKeyUp: $Set.fromList(_L.fromArray([]))};
   var updateEntity = F3(function (game,
   entity,
   list) {
      return _U.eq(entity.entityType,
      Player) ? A3(updatePlayer,
      game,
      entity,
      list) : _U.eq(entity.entityType,
      Bullet) ? A3(updateBullet,
      game,
      entity,
      list) : A2($List._op["::"],
      entity,
      list);
   });
   var updateEntities = function (game) {
      return _U.replace([["entities"
                         ,A3($List.foldl,
                         updateEntity(game),
                         _L.fromArray([]),
                         game.entities)]],
      game);
   };
   var update = function (input) {
      return function ($) {
         return updateEntities(updateInput(input)($));
      };
   };
   var main = A2($Signal._op["<~"],
   $Text.asText,
   A3($Signal.foldp,
   update,
   game,
   input));
   _elm.Main.values = {_op: _op
                      ,Player: Player
                      ,Bullet: Bullet
                      ,game: game
                      ,input: input
                      ,updatePlayer: updatePlayer
                      ,updateBullet: updateBullet
                      ,updateEntity: updateEntity
                      ,updateEntities: updateEntities
                      ,updateInput: updateInput
                      ,update: update
                      ,main: main};
   return _elm.Main.values;
};