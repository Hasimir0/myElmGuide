module Main exposing (Model, main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



--MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- Model


type alias Model =
    { counter : Int
    , tBox : String
    }


init : Model
init =
    Model 0 ""



-- Update


type Msg
    = Increment
    | Decrement
    | Reset
    | Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counter = model.counter + 1 }

        Decrement ->
            { model | counter = model.counter - 1 }

        Reset ->
            init

        Change nuText ->
            { model | tBox = nuText }



-- View


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model.counter) ]
        , button [ onClick Increment ] [ text "+" ]
        , br [] []
        , input [ placeholder "Text to Reverse", value model.tBox, onInput Change ] []
        , div [] [ text (String.reverse model.tBox) ]
        , button [ onClick Reset ] [ text "Reset EVVERYTHING!" ]
        ]
