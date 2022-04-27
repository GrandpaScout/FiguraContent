### [❮ Go back](../)

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

Create a new timer with [`Timer:New(ticks, func?, loops?)`][#tn].

Run a timer's update cycle with [`<Timer>:Update()`][#tn].

Stop and (re)start a timer with [`<Timer>:Stop()`][dt#ts] and [`<Timer>:Restart(loops?)`][dt#tr] respectively.  
Pause and resume a timer with [`<Timer>:Pause()`][dt#tp] and [`<Timer>:Resume()`][dt#tr2] respectively.

Get the current state of a timer with [`<Timer>:State()`][dt#ts2].
