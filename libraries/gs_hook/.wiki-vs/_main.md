### [❮ Go back](../README.md)

# GSHook: Wiki
[#ha]: ./defs.md#hookadd
[#hr]: ./defs.md#hookremove
[#hr2]: ./defs.md#hookrun
[#hgt]: ./defs.md#hookgettable

#### This wiki is updated to version `0.1.0`
> ### Pages:
> * [**Definitions**](./defs.md)
> * [**Examples**](./examples.md)

GSHook adds GMod-like hooks to Figura.

Hooks are created as functions are added to them. You are not required to "initialize" a hook as that is done as needed.

You can add a function to a hook with [<code link ulink><cf>hook.add</cf>(<ca>hook_name</ca>, <ca>identifier</ca>, <ca>func</ca>)</code>][#ha].  
You can remove a function from a hook with [<code link ulink><cf>hook.remove</cf>(<ca>hook_name</ca>, <ca>identifier</ca>)</code>][#hr].  
You can run a hook with [<code link ulink><cf>hook.run</cf>(<ca>hook_name</ca>, <ca avrg>parameters</ca>)</code>][#hr2].

You can get a list of all active hooks and their linked functions with [<code link ulink><cf>hook.getTable</cf>()</code>][#hgt]

&nbsp;  
Hooks are events that other functions can subscribe to and run when the hook does. Hooks may be passed values which are then passed to all functions connected to that hook.

Hooks will immediately end and return if one of the functions returns something other than `nil`, causing any functions after that function to not run. This allows hooks that run simply other functions and hooks that also determine the state of something else.
