### [❮ Go back](../README.md)

# GSTimer: Wiki
[#tn]: #./defs.md#timernew
[dt#tu]: #./defs/timer.md#timerupdate
[dt#tr]: #./defs/timer.md#timerrestart
[dt#ts]: #./defs/timer.md#timerstop
[dt#tp]: #./defs/timer.md#timerpause
[dt#tr2]: #./defs/timer.md#timerresume
[dt#ts2]: #./defs/timer.md#timerstate

#### This wiki is updated to version `0.1.0`
> ### Pages:
> * [**Definitions**](./defs.md)
> * [**Examples**](./examples.md)

GSTimer allows easy creation of timers.

Create a new timer with [<code link ulink><cf>Timer:New</cf>(<ca>ticks</ca>, <ca aopt>func</ca>, <ca aopt>loops</ca>)</code>][#tn].

Run a timer's update cycle with [<code link ulink><cf><<cc>Timer</cc>>:Update</cf>()</code>][#tn].

Stop and (re)start a timer with [<code link ulink><cf><<cc>Timer</cc>>:Stop</cf>()</code>][dt#ts] and [<code link ulink><cf><<cc>Timer</cc>>:Restart</cf>(<ca aopt>loops</ca>)</code>][dt#tr] respectively.  
Pause and resume a timer with [<code link ulink><cf><<cc>Timer</cc>>:Pause</cf>()</code>][dt#tp] and [<code link ulink><cf><<cc>Timer</cc>>:Resume</cf>()</code>][dt#tr2] respectively.

Get the current state of a timer with [`<Timer>:State()`][dt#ts2].
