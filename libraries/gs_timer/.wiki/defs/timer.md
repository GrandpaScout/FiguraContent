### [❮ Go back](../../) ❙ [Main Page](../_main.md) ❙ [Definitions](../defs.md)

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
```ts
<Timer>:Update()
  ► void
```
> ## Description:
> Makes the timer tick down once. If this update causes the timer to hit 0, the timer triggers.

&nbsp;
## `<Timer>:Restart(loops?)`
```ts
<Timer>:Restart(loops?: number)
  ► void
```
> ## Description:
> (Re)starts a timer. Restarting is the only way to bring a timer back from being stopped.  
> Optionally takes a number of loops. The same logic used for [`Timer:New(ticks, func?, loops?)`][#tn] is used.

&nbsp;
## `<Timer>:Stop()`
```ts
<Timer>:Stop()
  ► void
```
> ## Description:
> Stops the timer completely, removing all remaining time and loops without triggering the timer.

&nbsp;
## `<Timer>:Pause()`
```ts
<Timer>:Pause()
  ► void
```
> ## Description:
> Stops the timer without removing remaining time or loops. This allows resuming of the timer later.

&nbsp;
## `<Timer>:Resume()`
```ts
<Timer>:Resume()
  ► void
```
> ## Description:
> Starts a paused timer. This cannot start stopped timers as there is no time or loops to go through anymore.

&nbsp;
## `<Timer>:State()`
```ts
<Timer>:State()
  ► "running"|"paused"|"stopped"
```
> ## Returns:
> ### `"running"` **or** `"paused"` **or** `"stopped"`
> > The state that the timer is in.
> >
> > `"running"` if the timer is accepting updates,  
> > `"paused"` if the timer is not accepting updates but can be resumed.  
> > `"stopped"` if the timer can't accept updates and can't be resumed.
> ## Description:
> Returns the current state of the timer as a string.
