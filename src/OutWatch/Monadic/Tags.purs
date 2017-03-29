module OutWatch.Monadic.Tags where


import OutWatch.Tags as Tag
import Control.Monad.State (class MonadState)
import Data.Unit (Unit)
import OutWatch.Dom.Types (VDom)
import OutWatch.Monadic.Core (HTML, push, wrapTag)


-- Without attributes ----------------

br_ :: forall m e. (MonadState (Array (VDom e)) m) => m Unit
br_ = push (Tag.br [])

hr_ :: forall m e. (MonadState (Array (VDom e)) m) => m Unit
hr_ = push (Tag.hr [])

-- With attributes -----------------
a_ :: forall e. HTML e Unit -> HTML e Unit 
a_ = wrapTag Tag.a

abbr_ :: forall e. HTML e Unit -> HTML e Unit 
abbr_ = wrapTag Tag.abbr

address_ :: forall e. HTML e Unit -> HTML e Unit 
address_ = wrapTag Tag.address

area_ :: forall e. HTML e Unit -> HTML e Unit 
area_ = wrapTag Tag.area

article_ :: forall e. HTML e Unit -> HTML e Unit 
article_ = wrapTag Tag.article

aside_ :: forall e. HTML e Unit -> HTML e Unit 
aside_ = wrapTag Tag.aside

audio_ :: forall e. HTML e Unit -> HTML e Unit 
audio_ = wrapTag Tag.audio

b_ :: forall e. HTML e Unit -> HTML e Unit 
b_ = wrapTag Tag.b

base_ :: forall e. HTML e Unit -> HTML e Unit 
base_ = wrapTag Tag.base

bdi_ :: forall e. HTML e Unit -> HTML e Unit 
bdi_ = wrapTag Tag.bdi

bdo_ :: forall e. HTML e Unit -> HTML e Unit 
bdo_ = wrapTag Tag.bdo

blockquote_ :: forall e. HTML e Unit -> HTML e Unit 
blockquote_ = wrapTag Tag.blockquote

button_ :: forall e. HTML e Unit -> HTML e Unit 
button_ = wrapTag Tag.button

canvas_ :: forall e. HTML e Unit -> HTML e Unit 
canvas_ = wrapTag Tag.canvas

caption_ :: forall e. HTML e Unit -> HTML e Unit 
caption_ = wrapTag Tag.caption

cite_ :: forall e. HTML e Unit -> HTML e Unit 
cite_ = wrapTag Tag.cite

code_ :: forall e. HTML e Unit -> HTML e Unit 
code_ = wrapTag Tag.code

col_ :: forall e. HTML e Unit -> HTML e Unit 
col_ = wrapTag Tag.col

colgroup_ :: forall e. HTML e Unit -> HTML e Unit 
colgroup_ = wrapTag Tag.colgroup

datalist_ :: forall e. HTML e Unit -> HTML e Unit 
datalist_ = wrapTag Tag.datalist

dd_ :: forall e. HTML e Unit -> HTML e Unit 
dd_ = wrapTag Tag.dd

del_ :: forall e. HTML e Unit -> HTML e Unit 
del_ = wrapTag Tag.del

details_ :: forall e. HTML e Unit -> HTML e Unit 
details_ = wrapTag Tag.details

dfn_ :: forall e. HTML e Unit -> HTML e Unit 
dfn_ = wrapTag Tag.dfn

dialog_ :: forall e. HTML e Unit -> HTML e Unit 
dialog_ = wrapTag Tag.dialog

div_ :: forall e. HTML e Unit -> HTML e Unit 
div_ = wrapTag Tag.div

dl_ :: forall e. HTML e Unit -> HTML e Unit 
dl_ = wrapTag Tag.dl

dt_ :: forall e. HTML e Unit -> HTML e Unit 
dt_ = wrapTag Tag.dt

em_ :: forall e. HTML e Unit -> HTML e Unit 
em_ = wrapTag Tag.em

embed_ :: forall e. HTML e Unit -> HTML e Unit 
embed_ = wrapTag Tag.embed

fieldset_ :: forall e. HTML e Unit -> HTML e Unit 
fieldset_ = wrapTag Tag.fieldset

figcaption_ :: forall e. HTML e Unit -> HTML e Unit 
figcaption_ = wrapTag Tag.figcaption

figure_ :: forall e. HTML e Unit -> HTML e Unit 
figure_ = wrapTag Tag.figure

footer_ :: forall e. HTML e Unit -> HTML e Unit 
footer_ = wrapTag Tag.footer

form_ :: forall e. HTML e Unit -> HTML e Unit 
form_ = wrapTag Tag.form

h1_ :: forall e. HTML e Unit -> HTML e Unit 
h1_= wrapTag Tag.h1

h2_ :: forall e. HTML e Unit -> HTML e Unit 
h2_ = wrapTag Tag.h2

h3_ :: forall e. HTML e Unit -> HTML e Unit 
h3_ = wrapTag Tag.h3

h4_ :: forall e. HTML e Unit -> HTML e Unit 
h4_ = wrapTag Tag.h4

h5_ :: forall e. HTML e Unit -> HTML e Unit 
h5_ = wrapTag Tag.h5

h6_ :: forall e. HTML e Unit -> HTML e Unit 
h6_ = wrapTag Tag.h6

header_ :: forall e. HTML e Unit -> HTML e Unit 
header_ = wrapTag Tag.header

i_ :: forall e. HTML e Unit -> HTML e Unit 
i_ = wrapTag Tag.i

iframe_ :: forall e. HTML e Unit -> HTML e Unit 
iframe_ = wrapTag Tag.iframe

img_ :: forall e. HTML e Unit -> HTML e Unit 
img_ = wrapTag Tag.img

input_ :: forall e. HTML e Unit -> HTML e Unit 
input_ = wrapTag Tag.input

ins_ :: forall e. HTML e Unit -> HTML e Unit 
ins_ = wrapTag Tag.ins

keygen_ :: forall e. HTML e Unit -> HTML e Unit 
keygen_ = wrapTag Tag.keygen

label_ :: forall e. HTML e Unit -> HTML e Unit 
label_ = wrapTag Tag.label

legend_ :: forall e. HTML e Unit -> HTML e Unit 
legend_ = wrapTag Tag.legend

li_ :: forall e. HTML e Unit -> HTML e Unit 
li_ = wrapTag Tag.li

main_ :: forall e. HTML e Unit -> HTML e Unit 
main_ = wrapTag Tag.main

mark_ :: forall e. HTML e Unit -> HTML e Unit 
mark_ = wrapTag Tag.mark

menu_ :: forall e. HTML e Unit -> HTML e Unit 
menu_ = wrapTag Tag.menu

menuitem_ :: forall e. HTML e Unit -> HTML e Unit 
menuitem_ = wrapTag Tag.menuitem

meter_ :: forall e. HTML e Unit -> HTML e Unit 
meter_ = wrapTag Tag.meter

nav_ :: forall e. HTML e Unit -> HTML e Unit 
nav_ = wrapTag Tag.nav

ol_ :: forall e. HTML e Unit -> HTML e Unit 
ol_ = wrapTag Tag.ol

optgroup_ :: forall e. HTML e Unit -> HTML e Unit 
optgroup_ = wrapTag Tag.optgroup

option_ :: forall e. HTML e Unit -> HTML e Unit 
option_ = wrapTag Tag.option

output_ :: forall e. HTML e Unit -> HTML e Unit 
output_ = wrapTag Tag.output

p_ :: forall e. HTML e Unit -> HTML e Unit 
p_ = wrapTag Tag.p

param_ :: forall e. HTML e Unit -> HTML e Unit 
param_ = wrapTag Tag.param

pre_ :: forall e. HTML e Unit -> HTML e Unit 
pre_ = wrapTag Tag.pre

progress_ :: forall e. HTML e Unit -> HTML e Unit 
progress_ = wrapTag Tag.progress

section_ :: forall e. HTML e Unit -> HTML e Unit 
section_ = wrapTag Tag.section

select_ :: forall e. HTML e Unit -> HTML e Unit 
select_ = wrapTag Tag.select

small_ :: forall e. HTML e Unit -> HTML e Unit 
small_ = wrapTag Tag.small

span_ :: forall e. HTML e Unit -> HTML e Unit 
span_ = wrapTag Tag.span

strong_ :: forall e. HTML e Unit -> HTML e Unit 
strong_ = wrapTag Tag.strong

sub_ :: forall e. HTML e Unit -> HTML e Unit 
sub_ = wrapTag Tag.sub

summary_ :: forall e. HTML e Unit -> HTML e Unit 
summary_ = wrapTag Tag.summary

sup_ :: forall e. HTML e Unit -> HTML e Unit 
sup_ = wrapTag Tag.sup

table_ :: forall e. HTML e Unit -> HTML e Unit 
table_ = wrapTag Tag.table

tbody_ :: forall e. HTML e Unit -> HTML e Unit 
tbody_ = wrapTag Tag.tbody

td_ :: forall e. HTML e Unit -> HTML e Unit 
td_ = wrapTag Tag.td

textarea_ :: forall e. HTML e Unit -> HTML e Unit 
textarea_ = wrapTag Tag.textarea

tfoot_ :: forall e. HTML e Unit -> HTML e Unit 
tfoot_ = wrapTag Tag.tfoot

th_ :: forall e. HTML e Unit -> HTML e Unit 
th_ = wrapTag Tag.th

thead_ :: forall e. HTML e Unit -> HTML e Unit 
thead_ = wrapTag Tag.thead

time_ :: forall e. HTML e Unit -> HTML e Unit 
time_ = wrapTag Tag.time

tr_ :: forall e. HTML e Unit -> HTML e Unit 
tr_ = wrapTag Tag.tr

track_ :: forall e. HTML e Unit -> HTML e Unit 
track_ = wrapTag Tag.track

ul_ :: forall e. HTML e Unit -> HTML e Unit 
ul_ = wrapTag Tag.ul

video_ :: forall e. HTML e Unit -> HTML e Unit 
video_ = wrapTag Tag.video

wbr_ :: forall e. HTML e Unit -> HTML e Unit 
wbr_ = wrapTag Tag.wbr
