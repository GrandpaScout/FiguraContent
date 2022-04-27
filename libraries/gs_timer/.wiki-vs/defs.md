### [❮ Go back](../README.md) ❙ [Main Page](./_main.md)

# GSTimer: Definitions
[#t]: #timer
[#tn]: #timernew
[dt#t]: .defs/timer.md#timer

> ### Pages:
> * [**Timer Class**](./defs/timer.md)

# Library
### Contents:
> * [`Timer`][#t]
>   * [`Timer:New()`][#tn]
***

## `Timer`
### [<cc link>`Timer`</cc>][dt#t]
> The base Timer that all Timer objects inherit from.

&nbsp;
## `Timer:New()`
<pre>
<cf>Timer:New</cf>(<ca>ticks</ca>:&nbsp;<ct>number</ct>, <ca aopt>func</ca>:&nbsp;<ct>function</ct>, <ca aopt>loops</ca>:&nbsp;<ct>number</ct>)
  ► <cc>Timer</cc>
</pre>
> ## Parameters:
> ### <ca>`ticks`</ca>
> > ##### <ct>`number`</ct>
> > The amount of times the new timer needs to update before it triggers.  
> > Timers are usually updated in the `tick` event which leads to tick timers, but the timer can also be updated in the `render` event or even updated whenever something happens to treat it as a counter.
> ### <ca opt>`func`</ca>
> > ##### <ct>`function`</ct>
> > The function to run when the new timer hits 0.  
> > This can be left blank to make the timer do nothing.
> ### <ca opt>`loops`</ca>
> > ##### <ct>`number`</ct>
> > The amount of times the timer should loop before completely stopping.  
> > <cv>`0`</cv> means it shouldn't loop at all, <cv>`-1`</cv> means it should loop forever.
> ## Returns:
> ### [<cc link>`Timer`</cc>][dt#t]
> > The new timer. The timer is ready to accept updates as soon as it is created.
> ## Description:
> Creates a new timer.
