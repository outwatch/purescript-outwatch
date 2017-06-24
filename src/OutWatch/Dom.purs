module OutWatch.Dom where

import Control.Monad.Eff (Eff)
import DOM.Event.Types (InputEvent, KeyboardEvent, MouseEvent)
import Data.Traversable (class Traversable)
import Data.Unit (unit, Unit)
import OutWatch.Dom.Builder (BoolAttributeBuilder(..), ChildStreamReceiverBuilder(..), ChildStringReceiverBuilder(..), ChildrenStreamReceiverBuilder(..), IntAttributeBuilder, NumberAttributeBuilder, ShowAttributeBuilder(..), StringAttributeBuilder(..), bindFrom, setTo)
import OutWatch.Dom.DomUtils (hyperscriptHelper)
import OutWatch.Dom.EmitterBuilder (BoolEmitterBuilder(..), DestroyHookBuilder(..), DragEmitterBuilder(..), EventEmitterBuilder(..), InputEmitterBuilder(..), InsertHookBuilder(..), KeyEmitterBuilder(..), MouseEmitterBuilder(..), NumberEmitterBuilder(..), StringEmitterBuilder(..), UpdateHookBuilder(..), emitFrom)
import OutWatch.Dom.VDomModifier (VDom(..), VNode(..), VDomB, toProxy, runVDomB)
import OutWatch.Sink (Handler, createHandler)
import Snabbdom (patchInitialSelector)
import Snabbdom (VDOM) as Snabbdom
import Prelude

type VDOM = Snabbdom.VDOM


renderRepresentation :: forall e. String -> VDom e -> Eff (vdom :: VDOM | e) Unit
renderRepresentation sel mod = case mod of
  (VNode vnode) -> patchInitialSelector sel (toProxy vnode)
  (Emitter _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Receiver _) -> patchInitialSelector "" (toProxy (StringNode ""))
  (Property _) -> patchInitialSelector "" (toProxy (StringNode ""))

render :: forall e. String -> VDomB e -> Eff (vdom :: VDOM | e) Unit
render sel builder = do
  mod <- runVDomB builder
  renderRepresentation sel mod

div :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
div = hyperscriptHelper "div"
span :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
span = hyperscriptHelper "span"
h1 :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
h1= hyperscriptHelper "h1"
button :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
button = hyperscriptHelper "button"
a :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
a = hyperscriptHelper "a"
label :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
label = hyperscriptHelper "label"
input :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
input = hyperscriptHelper "input"
hr :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
hr = hyperscriptHelper "hr"
ul :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
ul = hyperscriptHelper "ul"
abbr :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
abbr = hyperscriptHelper "abbr"
address :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
address = hyperscriptHelper "address"
area :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
area = hyperscriptHelper "area"
article :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
article = hyperscriptHelper "article"
aside :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
aside = hyperscriptHelper "aside"
audio :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
audio = hyperscriptHelper "audio"
b :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
b = hyperscriptHelper "b"
base :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
base = hyperscriptHelper "base"
bdi :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
bdi = hyperscriptHelper "bdi"
blockquote :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
blockquote = hyperscriptHelper "blockquote"
br :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
br = hyperscriptHelper "br"
li :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
li = hyperscriptHelper "li"
bdo :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
bdo = hyperscriptHelper "bdo"
canvas :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
canvas = hyperscriptHelper "canvas"
caption :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
caption = hyperscriptHelper "caption"
cite :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
cite = hyperscriptHelper "cite"
code :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
code = hyperscriptHelper "code"
col :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
col = hyperscriptHelper "col"
colgroup :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
colgroup = hyperscriptHelper "colgroup"
datalist :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
datalist = hyperscriptHelper "datalist"
dd :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
dd = hyperscriptHelper "dd"
del :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
del = hyperscriptHelper "del"
details :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
details = hyperscriptHelper "details"
dfn :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
dfn = hyperscriptHelper "dfn"
dialog :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
dialog = hyperscriptHelper "dialog"
dl :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
dl = hyperscriptHelper "dl"
dt :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
dt = hyperscriptHelper "dt"
em :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
em = hyperscriptHelper "em"
embed :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
embed = hyperscriptHelper "embed"
fieldset :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
fieldset = hyperscriptHelper "fieldset"
figcaption :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
figcaption = hyperscriptHelper "figcaption"
figure :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
figure = hyperscriptHelper "figure"
footer :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
footer = hyperscriptHelper "footer"
form :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
form = hyperscriptHelper "form"
header :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
header = hyperscriptHelper "header"
h2 :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
h2 = hyperscriptHelper "h2"
h3 :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
h3 = hyperscriptHelper "h3"
h4 :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
h4 = hyperscriptHelper "h4"
h5 :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
h5 = hyperscriptHelper "h5"
h6 :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
h6 = hyperscriptHelper "h6"
i :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
i = hyperscriptHelper "i"
iframe :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
iframe = hyperscriptHelper "iframe"
img :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
img = hyperscriptHelper "img"
ins :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
ins = hyperscriptHelper "ins"
keygen :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
keygen = hyperscriptHelper "keygen"
legend :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
legend = hyperscriptHelper "legend"
main :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
main = hyperscriptHelper "main"
mark :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
mark = hyperscriptHelper "mark"
menu :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
menu = hyperscriptHelper "menu"
menuitem :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
menuitem = hyperscriptHelper "menuitem"
meter :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
meter = hyperscriptHelper "meter"
nav :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
nav = hyperscriptHelper "nav"
ol :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
ol = hyperscriptHelper "ol"
optgroup :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
optgroup = hyperscriptHelper "optgroup"
option :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
option = hyperscriptHelper "option"
output :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
output = hyperscriptHelper "output"
p :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
p = hyperscriptHelper "p"
param :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
param = hyperscriptHelper "param"
pre :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
pre = hyperscriptHelper "pre"
progress :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
progress = hyperscriptHelper "progress"
section :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
section = hyperscriptHelper "section"
select :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
select = hyperscriptHelper "select"
small :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
small = hyperscriptHelper "small"
strong :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
strong = hyperscriptHelper "strong"
sub :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
sub = hyperscriptHelper "sub"
summary :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
summary = hyperscriptHelper "summary"
sup :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
sup = hyperscriptHelper "sup"
table :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
table = hyperscriptHelper "table"
tbody :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
tbody = hyperscriptHelper "tbody"
td :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
td = hyperscriptHelper "td"
textarea :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
textarea = hyperscriptHelper "textarea"
tfoot :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
tfoot = hyperscriptHelper "tfoot"
th :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
th = hyperscriptHelper "th"
thead :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
thead = hyperscriptHelper "thead"
time :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
time = hyperscriptHelper "time"
tr :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
tr = hyperscriptHelper "tr"
track :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
track = hyperscriptHelper "track"
video :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
video = hyperscriptHelper "video"
wbr :: forall e f. (Traversable f) => f (VDomB e) -> VDomB e
wbr = hyperscriptHelper "wbr"


text ::forall e. String -> VDomB e
text str = pure $ VNode (StringNode str)



hidden :: BoolAttributeBuilder
hidden = BoolAttributeBuilder "hidden"
value :: StringAttributeBuilder
value = StringAttributeBuilder "value"
disabled :: BoolAttributeBuilder
disabled = BoolAttributeBuilder "disabled"
style :: StringAttributeBuilder
style = StringAttributeBuilder "style"
alt :: StringAttributeBuilder
alt = StringAttributeBuilder "alt"
href :: StringAttributeBuilder
href = StringAttributeBuilder "href"
autocomplete :: StringAttributeBuilder
autocomplete = StringAttributeBuilder "autocomplete"
autofocus :: BoolAttributeBuilder
autofocus = BoolAttributeBuilder "autofocus"
autoplay :: BoolAttributeBuilder
autoplay = BoolAttributeBuilder "autofocus"
autosave :: StringAttributeBuilder
autosave = StringAttributeBuilder "autosave"
charset :: StringAttributeBuilder
charset = StringAttributeBuilder "charset"
challenge :: StringAttributeBuilder
challenge = StringAttributeBuilder "challenge"
cols :: NumberAttributeBuilder
cols = ShowAttributeBuilder "cols"
rows :: NumberAttributeBuilder
rows = ShowAttributeBuilder "rows"
colspan :: StringAttributeBuilder
colspan = StringAttributeBuilder "colspan"
controls :: BoolAttributeBuilder
controls = BoolAttributeBuilder "controls"
contentEditable :: BoolAttributeBuilder
contentEditable = BoolAttributeBuilder "contenteditable"
rowspan :: StringAttributeBuilder
rowspan = StringAttributeBuilder "rowspan"
download :: StringAttributeBuilder
download = StringAttributeBuilder "download"
id :: StringAttributeBuilder
id = StringAttributeBuilder "id"
max :: NumberAttributeBuilder
max = ShowAttributeBuilder "max"
maxLength :: IntAttributeBuilder
maxLength = ShowAttributeBuilder "maxlength"
min :: NumberAttributeBuilder
min = ShowAttributeBuilder "min"
minLength :: IntAttributeBuilder
minLength = ShowAttributeBuilder "minlength"
media :: StringAttributeBuilder
media = StringAttributeBuilder "media"
method :: StringAttributeBuilder
method = StringAttributeBuilder "method"
muted :: BoolAttributeBuilder
muted = BoolAttributeBuilder "muted"
name :: StringAttributeBuilder
name = StringAttributeBuilder "name"
novalidate :: BoolAttributeBuilder
novalidate = BoolAttributeBuilder "novalidate"
accept :: StringAttributeBuilder
accept = StringAttributeBuilder "accept"
acceptCharset :: StringAttributeBuilder
acceptCharset = StringAttributeBuilder "accept-charset"
action :: StringAttributeBuilder
action = StringAttributeBuilder "action"
align :: StringAttributeBuilder
align = StringAttributeBuilder "align"
src :: StringAttributeBuilder
src = StringAttributeBuilder "src"
srcset :: StringAttributeBuilder
srcset = StringAttributeBuilder "srcset"
checked :: BoolAttributeBuilder
checked = BoolAttributeBuilder "checked"
coords :: StringAttributeBuilder
coords = StringAttributeBuilder "coords"
list :: StringAttributeBuilder
list = StringAttributeBuilder "list"
multiple :: StringAttributeBuilder
multiple = StringAttributeBuilder "multiple"
datetime :: StringAttributeBuilder
datetime = StringAttributeBuilder "datetime"
default :: StringAttributeBuilder
default = StringAttributeBuilder "default"
dirname :: StringAttributeBuilder
dirname = StringAttributeBuilder "dirname"
draggable :: StringAttributeBuilder
draggable = StringAttributeBuilder "draggable"
dropzone :: StringAttributeBuilder
dropzone = StringAttributeBuilder "dropzone"
enctype :: StringAttributeBuilder
enctype = StringAttributeBuilder "enctype"
formAction :: StringAttributeBuilder
formAction = StringAttributeBuilder "formaction"
headers :: StringAttributeBuilder
headers = StringAttributeBuilder "headers"
high :: NumberAttributeBuilder
high = ShowAttributeBuilder "high"
low :: NumberAttributeBuilder
low = ShowAttributeBuilder "low"
icon :: StringAttributeBuilder
icon = StringAttributeBuilder "icon"
integrity :: StringAttributeBuilder
integrity = StringAttributeBuilder "integrity"
isMap :: BoolAttributeBuilder
isMap = BoolAttributeBuilder "ismap"
itemProp :: StringAttributeBuilder
itemProp = StringAttributeBuilder "itemprop"
keyType :: StringAttributeBuilder
keyType = StringAttributeBuilder "keytype"
kind :: StringAttributeBuilder
kind = StringAttributeBuilder "kind"
label_ :: StringAttributeBuilder
label_ = StringAttributeBuilder "label"
lang :: StringAttributeBuilder
lang = StringAttributeBuilder "lang"
loop :: StringAttributeBuilder
loop = StringAttributeBuilder "loop"
open :: BoolAttributeBuilder
open = BoolAttributeBuilder "open"
optimum :: NumberAttributeBuilder
optimum = ShowAttributeBuilder "open"
placeholder :: StringAttributeBuilder
placeholder = StringAttributeBuilder "placeholder"
pattern :: StringAttributeBuilder
pattern = StringAttributeBuilder "pattern"
poster :: StringAttributeBuilder
poster = StringAttributeBuilder "poster"
preload :: StringAttributeBuilder
preload = StringAttributeBuilder "preload"
radiogroup :: StringAttributeBuilder
radiogroup = StringAttributeBuilder "radiogroup"
readonly :: BoolAttributeBuilder
readonly = BoolAttributeBuilder "readonly"
rel :: StringAttributeBuilder
rel = StringAttributeBuilder "rel"
required :: BoolAttributeBuilder
required = BoolAttributeBuilder "required"
reversed :: StringAttributeBuilder
reversed = StringAttributeBuilder "reversed"
scope :: StringAttributeBuilder
scope = StringAttributeBuilder "scope"
shape :: StringAttributeBuilder
shape = StringAttributeBuilder "shape"
size :: IntAttributeBuilder
size = ShowAttributeBuilder "size"
selected :: BoolAttributeBuilder
selected = BoolAttributeBuilder "selected"
sizes :: StringAttributeBuilder
sizes = StringAttributeBuilder "sizes"
step :: NumberAttributeBuilder
step = ShowAttributeBuilder "step"
spellCheck :: StringAttributeBuilder
spellCheck = StringAttributeBuilder "spellcheck"
start :: IntAttributeBuilder
start = ShowAttributeBuilder "start"
summary_ :: StringAttributeBuilder
summary_ = StringAttributeBuilder "summary"
target :: StringAttributeBuilder
target = StringAttributeBuilder "target"
tabindex :: IntAttributeBuilder
tabindex = ShowAttributeBuilder "tabindex"
title :: StringAttributeBuilder
title = StringAttributeBuilder "title"
usemap :: StringAttributeBuilder
usemap = StringAttributeBuilder "usemap"
wrap :: StringAttributeBuilder
wrap = StringAttributeBuilder "wrap"
inputType :: StringAttributeBuilder
inputType = StringAttributeBuilder "type"
role :: StringAttributeBuilder
role = StringAttributeBuilder "role"
tpe :: StringAttributeBuilder
tpe = inputType
className :: StringAttributeBuilder
className = StringAttributeBuilder "class"
class_ :: StringAttributeBuilder
class_ = className
cls :: StringAttributeBuilder
cls = className
for :: StringAttributeBuilder
for = StringAttributeBuilder "for"

insert :: InsertHookBuilder
insert = InsertHookBuilder unit

destroy :: DestroyHookBuilder
destroy = DestroyHookBuilder unit

update :: UpdateHookBuilder
update = UpdateHookBuilder unit

click :: MouseEmitterBuilder
click = MouseEmitterBuilder "click"
resize :: MouseEmitterBuilder
resize = MouseEmitterBuilder "resize"
mousedown :: MouseEmitterBuilder
mousedown = MouseEmitterBuilder "mousedown"
mouseover :: MouseEmitterBuilder
mouseover = MouseEmitterBuilder "mouseover"
mouseenter :: MouseEmitterBuilder
mouseenter = MouseEmitterBuilder "mouseenter"
mousemove :: MouseEmitterBuilder
mousemove = MouseEmitterBuilder "mousemove"
mouseleave :: MouseEmitterBuilder
mouseleave = MouseEmitterBuilder "mouseleave"
contextMenu :: MouseEmitterBuilder
contextMenu = MouseEmitterBuilder "contextmenu"
wheel :: MouseEmitterBuilder
wheel = MouseEmitterBuilder "wheel"
select_ :: MouseEmitterBuilder
select_ = MouseEmitterBuilder "select"
pointerLockChange :: MouseEmitterBuilder
pointerLockChange = MouseEmitterBuilder "pointerlockchange"
pointerLockError :: MouseEmitterBuilder
pointerLockError = MouseEmitterBuilder "pointerlockerror"
drag :: DragEmitterBuilder
drag = DragEmitterBuilder "drag"
dragStart :: DragEmitterBuilder
dragStart = DragEmitterBuilder "dragstart"
dragEnd :: DragEmitterBuilder
dragEnd = DragEmitterBuilder "dragend"
dragEnter :: DragEmitterBuilder
dragEnter = DragEmitterBuilder "dragenter"
dragOver :: DragEmitterBuilder
dragOver = DragEmitterBuilder "dragover"
dragLeave :: DragEmitterBuilder
dragLeave = DragEmitterBuilder "dragleave"
drop :: DragEmitterBuilder
drop = DragEmitterBuilder "drop"
online :: EventEmitterBuilder
online = EventEmitterBuilder "online"
offline :: EventEmitterBuilder
offline = EventEmitterBuilder "offline"
reset :: EventEmitterBuilder
reset = EventEmitterBuilder "reset"
submit :: EventEmitterBuilder
submit = EventEmitterBuilder "submit"
input_ :: InputEmitterBuilder
input_ = InputEmitterBuilder "input"
change :: InputEmitterBuilder
change = InputEmitterBuilder "change"
blur :: InputEmitterBuilder
blur = InputEmitterBuilder "blur"
keydown :: KeyEmitterBuilder
keydown = KeyEmitterBuilder "keydown"
keyup :: KeyEmitterBuilder
keyup = KeyEmitterBuilder "keyup"
keypress :: KeyEmitterBuilder
keypress = KeyEmitterBuilder "keypress"

inputString :: StringEmitterBuilder
inputString = StringEmitterBuilder "input"

inputNumber :: NumberEmitterBuilder
inputNumber = NumberEmitterBuilder "input"

inputChecked :: BoolEmitterBuilder
inputChecked = BoolEmitterBuilder "change"

valueShow :: forall s. ShowAttributeBuilder s
valueShow = ShowAttributeBuilder "value"

child :: ChildStreamReceiverBuilder
child = ChildStreamReceiverBuilder unit

children :: ChildrenStreamReceiverBuilder
children = ChildrenStreamReceiverBuilder unit

childShow :: ChildStringReceiverBuilder
childShow = ChildStringReceiverBuilder unit

infix 5 emitFrom as ==>
infix 5 bindFrom as <==
infix 5 setTo as :=

createInputHandler :: forall e. Array InputEvent -> Handler e InputEvent
createInputHandler = createHandler

createMouseHandler :: forall e. Array MouseEvent -> Handler e MouseEvent
createMouseHandler = createHandler

createKeyboardHandler :: forall e. Array KeyboardEvent -> Handler e KeyboardEvent
createKeyboardHandler = createHandler

createStringHandler :: forall e. Array String -> Handler e String
createStringHandler = createHandler

createBoolHandler :: forall e. Array Boolean -> Handler e Boolean
createBoolHandler = createHandler

createNumberHandler :: forall e. Array Number -> Handler e Number
createNumberHandler = createHandler
