module OutWatch.Monadic.Attributes where

import OutWatch.Attributes as Attr
import Data.Show (class Show)
import Data.Unit (Unit)
import OutWatch.Dom.Types (VDom)
import OutWatch.Monadic.Core (HTML, push, wrapEmitter, wrapConstantReceiver, wrapReceiver)
import RxJS.Observable (Observable)


-- Stream Receivers

valueShow_ :: forall e a. Show a => a -> HTML e Unit
valueShow_ = wrapConstantReceiver Attr.valueShow

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
hidden_ = wrapConstantReceiver Attr.hidden

value_ :: forall e. _ -> HTML e Unit
value_ = wrapConstantReceiver Attr.value

disabled_ :: forall e. _ -> HTML e Unit
disabled_ = wrapConstantReceiver Attr.disabled

style_ :: forall e. _ -> HTML e Unit
style_ = wrapConstantReceiver Attr.style

alt_ :: forall e. _ -> HTML e Unit
alt_ = wrapConstantReceiver Attr.alt

href_ :: forall e. _ -> HTML e Unit
href_ = wrapConstantReceiver Attr.href

autocomplete_ :: forall e. _ -> HTML e Unit
autocomplete_ = wrapConstantReceiver Attr.autocomplete

autofocus_ :: forall e. _ -> HTML e Unit
autofocus_ = wrapConstantReceiver Attr.autofocus

autoplay_ :: forall e. _ -> HTML e Unit
autoplay_ = wrapConstantReceiver Attr.autoplay

autosave_ :: forall e. _ -> HTML e Unit
autosave_ = wrapConstantReceiver Attr.autosave

charset_ :: forall e. _ -> HTML e Unit
charset_ = wrapConstantReceiver Attr.charset

challenge_ :: forall e. _ -> HTML e Unit
challenge_ = wrapConstantReceiver Attr.challenge

cols_ :: forall e. _ -> HTML e Unit
cols_ = wrapConstantReceiver Attr.cols

rows_ :: forall e. _ -> HTML e Unit
rows_ = wrapConstantReceiver Attr.rows

colspan_ :: forall e. _ -> HTML e Unit
colspan_ = wrapConstantReceiver Attr.colspan

controls_ :: forall e. _ -> HTML e Unit
controls_ = wrapConstantReceiver Attr.controls

contentEditable_ :: forall e. _ -> HTML e Unit
contentEditable_ = wrapConstantReceiver Attr.contentEditable

rowspan_ :: forall e. _ -> HTML e Unit
rowspan_ = wrapConstantReceiver Attr.rowspan

download_ :: forall e. _ -> HTML e Unit
download_ = wrapConstantReceiver Attr.download

id_ :: forall e. _ -> HTML e Unit
id_ = wrapConstantReceiver Attr.id

max_ :: forall e. _ -> HTML e Unit
max_ = wrapConstantReceiver Attr.max

maxLength_ :: forall e. _ -> HTML e Unit
maxLength_ = wrapConstantReceiver Attr.maxLength

min_ :: forall e. _ -> HTML e Unit
min_ = wrapConstantReceiver Attr.min

minLength_ :: forall e. _ -> HTML e Unit
minLength_ = wrapConstantReceiver Attr.minLength

media_ :: forall e. _ -> HTML e Unit
media_ = wrapConstantReceiver Attr.media

method_ :: forall e. _ -> HTML e Unit
method_ = wrapConstantReceiver Attr.method

muted_ :: forall e. _ -> HTML e Unit
muted_ = wrapConstantReceiver Attr.muted

name_ :: forall e. _ -> HTML e Unit
name_ = wrapConstantReceiver Attr.name

novalidate_ :: forall e. _ -> HTML e Unit
novalidate_ = wrapConstantReceiver Attr.novalidate

accept_ :: forall e. _ -> HTML e Unit
accept_ = wrapConstantReceiver Attr.accept

acceptCharset_ :: forall e. _ -> HTML e Unit
acceptCharset_ = wrapConstantReceiver Attr.acceptCharset

action_ :: forall e. _ -> HTML e Unit
action_ = wrapConstantReceiver Attr.action

align_ :: forall e. _ -> HTML e Unit
align_ = wrapConstantReceiver Attr.align

src_ :: forall e. _ -> HTML e Unit
src_ = wrapConstantReceiver Attr.src

srcset_ :: forall e. _ -> HTML e Unit
srcset_ = wrapConstantReceiver Attr.srcset

checked_ :: forall e. _ -> HTML e Unit
checked_ = wrapConstantReceiver Attr.checked

coords_ :: forall e. _ -> HTML e Unit
coords_ = wrapConstantReceiver Attr.coords

list_ :: forall e. _ -> HTML e Unit
list_ = wrapConstantReceiver Attr.list

multiple_ :: forall e. _ -> HTML e Unit
multiple_ = wrapConstantReceiver Attr.multiple

datetime_ :: forall e. _ -> HTML e Unit
datetime_ = wrapConstantReceiver Attr.datetime

default_ :: forall e. _ -> HTML e Unit
default_ = wrapConstantReceiver Attr.default

dirname_ :: forall e. _ -> HTML e Unit
dirname_ = wrapConstantReceiver Attr.dirname

draggable_ :: forall e. _ -> HTML e Unit
draggable_ = wrapConstantReceiver Attr.draggable

dropzone_ :: forall e. _ -> HTML e Unit
dropzone_ = wrapConstantReceiver Attr.dropzone

enctype_ :: forall e. _ -> HTML e Unit
enctype_ = wrapConstantReceiver Attr.enctype

formAction_ :: forall e. _ -> HTML e Unit
formAction_ = wrapConstantReceiver Attr.formAction

headers_ :: forall e. _ -> HTML e Unit
headers_ = wrapConstantReceiver Attr.headers

high_ :: forall e. _ -> HTML e Unit
high_ = wrapConstantReceiver Attr.high

low_ :: forall e. _ -> HTML e Unit
low_ = wrapConstantReceiver Attr.low

icon_ :: forall e. _ -> HTML e Unit
icon_ = wrapConstantReceiver Attr.icon

integrity_ :: forall e. _ -> HTML e Unit
integrity_ = wrapConstantReceiver Attr.integrity

isMap_ :: forall e. _ -> HTML e Unit
isMap_ = wrapConstantReceiver Attr.isMap

itemProp_ :: forall e. _ -> HTML e Unit
itemProp_ = wrapConstantReceiver Attr.itemProp

keyType_ :: forall e. _ -> HTML e Unit
keyType_ = wrapConstantReceiver Attr.keyType

kind_ :: forall e. _ -> HTML e Unit
kind_ = wrapConstantReceiver Attr.kind

label__ :: forall e. _ -> HTML e Unit
label__ = wrapConstantReceiver Attr.label_

lang_ :: forall e. _ -> HTML e Unit
lang_ = wrapConstantReceiver Attr.lang

loop_ :: forall e. _ -> HTML e Unit
loop_ = wrapConstantReceiver Attr.loop

open_ :: forall e. _ -> HTML e Unit
open_ = wrapConstantReceiver Attr.open

optimum_ :: forall e. _ -> HTML e Unit
optimum_ = wrapConstantReceiver Attr.optimum

placeholder_ :: forall e. _ -> HTML e Unit
placeholder_ = wrapConstantReceiver Attr.placeholder

pattern_ :: forall e. _ -> HTML e Unit
pattern_ = wrapConstantReceiver Attr.pattern

poster_ :: forall e. _ -> HTML e Unit
poster_ = wrapConstantReceiver Attr.poster

preload_ :: forall e. _ -> HTML e Unit
preload_ = wrapConstantReceiver Attr.preload

radiogroup_ :: forall e. _ -> HTML e Unit
radiogroup_ = wrapConstantReceiver Attr.radiogroup

readonly_ :: forall e. _ -> HTML e Unit
readonly_ = wrapConstantReceiver Attr.readonly

rel_ :: forall e. _ -> HTML e Unit
rel_ = wrapConstantReceiver Attr.rel

required_ :: forall e. _ -> HTML e Unit
required_ = wrapConstantReceiver Attr.required

reversed_ :: forall e. _ -> HTML e Unit
reversed_ = wrapConstantReceiver Attr.reversed

scope_ :: forall e. _ -> HTML e Unit
scope_ = wrapConstantReceiver Attr.scope

shape_ :: forall e. _ -> HTML e Unit
shape_ = wrapConstantReceiver Attr.shape

size_ :: forall e. _ -> HTML e Unit
size_ = wrapConstantReceiver Attr.size

selected_ :: forall e. _ -> HTML e Unit
selected_ = wrapConstantReceiver Attr.selected

sizes_ :: forall e. _ -> HTML e Unit
sizes_ = wrapConstantReceiver Attr.sizes

step_ :: forall e. _ -> HTML e Unit
step_ = wrapConstantReceiver Attr.step

spellCheck_ :: forall e. _ -> HTML e Unit
spellCheck_ = wrapConstantReceiver Attr.spellCheck

start_ :: forall e. _ -> HTML e Unit
start_ = wrapConstantReceiver Attr.start

summary__ :: forall e. _ -> HTML e Unit
summary__ = wrapConstantReceiver Attr.summary_

target_ :: forall e. _ -> HTML e Unit
target_ = wrapConstantReceiver Attr.target

tabindex_ :: forall e. _ -> HTML e Unit
tabindex_ = wrapConstantReceiver Attr.tabindex

title_ :: forall e. _ -> HTML e Unit
title_ = wrapConstantReceiver Attr.title

usemap_ :: forall e. _ -> HTML e Unit
usemap_ = wrapConstantReceiver Attr.usemap

wrap_ :: forall e. String -> HTML e Unit
wrap_ = wrapConstantReceiver Attr.wrap

inputType_ :: forall e. _ -> HTML e Unit
inputType_ = wrapConstantReceiver Attr.inputType

role_ :: forall e. _ -> HTML e Unit
role_ = wrapConstantReceiver Attr.role

tpe_ :: forall e. _ -> HTML e Unit
tpe_ = wrapConstantReceiver Attr.tpe

className_ :: forall e. _ -> HTML e Unit
className_ = wrapConstantReceiver Attr.className

class__ :: forall e. _ -> HTML e Unit
class__ = wrapConstantReceiver Attr.class_

cls_ :: forall e. _ -> HTML e Unit
cls_ = wrapConstantReceiver Attr.cls

for_ :: forall e. _ -> HTML e Unit
for_ = wrapConstantReceiver Attr.for

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
