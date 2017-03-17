module OutWatch.Util.Http ( get
  , getWithBody
  , post
  , put
  , delete
  , options
  , head
  , request
  , HttpBus
  ) where

import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.HTTP.Method (Method(..))
import Data.StrMap (empty)
import Network.HTTP.Affjax (AJAX)
import OutWatch.Sink (Observer, createHandler)
import Prelude (show, ($))
import RxJS.Observable (Observable, Request, Response, ajax, ajaxWithBody, switchMap)


get :: forall eff a. (Observable a -> Observable String) -> HttpBus (ajax :: AJAX | eff) a
get = requestWithUrl

getWithBody :: forall e a. (Observable a -> Observable Request) -> HttpBus (ajax :: AJAX | e) a
getWithBody = requestWithBody GET

post :: forall e a. (Observable a -> Observable Request) -> HttpBus (ajax :: AJAX | e) a
post = requestWithBody POST

put :: forall e a. (Observable a -> Observable Request) -> HttpBus (ajax :: AJAX | e) a
put = requestWithBody PUT

delete :: forall e a. (Observable a -> Observable Request) -> HttpBus (ajax :: AJAX | e) a
delete = requestWithBody DELETE

options :: forall e a. (Observable a -> Observable Request) -> HttpBus (ajax :: AJAX | e) a
options = requestWithBody OPTIONS

head :: forall e a. (Observable a -> Observable Request) -> HttpBus (ajax :: AJAX | e) a
head = requestWithBody HEAD

request :: Url -> String -> Request
request url body =
  { url : url
  , body : body
  , timeout : 0
  , headers : empty
  , crossDomain : false
  , responseType : ""
  , method : show GET
  }

type HttpBus eff input =
  { responses :: Observable Response
  , sink :: Observer eff input
  }

type Url = String

requestWithUrl :: forall e a. (Observable a -> Observable Url) -> HttpBus (ajax :: AJAX | e) a
requestWithUrl transform =
  let handler = createHandler[]
      transformed = transform handler.src
      responses = switchMap transformed (\url -> unsafePerformEff $ ajax url)
  in {responses, sink : handler.sink}


requestWithBody :: forall e a. Method -> (Observable a -> Observable Request) -> HttpBus (ajax :: AJAX | e) a
requestWithBody method transform =
  let handler = createHandler[]
      transformed = transform handler.src
      responses = switchMap transformed
        (\req -> unsafePerformEff $ ajaxWithBody (setMethod req method))
  in {responses, sink : handler.sink}


setMethod :: Request -> Method -> Request
setMethod req method =
  req { method = show method }
