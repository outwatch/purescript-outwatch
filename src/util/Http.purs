module OutWatch.Http ( createHttpHandler
  , get
  , getWithBody
  , post
  , put
  , delete
  , options
  , head
  ) where

import Control.Monad.Eff.Unsafe (unsafePerformEff)
import Data.HTTP.Method (Method(..))
import Network.HTTP.Affjax (AJAX)
import OutWatch.Sink (Handler, createHandlerImpl)
import Prelude (show, ($), (#))
import RxJS.Observable (Observable, Request, Response, ajax, ajaxWithBody, switchMap, share)


createHttpHandler :: forall a e. Array a -> Handler (ajax :: AJAX | e) a
createHttpHandler = createHandlerImpl


get :: forall e. Handler (ajax :: AJAX | e) String -> Observable Response
get = requestWithUrl

getWithBody :: forall e. Handler (ajax :: AJAX | e) Request -> Observable Response
getWithBody = request GET

post :: forall e. Handler (ajax :: AJAX | e) Request -> Observable Response
post = request POST

put :: forall e. Handler (ajax :: AJAX | e) Request -> Observable Response
put = request PUT

delete :: forall e. Handler (ajax :: AJAX | e) Request -> Observable Response
delete = request DELETE

options :: forall e. Handler (ajax :: AJAX | e) Request -> Observable Response
options = request OPTIONS

head :: forall e. Handler (ajax :: AJAX | e) Request -> Observable Response
head = request HEAD



request :: forall e. Method -> Handler (ajax :: AJAX | e) Request -> Observable Response
request method handler =
  switchMap handler.src
    (\req -> unsafePerformEff $ ajaxWithBody (setResponseType req method))
    # share

requestWithUrl :: forall e. Handler (ajax :: AJAX | e) String -> Observable Response
requestWithUrl handler =
  switchMap handler.src (\url -> unsafePerformEff $ ajax url) # share

setResponseType :: Request -> Method -> Request
setResponseType req method =
  req { responseType = show method }
