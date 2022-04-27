### [❮ Go back](../) ❙ [Main Page](./_main.md)

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
### [`Timer`][dt#t]
> The base Timer that all Timer objects inherit from.

&nbsp;
## `Timer:New()`
```ts
Timer:New(ticks: number, func?: function, loops?: number)
  ► Timer
```
> ## Parameters:
> ### `ticks`
> > ##### `number`
> > The amount of times the new timer needs to update before it triggers.  
> > Timers are usually updated in the `tick` event which leads to tick timers, but the timer can also be updated in the `render` event or even updated whenever something happens to treat it as a counter.
> ### *`optional`* `func`
> > ##### `function`
> > The function to run when the new timer hits 0.  
> > This can be left blank to make the timer do nothing.
> ### *`optional`* `loops`
> > ##### `number`
> > The amount of times the timer should loop before completely stopping.  
> > `0` means it shouldn't loop at all, `-1` means it should loop forever.
> ## Returns:
> ### [`Timer`][dt#t]
> > The new timer. The timer is ready to accept updates as soon as it is created.
> ## Description:
> Creates a new timer.
