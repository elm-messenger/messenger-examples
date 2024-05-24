module Scenes.Level1.Model exposing (scene)

{-|


# Level configuration module

-}

import Lib.Base exposing (SceneMsg)
import Lib.UserData exposing (UserData)
import Messenger.Base exposing (Env)
import Messenger.Scene.RawScene exposing (RawSceneProtoLevelInit)
import Messenger.Scene.Scene exposing (SceneStorage)
import SceneProtos.Game.Components.ComponentBase exposing (ComponentMsg(..))
import SceneProtos.Game.Components.Enemy.Init as EnemyInit
import SceneProtos.Game.Components.Enemy.Model as Enemy
import SceneProtos.Game.Components.Ship.Init as ShipInit
import SceneProtos.Game.Components.Ship.Model as Ship
import SceneProtos.Game.Init exposing (InitData)
import SceneProtos.Game.Model exposing (genScene)


init : RawSceneProtoLevelInit UserData SceneMsg (InitData SceneMsg)
init env msg =
    Just (initData env msg)


initData : Env () UserData -> Maybe SceneMsg -> InitData SceneMsg
initData env msg =
    { objects =
        [ Ship.component (ShipInitMsg <| ShipInit.InitData 0 ( 100, 500 ) 250)
        , Enemy.component (EnemyInitMsg <| EnemyInit.InitData 1 (-1 / 10) ( 1920, 1000 ) 50 20 150)
        ]
    }


{-| Scene storage
-}
scene : SceneStorage UserData SceneMsg
scene =
    genScene init
