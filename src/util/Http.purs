module OutWatch.Http ( createHttpHandler
  , get
  , getWithBody
  , post
  , put
  , delete
  , options
  , head
  , requestWithBody
  , HttpHandler
  ) where

import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.HTTP.Method (Method(..))
import Data.StrMap (empty)
import Network.HTTP.Affjax (AJAX)
import OutWatch.Sink (Handler, Observer, createHandlerImpl)
import Prelude (show, ($))
import RxJS.Observable (Observable, Request, Response, ajax, ajaxWithBody, switchMap)


createHttpHandler :: forall a e. Array a -> Handler (ajax :: AJAX | e) a
createHttpHandler = createHandlerImpl


get :: forall eff a. (Observable a -> Observable String) -> HttpHandler (ajax :: AJAX | eff)  a
get = requestWithUrl

getWithBody :: forall e a. (Observable a -> Observable Request) -> HttpHandler (ajax :: AJAX | e) a
getWithBody = request GET

post :: forall e a. (Observable a -> Observable Request) -> HttpHandler (ajax :: AJAX | e) a
post = request POST

put :: forall e a. (Observable a -> Observable Request) -> HttpHandler (ajax :: AJAX | e) a
put = request PUT

delete :: forall e a. (Observable a -> Observable Request) -> HttpHandler (ajax :: AJAX | e) a
delete = request DELETE

options :: forall e a. (Observable a -> Observable Request) -> HttpHandler (ajax :: AJAX | e) a
options = request OPTIONS

head :: forall e a. (Observable a -> Observable Request) -> HttpHandler (ajax :: AJAX | e) a
head = request HEAD

requestWithBody :: String -> String -> Request
requestWithBody url body =
  { url : url
  , body : body
  , timeout : 0
  , headers : empty
  , crossDomain : false
  , responseType : ""
  , method : show GET
  }

type HttpHandler eff input = { responses :: Observable Response, sink :: Observer eff input }


requestWithUrl :: forall e a. (Observable a -> Observable String) -> HttpHandler (ajax :: AJAX | e) a
requestWithUrl transform =
  let handler = createHandlerImpl[]
      transformed = transform handler.src
      responses = switchMap transformed (\url -> unsafePerformEff $ ajax url)
  in {responses, sink : handler.sink}


request :: forall e a. Method -> (Observable a -> Observable Request) -> HttpHandler (ajax :: AJAX | e) a
request method transform =
  let handler = createHandlerImpl[]
      transformed = transform handler.src
      responses = switchMap transformed
        (\req -> unsafePerformEff $ ajaxWithBody (setMethod req method))
  in {responses, sink : handler.sink}


setMethod :: Request -> Method -> Request
setMethod req method =
  req { method = show method }
