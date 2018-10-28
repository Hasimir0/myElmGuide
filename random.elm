module Main exposing (Model, main)

import Browser exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html exposing (..)
import Html.Events exposing (..)
import Random
import String exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = \model -> layout [] (view model)
        }



-- MODEL


type alias Model =
    { dieFace : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1, Cmd.none )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Element Msg
view model =
    column [ centerX, centerY, spacing 10 ]
        [ row [ spacing 10 ]
            [ Element.image [ centerX ]
                { src = "/img/die0" ++ String.fromInt model.dieFace ++ ".gif"
                , description = "die " ++ String.fromInt model.dieFace ++ " as image"
                }
            , Element.image [ centerX ]
                { src = "/img/die0" ++ String.fromInt model.dieFace ++ ".gif"
                , description = "die " ++ String.fromInt model.dieFace ++ " as image"
                }
            ]
        , Input.button
            [ centerX
            , Background.color (rgb 0 0 0)
            , Font.color (rgb 1 1 1)
            , Border.rounded 10
            , Border.color (rgb 1 1 1)
            , padding 10
            ]
            { onPress = Just Roll
            , label = Element.text "Roll!"
            }
        ]
