module Scenes.Home.GameLayer.Model exposing
    ( initModel
    , updateModel
    , viewModel
    )

{-| This is the doc for this module

@docs initModel
@docs updateModel
@docs viewModel

-}

import Array
import Canvas exposing (Renderable)
import Components.Console.Export as Console
import Components.Typer.Export as Typer
import Lib.Component.Base exposing (ComponentInitData(..), ComponentMsg(..))
import Lib.Component.ComponentHandler exposing (updateComponents, viewComponent)
import Lib.Env.Env exposing (addCommonData, noCommonData)
import Lib.Layer.Base exposing (LayerMsg(..), LayerTarget(..))
import Scenes.Home.GameLayer.Common exposing (EnvC, Model)
import Scenes.Home.LayerBase exposing (LayerInitData)


{-| initModel
Add components here
-}
initModel : EnvC -> LayerInitData -> Model
initModel env _ =
    { components =
        Array.fromList
            [ Typer.initComponent (noCommonData env) <| ComponentID 0 (ComponentIntData 1)
            , Console.initComponent (noCommonData env) <| ComponentID 1 (ComponentIntData 0)
            ]
    }


{-| Handle component messages (that are sent to this layer).
-}
handleComponentMsg : EnvC -> ComponentMsg -> Model -> ( Model, List ( LayerTarget, LayerMsg ), EnvC )
handleComponentMsg env tmsg model =
    case tmsg of
        ComponentStringMsg x ->
            ( model, [ ( LayerParentScene, LayerStringMsg x ) ], env )

        _ ->
            ( model, [], env )


{-| updateModel
Default update function

Add your logic to handle msg and LayerMsg here

-}
updateModel : EnvC -> LayerMsg -> Model -> ( Model, List ( LayerTarget, LayerMsg ), EnvC )
updateModel env _ model =
    let
        components =
            model.components

        ( newComponents, newMsg, newEnv ) =
            updateComponents (noCommonData env) components
    in
    List.foldl
        (\cTMsg ( m, cmsg, cenv ) ->
            let
                ( nm, nmsg, nenv ) =
                    handleComponentMsg cenv cTMsg m
            in
            ( nm, nmsg ++ cmsg, nenv )
        )
        ( { model | components = newComponents }, [], addCommonData env.commonData newEnv )
        newMsg


{-| viewModel
Default view function

If you don't have components, remove viewComponent.

If you have other elements than components, add them after viewComponent.

-}
viewModel : EnvC -> Model -> Renderable
viewModel env model =
    viewComponent (noCommonData env) model.components
