module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MAIN


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { gamesList : List Game
    }


type alias Game =
    { title : String
    , description : String
    }


initialModel : Model
initialModel =
    { gamesList = []
    }


initialCommand : Cmd Msg
initialCommand =
    Cmd.none


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCommand )



-- UPDATE


type Msg
    = FetchGamesList


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchGamesList ->
            ( { model | gamesList = [] }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    if List.isEmpty model.gamesList then
        div [] []
    else
        div []
            [ h1 [ class "games-section" ] [ text "Games" ]
            , gamesIndex model
            ]


gamesIndex : Model -> Html msg
gamesIndex model =
    div [ class "games-index" ] [ gamesList model.gamesList ]


gamesList : List Game -> Html msg
gamesList games =
    ul [ class "games-index" ] (List.map gamesListItem games)


gamesListItem : Game -> Html msg
gamesListItem game =
    li [ class "game-item" ]
        [ strong [] [ text game.title ]
        , p [] [ text game.description ]
        ]
