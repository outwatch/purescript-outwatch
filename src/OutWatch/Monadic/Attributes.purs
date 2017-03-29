module OutWatch.Monadic.Attributes where

import OutWatch.Attributes as Attr
import Data.Show (class Show)
import Data.Unit (Unit)
import OutWatch.Dom.Types (VDom)
import OutWatch.Monadic.Core (HTML, push, wrapEmitter, wrapReceiver_, wrapReceiver)
import RxJS.Observable (Observable)


-- Stream Receivers

valueShow_ :: forall e a. Show a => a -> HTML e Unit
valueShow_ = wrapReceiver_ Attr.valueShow

child_ :: forall e. Observable (VDom e) -> HTML e Unit
child_ = wrapReceiver Attr.child

children_ :: forall e. Observable (Array (VDom e)) -> HTML e Unit
children_ = wrapReceiver Attr.children

childShow_ :: forall e a. Show a => Observable a -> HTML e Unit
childShow_ = wrapReceiver Attr.childShow

-- Constant Receivers

text_ :: forall e. String -> HTML e Unit
text_ t =  push (Attr.text t)

----hidden_ :: forall e m. MonadState (Array (VDom e)) m => _ -> m Unit
hidden_ :: forall e. _ -> HTML e Unit
hidden_ = wrapReceiver_ Attr.hidden

value_ :: forall e. _ -> HTML e Unit
value_ = wrapReceiver_ Attr.value

disabled_ :: forall e. _ -> HTML e Unit
disabled_ = wrapReceiver_ Attr.disabled

style_ :: forall e. _ -> HTML e Unit
style_ = wrapReceiver_ Attr.style

alt_ :: forall e. _ -> HTML e Unit
alt_ = wrapReceiver_ Attr.alt

href_ :: forall e. _ -> HTML e Unit
href_ = wrapReceiver_ Attr.href

autocomplete_ :: forall e. _ -> HTML e Unit
autocomplete_ = wrapReceiver_ Attr.autocomplete

autofocus_ :: forall e. _ -> HTML e Unit
autofocus_ = wrapReceiver_ Attr.autofocus

autoplay_ :: forall e. _ -> HTML e Unit
autoplay_ = wrapReceiver_ Attr.autoplay

autosave_ :: forall e. _ -> HTML e Unit
autosave_ = wrapReceiver_ Attr.autosave

charset_ :: forall e. _ -> HTML e Unit
charset_ = wrapReceiver_ Attr.charset

challenge_ :: forall e. _ -> HTML e Unit
challenge_ = wrapReceiver_ Attr.challenge

cols_ :: forall e. _ -> HTML e Unit
cols_ = wrapReceiver_ Attr.cols

rows_ :: forall e. _ -> HTML e Unit
rows_ = wrapReceiver_ Attr.rows

colspan_ :: forall e. _ -> HTML e Unit
colspan_ = wrapReceiver_ Attr.colspan

controls_ :: forall e. _ -> HTML e Unit
controls_ = wrapReceiver_ Attr.controls

contentEditable_ :: forall e. _ -> HTML e Unit
contentEditable_ = wrapReceiver_ Attr.contentEditable

rowspan_ :: forall e. _ -> HTML e Unit
rowspan_ = wrapReceiver_ Attr.rowspan

download_ :: forall e. _ -> HTML e Unit
download_ = wrapReceiver_ Attr.download

id_ :: forall e. _ -> HTML e Unit
id_ = wrapReceiver_ Attr.id

max_ :: forall e. _ -> HTML e Unit
max_ = wrapReceiver_ Attr.max

maxLength_ :: forall e. _ -> HTML e Unit
maxLength_ = wrapReceiver_ Attr.maxLength

min_ :: forall e. _ -> HTML e Unit
min_ = wrapReceiver_ Attr.min

minLength_ :: forall e. _ -> HTML e Unit
minLength_ = wrapReceiver_ Attr.minLength

media_ :: forall e. _ -> HTML e Unit
media_ = wrapReceiver_ Attr.media

method_ :: forall e. _ -> HTML e Unit
method_ = wrapReceiver_ Attr.method

muted_ :: forall e. _ -> HTML e Unit
muted_ = wrapReceiver_ Attr.muted

name_ :: forall e. _ -> HTML e Unit
name_ = wrapReceiver_ Attr.name

novalidate_ :: forall e. _ -> HTML e Unit
novalidate_ = wrapReceiver_ Attr.novalidate

accept_ :: forall e. _ -> HTML e Unit
accept_ = wrapReceiver_ Attr.accept

acceptCharset_ :: forall e. _ -> HTML e Unit
acceptCharset_ = wrapReceiver_ Attr.acceptCharset

action_ :: forall e. _ -> HTML e Unit
action_ = wrapReceiver_ Attr.action

align_ :: forall e. _ -> HTML e Unit
align_ = wrapReceiver_ Attr.align

src_ :: forall e. _ -> HTML e Unit
src_ = wrapReceiver_ Attr.src

srcset_ :: forall e. _ -> HTML e Unit
srcset_ = wrapReceiver_ Attr.srcset

checked_ :: forall e. _ -> HTML e Unit
checked_ = wrapReceiver_ Attr.checked

coords_ :: forall e. _ -> HTML e Unit
coords_ = wrapReceiver_ Attr.coords

list_ :: forall e. _ -> HTML e Unit
list_ = wrapReceiver_ Attr.list

multiple_ :: forall e. _ -> HTML e Unit
multiple_ = wrapReceiver_ Attr.multiple

datetime_ :: forall e. _ -> HTML e Unit
datetime_ = wrapReceiver_ Attr.datetime

default_ :: forall e. _ -> HTML e Unit
default_ = wrapReceiver_ Attr.default

dirname_ :: forall e. _ -> HTML e Unit
dirname_ = wrapReceiver_ Attr.dirname

draggable_ :: forall e. _ -> HTML e Unit
draggable_ = wrapReceiver_ Attr.draggable

dropzone_ :: forall e. _ -> HTML e Unit
dropzone_ = wrapReceiver_ Attr.dropzone

enctype_ :: forall e. _ -> HTML e Unit
enctype_ = wrapReceiver_ Attr.enctype

formAction_ :: forall e. _ -> HTML e Unit
formAction_ = wrapReceiver_ Attr.formAction

headers_ :: forall e. _ -> HTML e Unit
headers_ = wrapReceiver_ Attr.headers

high_ :: forall e. _ -> HTML e Unit
high_ = wrapReceiver_ Attr.high

low_ :: forall e. _ -> HTML e Unit
low_ = wrapReceiver_ Attr.low

icon_ :: forall e. _ -> HTML e Unit
icon_ = wrapReceiver_ Attr.icon

integrity_ :: forall e. _ -> HTML e Unit
integrity_ = wrapReceiver_ Attr.integrity

isMap_ :: forall e. _ -> HTML e Unit
isMap_ = wrapReceiver_ Attr.isMap

itemProp_ :: forall e. _ -> HTML e Unit
itemProp_ = wrapReceiver_ Attr.itemProp

keyType_ :: forall e. _ -> HTML e Unit
keyType_ = wrapReceiver_ Attr.keyType

kind_ :: forall e. _ -> HTML e Unit
kind_ = wrapReceiver_ Attr.kind

label__ :: forall e. _ -> HTML e Unit
label__ = wrapReceiver_ Attr.label_

lang_ :: forall e. _ -> HTML e Unit
lang_ = wrapReceiver_ Attr.lang

loop_ :: forall e. _ -> HTML e Unit
loop_ = wrapReceiver_ Attr.loop

open_ :: forall e. _ -> HTML e Unit
open_ = wrapReceiver_ Attr.open

optimum_ :: forall e. _ -> HTML e Unit
optimum_ = wrapReceiver_ Attr.optimum

placeholder_ :: forall e. _ -> HTML e Unit
placeholder_ = wrapReceiver_ Attr.placeholder

pattern_ :: forall e. _ -> HTML e Unit
pattern_ = wrapReceiver_ Attr.pattern

poster_ :: forall e. _ -> HTML e Unit
poster_ = wrapReceiver_ Attr.poster

preload_ :: forall e. _ -> HTML e Unit
preload_ = wrapReceiver_ Attr.preload

radiogroup_ :: forall e. _ -> HTML e Unit
radiogroup_ = wrapReceiver_ Attr.radiogroup

readonly_ :: forall e. _ -> HTML e Unit
readonly_ = wrapReceiver_ Attr.readonly

rel_ :: forall e. _ -> HTML e Unit
rel_ = wrapReceiver_ Attr.rel

required_ :: forall e. _ -> HTML e Unit
required_ = wrapReceiver_ Attr.required

reversed_ :: forall e. _ -> HTML e Unit
reversed_ = wrapReceiver_ Attr.reversed

scope_ :: forall e. _ -> HTML e Unit
scope_ = wrapReceiver_ Attr.scope

shape_ :: forall e. _ -> HTML e Unit
shape_ = wrapReceiver_ Attr.shape

size_ :: forall e. _ -> HTML e Unit
size_ = wrapReceiver_ Attr.size

selected_ :: forall e. _ -> HTML e Unit
selected_ = wrapReceiver_ Attr.selected

sizes_ :: forall e. _ -> HTML e Unit
sizes_ = wrapReceiver_ Attr.sizes

step_ :: forall e. _ -> HTML e Unit
step_ = wrapReceiver_ Attr.step

spellCheck_ :: forall e. _ -> HTML e Unit
spellCheck_ = wrapReceiver_ Attr.spellCheck

start_ :: forall e. _ -> HTML e Unit
start_ = wrapReceiver_ Attr.start

summary__ :: forall e. _ -> HTML e Unit
summary__ = wrapReceiver_ Attr.summary_

target_ :: forall e. _ -> HTML e Unit
target_ = wrapReceiver_ Attr.target

tabindex_ :: forall e. _ -> HTML e Unit
tabindex_ = wrapReceiver_ Attr.tabindex

title_ :: forall e. _ -> HTML e Unit
title_ = wrapReceiver_ Attr.title

usemap_ :: forall e. _ -> HTML e Unit
usemap_ = wrapReceiver_ Attr.usemap

wrap_ :: forall e. String -> HTML e Unit
wrap_ = wrapReceiver_ Attr.wrap

inputType_ :: forall e. _ -> HTML e Unit
inputType_ = wrapReceiver_ Attr.inputType

role_ :: forall e. _ -> HTML e Unit
role_ = wrapReceiver_ Attr.role

tpe_ :: forall e. _ -> HTML e Unit
tpe_ = wrapReceiver_ Attr.tpe

className_ :: forall e. _ -> HTML e Unit
className_ = wrapReceiver_ Attr.className

class__ :: forall e. _ -> HTML e Unit
class__ = wrapReceiver_ Attr.class_

cls_ :: forall e. _ -> HTML e Unit
cls_ = wrapReceiver_ Attr.cls

for_ :: forall e. _ -> HTML e Unit
for_ = wrapReceiver_ Attr.for

-- insert_ :: forall e. _ -> HTML e Unit
insert_ = wrapEmitter Attr.insert

-- destroy_ :: forall e. _ -> HTML e Unit
destroy_ = wrapEmitter Attr.destroy

-- update_ :: forall e. _ -> HTML e Unit
update_ = wrapEmitter Attr.update

-- click_ :: forall e. _ -> HTML e Unit
click_ = wrapEmitter Attr.click

-- resize_ :: forall e. _ -> HTML e Unit
resize_ = wrapEmitter Attr.resize

-- mousedown_ :: forall e. _ -> HTML e Unit
mousedown_ = wrapEmitter Attr.mousedown

-- mouseover_ :: forall e. _ -> HTML e Unit
mouseover_ = wrapEmitter Attr.mouseover

-- mouseenter_ :: forall e. _ -> HTML e Unit
mouseenter_ = wrapEmitter Attr.mouseenter

-- mousemove_ :: forall e. _ -> HTML e Unit
mousemove_ = wrapEmitter Attr.mousemove

-- mouseleave_ :: forall e. _ -> HTML e Unit
mouseleave_ = wrapEmitter Attr.mouseleave

-- contextMenu_ :: forall e. _ -> HTML e Unit
contextMenu_ = wrapEmitter Attr.contextMenu

-- wheel_ :: forall e. _ -> HTML e Unit
wheel_ = wrapEmitter Attr.wheel

-- select__ :: forall e. _ -> HTML e Unit
select__ = wrapEmitter Attr.select_

-- pointerLockChange_ :: forall e. _ -> HTML e Unit
pointerLockChange_ = wrapEmitter Attr.pointerLockChange

-- pointerLockError_ :: forall e. _ -> HTML e Unit
pointerLockError_ = wrapEmitter Attr.pointerLockError

-- drag_ :: forall e. _ -> HTML e Unit
drag_ = wrapEmitter Attr.drag

-- dragStart_ :: forall e. _ -> HTML e Unit
dragStart_ = wrapEmitter Attr.dragStart

-- dragEnd_ :: forall e. _ -> HTML e Unit
dragEnd_ = wrapEmitter Attr.dragEnd

-- dragEnter_ :: forall e. _ -> HTML e Unit
dragEnter_ = wrapEmitter Attr.dragEnter

-- dragOver_ :: forall e. _ -> HTML e Unit
dragOver_ = wrapEmitter Attr.dragOver

-- dragLeave_ :: forall e. _ -> HTML e Unit
dragLeave_ = wrapEmitter Attr.dragLeave

-- drop_ :: forall e. _ -> HTML e Unit
drop_ = wrapEmitter Attr.drop

-- online_ :: forall e. _ -> HTML e Unit
online_ = wrapEmitter Attr.online

-- offline_ :: forall e. _ -> HTML e Unit
offline_ = wrapEmitter Attr.offline

-- reset_ :: forall e. _ -> HTML e Unit
reset_ = wrapEmitter Attr.reset

-- submit_ :: forall e. _ -> HTML e Unit
submit_ = wrapEmitter Attr.submit

-- input__ :: forall e. _ -> HTML e Unit
input__ = wrapEmitter Attr.input_

-- change_ :: forall e. _ -> HTML e Unit
change_ = wrapEmitter Attr.change

-- blur_ :: forall e. _ -> HTML e Unit
blur_ = wrapEmitter Attr.blur

-- keydown_ :: forall e. _ -> HTML e Unit
keydown_ = wrapEmitter Attr.keydown

-- keyup_ :: forall e. _ -> HTML e Unit
keyup_ = wrapEmitter Attr.keyup

-- keypress_ :: forall e. _ -> HTML e Unit
keypress_ = wrapEmitter Attr.keypress

-- inputString_ :: forall e. _ -> HTML e Unit
inputString_ = wrapEmitter Attr.inputString

-- inputNumber_ :: forall e. _ -> HTML e Unit
inputNumber_ = wrapEmitter Attr.inputNumber

-- inputChecked_ :: forall e. _ -> HTML e Unit
inputChecked_ = wrapEmitter Attr.inputChecked
