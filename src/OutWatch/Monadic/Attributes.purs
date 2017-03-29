module OutWatch.Monadic.Attributes where

import OutWatch.Attributes as Attr
import Control.Monad.Eff (Eff)
import Data.Unit (Unit)
import OutWatch.Dom.Receivers (class AttributeBuilder)
import OutWatch.Dom.Emitters (InsertHookBuilder(..))
import OutWatch.Monadic.Core (HTML, push, wrapAttribute)


----hidden_ :: forall e m. MonadState (Array (VDom e)) m => _ -> m Unit
hidden_ :: forall e. _ -> HTML e Unit
hidden_ = wrapAttribute Attr.hidden

value_ :: forall e. _ -> HTML e Unit
value_ = wrapAttribute Attr.value

disabled_ :: forall e. _ -> HTML e Unit
disabled_ = wrapAttribute Attr.disabled

style_ :: forall e. _ -> HTML e Unit
style_ = wrapAttribute Attr.style

alt_ :: forall e. _ -> HTML e Unit
alt_ = wrapAttribute Attr.alt

href_ :: forall e. _ -> HTML e Unit
href_ = wrapAttribute Attr.href

autocomplete_ :: forall e. _ -> HTML e Unit
autocomplete_ = wrapAttribute Attr.autocomplete

autofocus_ :: forall e. _ -> HTML e Unit
autofocus_ = wrapAttribute Attr.autofocus

autoplay_ :: forall e. _ -> HTML e Unit
autoplay_ = wrapAttribute Attr.autoplay

autosave_ :: forall e. _ -> HTML e Unit
autosave_ = wrapAttribute Attr.autosave

charset_ :: forall e. _ -> HTML e Unit
charset_ = wrapAttribute Attr.charset

challenge_ :: forall e. _ -> HTML e Unit
challenge_ = wrapAttribute Attr.challenge

cols_ :: forall e. _ -> HTML e Unit
cols_ = wrapAttribute Attr.cols

rows_ :: forall e. _ -> HTML e Unit
rows_ = wrapAttribute Attr.rows

colspan_ :: forall e. _ -> HTML e Unit
colspan_ = wrapAttribute Attr.colspan

controls_ :: forall e. _ -> HTML e Unit
controls_ = wrapAttribute Attr.controls

contentEditable_ :: forall e. _ -> HTML e Unit
contentEditable_ = wrapAttribute Attr.contentEditable

rowspan_ :: forall e. _ -> HTML e Unit
rowspan_ = wrapAttribute Attr.rowspan

download_ :: forall e. _ -> HTML e Unit
download_ = wrapAttribute Attr.download

id_ :: forall e. _ -> HTML e Unit
id_ = wrapAttribute Attr.id

max_ :: forall e. _ -> HTML e Unit
max_ = wrapAttribute Attr.max

maxLength_ :: forall e. _ -> HTML e Unit
maxLength_ = wrapAttribute Attr.maxLength

min_ :: forall e. _ -> HTML e Unit
min_ = wrapAttribute Attr.min

minLength_ :: forall e. _ -> HTML e Unit
minLength_ = wrapAttribute Attr.minLength

media_ :: forall e. _ -> HTML e Unit
media_ = wrapAttribute Attr.media

method_ :: forall e. _ -> HTML e Unit
method_ = wrapAttribute Attr.method

muted_ :: forall e. _ -> HTML e Unit
muted_ = wrapAttribute Attr.muted

name_ :: forall e. _ -> HTML e Unit
name_ = wrapAttribute Attr.name

novalidate_ :: forall e. _ -> HTML e Unit
novalidate_ = wrapAttribute Attr.novalidate

accept_ :: forall e. _ -> HTML e Unit
accept_ = wrapAttribute Attr.accept

acceptCharset_ :: forall e. _ -> HTML e Unit
acceptCharset_ = wrapAttribute Attr.acceptCharset

action_ :: forall e. _ -> HTML e Unit
action_ = wrapAttribute Attr.action

align_ :: forall e. _ -> HTML e Unit
align_ = wrapAttribute Attr.align

src_ :: forall e. _ -> HTML e Unit
src_ = wrapAttribute Attr.src

srcset_ :: forall e. _ -> HTML e Unit
srcset_ = wrapAttribute Attr.srcset

checked_ :: forall e. _ -> HTML e Unit
checked_ = wrapAttribute Attr.checked

coords_ :: forall e. _ -> HTML e Unit
coords_ = wrapAttribute Attr.coords

list_ :: forall e. _ -> HTML e Unit
list_ = wrapAttribute Attr.list

multiple_ :: forall e. _ -> HTML e Unit
multiple_ = wrapAttribute Attr.multiple

datetime_ :: forall e. _ -> HTML e Unit
datetime_ = wrapAttribute Attr.datetime

default_ :: forall e. _ -> HTML e Unit
default_ = wrapAttribute Attr.default

dirname_ :: forall e. _ -> HTML e Unit
dirname_ = wrapAttribute Attr.dirname

draggable_ :: forall e. _ -> HTML e Unit
draggable_ = wrapAttribute Attr.draggable

dropzone_ :: forall e. _ -> HTML e Unit
dropzone_ = wrapAttribute Attr.dropzone

enctype_ :: forall e. _ -> HTML e Unit
enctype_ = wrapAttribute Attr.enctype

formAction_ :: forall e. _ -> HTML e Unit
formAction_ = wrapAttribute Attr.formAction

headers_ :: forall e. _ -> HTML e Unit
headers_ = wrapAttribute Attr.headers

high_ :: forall e. _ -> HTML e Unit
high_ = wrapAttribute Attr.high

low_ :: forall e. _ -> HTML e Unit
low_ = wrapAttribute Attr.low

icon_ :: forall e. _ -> HTML e Unit
icon_ = wrapAttribute Attr.icon

integrity_ :: forall e. _ -> HTML e Unit
integrity_ = wrapAttribute Attr.integrity

isMap_ :: forall e. _ -> HTML e Unit
isMap_ = wrapAttribute Attr.isMap

itemProp_ :: forall e. _ -> HTML e Unit
itemProp_ = wrapAttribute Attr.itemProp

keyType_ :: forall e. _ -> HTML e Unit
keyType_ = wrapAttribute Attr.keyType

kind_ :: forall e. _ -> HTML e Unit
kind_ = wrapAttribute Attr.kind

label__ :: forall e. _ -> HTML e Unit
label__ = wrapAttribute Attr.label_

lang_ :: forall e. _ -> HTML e Unit
lang_ = wrapAttribute Attr.lang

loop_ :: forall e. _ -> HTML e Unit
loop_ = wrapAttribute Attr.loop

open_ :: forall e. _ -> HTML e Unit
open_ = wrapAttribute Attr.open

optimum_ :: forall e. _ -> HTML e Unit
optimum_ = wrapAttribute Attr.optimum

placeholder_ :: forall e. _ -> HTML e Unit
placeholder_ = wrapAttribute Attr.placeholder

pattern_ :: forall e. _ -> HTML e Unit
pattern_ = wrapAttribute Attr.pattern

poster_ :: forall e. _ -> HTML e Unit
poster_ = wrapAttribute Attr.poster

preload_ :: forall e. _ -> HTML e Unit
preload_ = wrapAttribute Attr.preload

radiogroup_ :: forall e. _ -> HTML e Unit
radiogroup_ = wrapAttribute Attr.radiogroup

readonly_ :: forall e. _ -> HTML e Unit
readonly_ = wrapAttribute Attr.readonly

rel_ :: forall e. _ -> HTML e Unit
rel_ = wrapAttribute Attr.rel

required_ :: forall e. _ -> HTML e Unit
required_ = wrapAttribute Attr.required

reversed_ :: forall e. _ -> HTML e Unit
reversed_ = wrapAttribute Attr.reversed

scope_ :: forall e. _ -> HTML e Unit
scope_ = wrapAttribute Attr.scope

shape_ :: forall e. _ -> HTML e Unit
shape_ = wrapAttribute Attr.shape

size_ :: forall e. _ -> HTML e Unit
size_ = wrapAttribute Attr.size

selected_ :: forall e. _ -> HTML e Unit
selected_ = wrapAttribute Attr.selected

sizes_ :: forall e. _ -> HTML e Unit
sizes_ = wrapAttribute Attr.sizes

step_ :: forall e. _ -> HTML e Unit
step_ = wrapAttribute Attr.step

spellCheck_ :: forall e. _ -> HTML e Unit
spellCheck_ = wrapAttribute Attr.spellCheck

start_ :: forall e. _ -> HTML e Unit
start_ = wrapAttribute Attr.start

summary__ :: forall e. _ -> HTML e Unit
summary__ = wrapAttribute Attr.summary_

target_ :: forall e. _ -> HTML e Unit
target_ = wrapAttribute Attr.target

tabindex_ :: forall e. _ -> HTML e Unit
tabindex_ = wrapAttribute Attr.tabindex

title_ :: forall e. _ -> HTML e Unit
title_ = wrapAttribute Attr.title

usemap_ :: forall e. _ -> HTML e Unit
usemap_ = wrapAttribute Attr.usemap

wrap_ :: forall e. _ -> HTML e Unit
wrap_ = wrapAttribute Attr.wrap

inputType_ :: forall e. _ -> HTML e Unit
inputType_ = wrapAttribute Attr.inputType

role_ :: forall e. _ -> HTML e Unit
role_ = wrapAttribute Attr.role

tpe_ :: forall e. _ -> HTML e Unit
tpe_ = wrapAttribute Attr.tpe

className_ :: forall e. _ -> HTML e Unit
className_ = wrapAttribute Attr.className

class__ :: forall e. _ -> HTML e Unit
class__ = wrapAttribute Attr.class_

cls_ :: forall e. _ -> HTML e Unit
cls_ = wrapAttribute Attr.cls

for_ :: forall e. _ -> HTML e Unit
for_ = wrapAttribute Attr.for

-- insert_ :: forall e. _ -> HTML e Unit
insert_ :: forall e value. (AttributeBuilder InsertHookBuilder value) => value -> HTML e Unit
insert_ = wrapAttribute Attr.insert

-- destroy_ :: forall e. _ -> HTML e Unit
destroy_ = wrapAttribute Attr.destroy

-- update_ :: forall e. _ -> HTML e Unit
update_ = wrapAttribute Attr.update

-- click_ :: forall e. _ -> HTML e Unit
click_ = wrapAttribute Attr.click

-- resize_ :: forall e. _ -> HTML e Unit
resize_ = wrapAttribute Attr.resize

-- mousedown_ :: forall e. _ -> HTML e Unit
mousedown_ = wrapAttribute Attr.mousedown

-- mouseover_ :: forall e. _ -> HTML e Unit
mouseover_ = wrapAttribute Attr.mouseover

-- mouseenter_ :: forall e. _ -> HTML e Unit
mouseenter_ = wrapAttribute Attr.mouseenter

-- mousemove_ :: forall e. _ -> HTML e Unit
mousemove_ = wrapAttribute Attr.mousemove

-- mouseleave_ :: forall e. _ -> HTML e Unit
mouseleave_ = wrapAttribute Attr.mouseleave

-- contextMenu_ :: forall e. _ -> HTML e Unit
contextMenu_ = wrapAttribute Attr.contextMenu

-- wheel_ :: forall e. _ -> HTML e Unit
wheel_ = wrapAttribute Attr.wheel

-- select__ :: forall e. _ -> HTML e Unit
select__ = wrapAttribute Attr.select_

-- pointerLockChange_ :: forall e. _ -> HTML e Unit
pointerLockChange_ = wrapAttribute Attr.pointerLockChange

-- pointerLockError_ :: forall e. _ -> HTML e Unit
pointerLockError_ = wrapAttribute Attr.pointerLockError

-- drag_ :: forall e. _ -> HTML e Unit
drag_ = wrapAttribute Attr.drag

-- dragStart_ :: forall e. _ -> HTML e Unit
dragStart_ = wrapAttribute Attr.dragStart

-- dragEnd_ :: forall e. _ -> HTML e Unit
dragEnd_ = wrapAttribute Attr.dragEnd

-- dragEnter_ :: forall e. _ -> HTML e Unit
dragEnter_ = wrapAttribute Attr.dragEnter

-- dragOver_ :: forall e. _ -> HTML e Unit
dragOver_ = wrapAttribute Attr.dragOver

-- dragLeave_ :: forall e. _ -> HTML e Unit
dragLeave_ = wrapAttribute Attr.dragLeave

-- drop_ :: forall e. _ -> HTML e Unit
drop_ = wrapAttribute Attr.drop

-- online_ :: forall e. _ -> HTML e Unit
online_ = wrapAttribute Attr.online

-- offline_ :: forall e. _ -> HTML e Unit
offline_ = wrapAttribute Attr.offline

-- reset_ :: forall e. _ -> HTML e Unit
reset_ = wrapAttribute Attr.reset

-- submit_ :: forall e. _ -> HTML e Unit
submit_ = wrapAttribute Attr.submit

-- input__ :: forall e. _ -> HTML e Unit
input__ = wrapAttribute Attr.input_

-- change_ :: forall e. _ -> HTML e Unit
change_ = wrapAttribute Attr.change

-- blur_ :: forall e. _ -> HTML e Unit
blur_ = wrapAttribute Attr.blur

-- keydown_ :: forall e. _ -> HTML e Unit
keydown_ = wrapAttribute Attr.keydown

-- keyup_ :: forall e. _ -> HTML e Unit
keyup_ = wrapAttribute Attr.keyup

-- keypress_ :: forall e. _ -> HTML e Unit
keypress_ = wrapAttribute Attr.keypress

-- inputString_ :: forall e. _ -> HTML e Unit
inputString_ = wrapAttribute Attr.inputString

-- inputNumber_ :: forall e. _ -> HTML e Unit
inputNumber_ = wrapAttribute Attr.inputNumber

-- inputChecked_ :: forall e. _ -> HTML e Unit
inputChecked_ = wrapAttribute Attr.inputChecked

-- valueShow_ :: forall e. _ -> HTML e Unit
valueShow_ = wrapAttribute Attr.valueShow

-- child_ :: forall e. _ -> HTML e Unit
child_ = wrapAttribute Attr.child

-- children_ :: forall e. _ -> HTML e Unit
children_ = wrapAttribute Attr.children

-- childShow_ :: forall e. _ -> HTML e Unit
childShow_ = wrapAttribute Attr.childShow

text_ :: forall e. String -> HTML e Unit
text_ t =  push (Attr.text t)
