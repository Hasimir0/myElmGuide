module Main exposing (Form, Msg(..), init, main, update, view)

import Browser
import Char exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import String exposing (..)



--MAIN


main : Program () Form Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



--MODEL


type alias Form =
    { name : String
    , age : String
    , password : String
    , passwordAgain : String
    , validity : Bool
    }


init : Form
init =
    { name = ""
    , age = ""
    , password = ""
    , passwordAgain = ""
    , validity = False
    }



--UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String
    | Validate


update : Msg -> Form -> Form
update msg form =
    case msg of
        Name name ->
            { form | name = name, validity = False }

        Age age ->
            { form | age = age, validity = False }

        Password password ->
            { form | password = password, validity = False }

        PasswordAgain password ->
            { form | passwordAgain = password, validity = False }

        Validate ->
            { form | validity = True }



--VIEW
--view : Form -> xxx


view form =
    layout [] <|
        row [ centerY, centerX, spacing 10 ]
            [ column
                [ centerX
                , centerY
                , spacing 10
                , width (px 250)
                , height fill
                ]
                [ el [ centerX ] (text "My Simple Form")
                , Input.username [ centerY ]
                    { label = Input.labelHidden "Name"
                    , onChange = \newName -> Name newName
                    , placeholder = Just (Input.placeholder [] (text "username"))
                    , text = form.name
                    }
                , Input.text [ centerY ]
                    { label = Input.labelHidden "Age"
                    , onChange = \age -> Age age
                    , placeholder = Just (Input.placeholder [] (text "age"))
                    , text = form.age
                    }
                , Input.newPassword []
                    { label = Input.labelHidden "Password"
                    , onChange = \newPass -> Password newPass
                    , placeholder = Just (Input.placeholder [] (text "password"))
                    , text = form.password
                    , show = False
                    }
                , Input.currentPassword []
                    { label = Input.labelHidden "PasswordAgain"
                    , onChange = \againPass -> PasswordAgain againPass
                    , placeholder = Just (Input.placeholder [] (text "repeat the password"))
                    , text = form.passwordAgain
                    , show = False
                    }
                , Input.button
                    [ centerX
                    , Background.color (rgb 0 0 0)
                    , Font.color (rgb 1 1 1)
                    , Border.rounded 10
                    , Border.color (rgb 1 1 1)
                    , padding 10
                    ]
                    { onPress = Just Validate
                    , label = text "Submit"
                    }
                ]
            , column
                [ centerX
                , centerY
                , Border.width 1
                , spacing 10
                , width (px 250)
                , height fill
                ]
                [ el [ centerY, padding 30 ] (viewValidation form) ]
            ]


red : Color
red =
    rgb 1 0 0


green : Color
green =
    rgb 0 1 0


white : Color
white =
    rgb 1 1 1



--viewValidation : Form ->


viewValidation : Form -> Element msg
viewValidation model =
    let
        ( color, message ) =
            if model.validity then
                if isEmpty model.name then
                    ( red, "Please input a valid username!" )

                else if isEmpty model.age || all isDigit model.age == False then
                    ( red, "Please input a valid age!" )

                else if length model.password < 8 then
                    ( red, "Password must be at least 8 characters!" )

                else if any isDigit model.password == False then
                    ( red, "Password must contain at least 1 number!" )

                else if any isUpper model.password == False then
                    ( red, "Password must contain at least 1 capital character!" )

                else if any isLower model.password == False then
                    ( red, "Password must contain at least 1 lower character!" )

                else if model.password /= model.passwordAgain then
                    ( red, "Passwords do not match!" )

                else
                    ( green, "All data checks out :)" )

            else
                ( white, "empty filler" )
    in
    el [ Font.color color ] (paragraph [] [ text message ])
