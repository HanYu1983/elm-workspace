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
   $Graphics$Element = Elm.Graphics.Element.make(_elm),
   $Keyboard = Elm.Keyboard.make(_elm),
   $List = Elm.List.make(_elm),
   $Set = Elm.Set.make(_elm),
   $Signal = Elm.Signal.make(_elm),
   $Text = Elm.Text.make(_elm),
   $Time = Elm.Time.make(_elm),
   $Window = Elm.Window.make(_elm);
   var clearGrey = A4($Color.rgba,
   111,
   111,
   111,
   0.6);
   var makeObject = function (entity) {
      return function () {
         var _v0 = entity.entityType;
         switch (_v0.ctor)
         {case "Bullet":
            return $Graphics$Collage.move(entity.position)(A2($Graphics$Collage.filled,
              clearGrey,
              A2($Graphics$Collage.ngon,
              16,
              5)));
            case "Player":
            return $Graphics$Collage.move(entity.position)(A2($Graphics$Collage.filled,
              clearGrey,
              A2($Graphics$Collage.ngon,
              5,
              20)));}
         _E.Case($moduleName,
         "between lines 72 and 74");
      }();
   };
   var display = F2(function (_v1,
   game) {
      return function () {
         switch (_v1.ctor)
         {case "_Tuple2":
            return $Graphics$Element.layers(_L.fromArray([A3($Graphics$Element.container,
                                                         _v1._0,
                                                         _v1._1,
                                                         $Graphics$Element.middle)($Text.asText("arrow to move, space to shoot"))
                                                         ,A2($Graphics$Collage.collage,
                                                         _v1._0,
                                                         _v1._1)(A2($List.map,
                                                         makeObject,
                                                         game.entities))]));}
         _E.Case($moduleName,
         "between lines 77 and 80");
      }();
   });
   var updateInput = F2(function (_v5,
   game) {
      return function () {
         return _U.replace([["onKeyHold"
                            ,_v5.keys]
                           ,["onKeyDown"
                            ,A2($Set.diff,
                            _v5.keys,
                            game.onKeyHold)]
                           ,["onKeyUp"
                            ,A2($Set.diff,
                            game.onKeyHold,
                            _v5.keys)]],
         game);
      }();
   });
   var updateBullet = F3(function (game,
   entity,
   list) {
      return function () {
         var $ = entity.position,
         x = $._0,
         y = $._1;
         var shouldRemove = _U.cmp(x,
         100) > 0;
         return shouldRemove ? list : function () {
            var updated = _U.replace([["position"
                                      ,function () {
                                         var $ = entity.position,
                                         x = $._0,
                                         y = $._1;
                                         return {ctor: "_Tuple2"
                                                ,_0: x + 5
                                                ,_1: y};
                                      }()]],
            entity);
            return A2($List._op["::"],
            updated,
            list);
         }();
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
      $Time.fps(60));
   }();
   var Bullet = {ctor: "Bullet"};
   var updatePlayer = F3(function (game,
   entity,
   list) {
      return function () {
         var handleRight = function (entity) {
            return _U.replace([["position"
                               ,A2($Set.member,
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
         };
         var handleLeft = function (entity) {
            return _U.replace([["position"
                               ,A2($Set.member,
                               37,
                               game.onKeyHold) ? function () {
                                  var $ = entity.position,
                                  x = $._0,
                                  y = $._1;
                                  return {ctor: "_Tuple2"
                                         ,_0: x - 1
                                         ,_1: y};
                               }() : entity.position]],
            entity);
         };
         var handleDown = function (entity) {
            return _U.replace([["position"
                               ,A2($Set.member,
                               40,
                               game.onKeyHold) ? function () {
                                  var $ = entity.position,
                                  x = $._0,
                                  y = $._1;
                                  return {ctor: "_Tuple2"
                                         ,_0: x
                                         ,_1: y - 1};
                               }() : entity.position]],
            entity);
         };
         var handleUp = function (entity) {
            return _U.replace([["position"
                               ,A2($Set.member,
                               38,
                               game.onKeyHold) ? function () {
                                  var $ = entity.position,
                                  x = $._0,
                                  y = $._1;
                                  return {ctor: "_Tuple2"
                                         ,_0: x
                                         ,_1: y + 1};
                               }() : entity.position]],
            entity);
         };
         var updated = function ($) {
            return handleRight(handleLeft(handleDown(handleUp($))));
         }(entity);
         return A2($Set.member,
         32,
         game.onKeyDown) ? A2($List._op["::"],
         updated,
         A2($List._op["::"],
         {_: {}
         ,entityType: Bullet
         ,position: entity.position},
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
   var main = A2($Signal._op["~"],
   A2($Signal._op["<~"],
   display,
   $Window.dimensions),
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
                      ,clearGrey: clearGrey
                      ,makeObject: makeObject
                      ,display: display
                      ,main: main};
   return _elm.Main.values;
};