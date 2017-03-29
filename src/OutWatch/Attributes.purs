module OutWatch.Attributes where

import OutWatch.Dom.Builder (BoolAttributeBuilder(..), ChildStreamReceiverBuilder(..), ChildStringReceiverBuilder(..), ChildrenStreamReceiverBuilder(..), IntAttributeBuilder, NumberAttributeBuilder, ShowAttributeBuilder(..), StringAttributeBuilder(..), bindFrom, setTo)
import Data.Unit (unit)
import OutWatch.Dom.EmitterBuilder (BoolEmitterBuilder(..), DestroyHookBuilder(..), DragEmitterBuilder(..), EventEmitterBuilder(..), InputEmitterBuilder(..), InsertHookBuilder(..), KeyEmitterBuilder(..), MouseEmitterBuilder(..), NumberEmitterBuilder(..), StringEmitterBuilder(..), UpdateHookBuilder(..), emitFrom)
import OutWatch.Dom.VDomModifier (VDom(..), VNode(..))
infix 5 emitFrom as ==>
infix 5 bindFrom as <==
infix 5 setTo as :=

text ::forall e. String -> VDom e
text str = VNode (StringNode str)

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
