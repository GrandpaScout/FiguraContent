### [❮ Go back](../../README.md) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

# GSName: Name Class
[#tn]: ../defs.md#timernew

[dt#t]: #timer
[dt#tu]: #timerupdate
[dt#tr]: #timerrestart
[dt#ts]: #timerstop
[dt#tp]: #timerpause
[dt#tr2]: #timerresume
[dt#ts2]: #timerstate

# Library
### Contents:
> * [`<Timer>`][dt#t]
>   * [`<Timer>:Update()`][dt#tu]
>   * [`<Timer>:Restart()`][dt#tr]
>   * [`<Timer>:Stop()`][dt#ts]
>   * [`<Timer>:Pause()`][dt#tp]
>   * [`<Timer>:Resume()`][dt#tr2]
>   * [`<Timer>:State()`][dt#ts2]
***

## `<Timer>`
### `Timer`
> A Timer instance. The main object of the library.

&nbsp;
## `<Timer>:Update()`
<pre>
<cf><<cc>Timer</cc>>:Update</cf>()
  ► <ct>void</ct>
</pre>
> ## Description:
> Makes the timer tick down once. If this update causes the timer to hit 0, the timer triggers.

&nbsp;
## `<Timer>:Restart(loops?)`
<pre>
<cf><<cc>Timer</cc>>:Restart</cf>(<ca aopt>loops</ca>:&nbsp;<ct>number</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca opt>`loops`</ca>
> > ##### <ct>`number`</ct>
> > The amount of times the timer should loop after restarting.  
> > The same logic used for [<code link ulink><cf>Timer:New</cf>(<ca>ticks</ca>, <ca aopt>func</ca>, <ca aopt>loops</ca>)</code>][#tn] is used.
> ## Description:
> (Re)starts a timer. Restarting is the only way to bring a timer back from being stopped.  
> Optionally takes a number of loops.

&nbsp;
## `<Timer>:Stop()`
<pre>
<cf><<cc>Timer</cc>>:Stop</cf>()
  ► <ct>void</ct>
</pre>
> ## Description:
> Stops the timer completely, removing all remaining time and loops without triggering the timer.

&nbsp;
## `<Timer>:Pause()`
<pre>
<cf><<cc>Timer</cc>>:Pause</cf>()
  ► <ct>void</ct>
</pre>
> ## Description:
> Stops the timer without removing remaining time or loops. This allows resuming of the timer later.

&nbsp;
## `<Timer>:Resume()`
<pre>
<cf><<cc>Timer</cc>>:Resume</cf>()
  ► <ct>void</ct>
</pre>
> ## Description:
> Starts a paused timer. This cannot start stopped timers as there is no time or loops to go through anymore.

&nbsp;
## `<Timer>:State()`
<pre>
<cf><<cc>Timer</cc>>:State</cf>()
  ► <cv>"running"</cv>|<cv>"paused"</cv>|<cv>"stopped"</cv>
</pre>
> ## Returns:
> ### <cv>`"running"`</cv> **or** <cv>`"paused"`</cv> **or** <cv>`"stopped"`</cv>
> > The state that the timer is in.
> >
> > <cv>`"running"`</cv> if the timer is accepting updates,  
> > <cv>`"paused"`</cv> if the timer is not accepting updates but can be resumed.  
> > <cv>`"stopped"`</cv> if the timer can't accept updates and can't be resumed.
> ## Description:
> Returns the current state of the timer as a string.
