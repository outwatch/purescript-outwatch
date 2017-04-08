module Example.Pure.BMICalculator where

import Control.Monad.Eff (Eff)
import Data.Int (round)
import OutWatch.Pure.Attributes (childShow, inputNumber, max, min, step, tpe, valueShow, (:=), (<==), (==>))
import OutWatch.Pure.Render (render)
import OutWatch.Core.Types (VDom)
import OutWatch.Pure.Sink (SinkLike, createNumberHandler)
import OutWatch.Pure.Tags (div, h3, input, text)
import Prelude (Unit, map, (#), (*), (/), (<<<))
import RxJS.Observable (Observable, combineLatest, startWith)
import Snabbdom (VDOM)

type State =
  { weight :: Number
  , height :: Number
  , bmi :: Number
  }

initialState :: State
initialState =
  { weight: 70.0
  , height: 170.0
  , bmi: 0.0
  }

calculateBMI :: Number -> Number -> Number
calculateBMI weight height =
  let heightMeters = height * 0.01 in
  weight / (heightMeters * heightMeters)

type SliderProps eff r =
  { min :: Number
  , max :: Number
  , label :: String
  , value :: Observable Number
  , changeHandler :: SinkLike eff Number r
  }

sliderView :: forall eff r. SliderProps eff r -> VDom eff
sliderView props =
  div
    [ h3
        [ text props.label
        , childShow <== props.value
        ]
      , input
        [ tpe := "range"
        , min := props.min
        , max := props.max
        , inputNumber ==> props.changeHandler
        , step := 1.0
        , valueShow <== props.value
        ]
  ]

main :: forall e. Eff ( vdom :: VDOM | e ) Unit
main = render "#app" app
 
app :: forall e. VDom e
app =
    let weightHandler = createNumberHandler[initialState.weight]
        heightHandler = createNumberHandler[initialState.height]

        state = combineLatest (\w h -> { weight: w, height: h, bmi: calculateBMI w h })
                  weightHandler.src heightHandler.src
                # startWith initialState

        root = div
          [ sliderView
              { label: "weight (kg): "
              , min: 40.0
              , max: 140.0
              , value: map _.weight state
              , changeHandler: weightHandler
              }
          , sliderView
              { label: "height (cm): "
              , min: 140.0
              , max: 210.0
              , value: map _.height state
              , changeHandler: heightHandler
              }
          , h3
              [ text "bmi: "
              , childShow <== map (round <<< _.bmi) state
              ]
          ]

    in root
