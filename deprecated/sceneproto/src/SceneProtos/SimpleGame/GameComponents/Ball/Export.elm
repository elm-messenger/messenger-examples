module SceneProtos.SimpleGame.GameComponents.Ball.Export exposing (initGC)

import Lib.Env.Env exposing (Env)
import SceneProtos.SimpleGame.GameComponent.Base exposing (GameComponent, GameComponentInitData)
import SceneProtos.SimpleGame.GameComponents.Ball.Ball exposing (initModel, updateModel, viewModel)


initGC : Env -> GameComponentInitData -> GameComponent
initGC env i =
    { name = "Ball"
    , data = initModel env i
    , update = updateModel
    , view = viewModel
    }
