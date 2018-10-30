module Main exposing (Model, main)

import Browser exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random
import String exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)



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
    row
        [ centerX, centerY, Element.spacing 10

        {- , Border.width 1, Border.color (rgb 0 0 0) -}
        ]
        [ column
            [ centerX, Element.spacing 10

            {- , Border.width 1, Border.color (rgb 1 0 0) -}
            ]
            [ row
                [ Element.spacing 10

                {- , Border.width 1, Border.color (rgb 0 1 0) -}
                ]
                [ imgDie model
                , el [] (html (svgDie1 model))
                ]
            , rollOne
            ]
        , column
            [ Element.spacing 10

            {- , Border.width 1, Border.color (rgb 0 0 1) -}
            ]
            [ el [ centerX ] (html (svgDie2 model))
            , rollTwo
            ]
        ]


imgDie : Model -> Element Msg
imgDie model =
    Element.image [ centerX ]
        { src = "/img/die0" ++ String.fromInt model.dieFace ++ ".gif"
        , description = "die " ++ String.fromInt model.dieFace ++ " as image"
        }


rollOne : Element Msg
rollOne =
    Input.button
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


svgDie1 : Model -> Html Msg
svgDie1 model =
    svg
        [ Svg.Attributes.width "80"
        , Svg.Attributes.height "80"
        , viewBox "0 0 80 80"
        ]
        [ rect
            [ x "1"
            , y "1"
            , Svg.Attributes.width "78"
            , Svg.Attributes.height "78"
            , rx "30"
            , ry "30"
            , Svg.Attributes.style "fill:white;stroke:black;stroke-width:1"
            ]
            []
        , Svg.text_
            [ x "32"
            , y "52"
            , Svg.Attributes.fill "black"
            , Svg.Attributes.style "font-size:30;font-weight:bold"
            ]
            [ Svg.text (String.fromInt model.dieFace) ]
        ]


rollTwo : Element Msg
rollTwo =
    Input.button
        [ centerX
        , Background.color (rgb 0 0 0)
        , Font.color (rgb 1 1 1)
        , Border.rounded 10
        , Border.color (rgb 1 1 1)
        , padding 10
        ]
        { onPress = Just Roll
        , label = Element.text "Roll Better!"
        }


svgDie2 : Model -> Html Msg
svgDie2 model =
    svg
        [ Svg.Attributes.width "80"
        , Svg.Attributes.height "80"
        , viewBox "0 0 80 80"
        ]
        [ rect
            [ x "1"
            , y "1"
            , Svg.Attributes.width "78"
            , Svg.Attributes.height "78"
            , rx "30"
            , ry "30"
            , Svg.Attributes.style "fill:white;stroke:black;stroke-width:1"
            ]
            []
        , Svg.text_
            [ x "32"
            , y "52"
            , Svg.Attributes.fill "black"
            , Svg.Attributes.style "font-size:30;font-weight:bold"
            ]
            [ Svg.text (String.fromInt model.dieFace) ]
        ]
