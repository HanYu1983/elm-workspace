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
   $Graphics$Element = Elm.Graphics.Element.make(_elm),
   $List = Elm.List.make(_elm),
   $Text = Elm.Text.make(_elm);
   var welcomeGraphics = function () {
      var imgSize = 30;
      var elmLogo = A3($Graphics$Element.image,
      imgSize,
      imgSize,
      "http://elm-lang.org/logo.png");
      var dimensions = 90;
      var elmsPerSide = dimensions / imgSize | 0;
      var row = A2($Graphics$Element.flow,
      $Graphics$Element.right,
      A2($List.repeat,
      elmsPerSide,
      elmLogo));
      return A2($Graphics$Element.flow,
      $Graphics$Element.down,
      A2($List.repeat,
      elmsPerSide,
      row));
   }();
   var helloWorld = $Text.asText("Hello, World!");
   var main = A2($Graphics$Element.flow,
   $Graphics$Element.down,
   _L.fromArray([helloWorld
                ,welcomeGraphics]));
   _elm.Main.values = {_op: _op
                      ,helloWorld: helloWorld
                      ,welcomeGraphics: welcomeGraphics
                      ,main: main};
   return _elm.Main.values;
};