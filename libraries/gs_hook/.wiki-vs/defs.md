### [❮ Go back](../README.md) ❙ [Main Page](./_main.md)

# GSHook: Definitions
[@hf]: #hookfunction
[@ht]: #hooktable
[#h]: #hook
[#ha]: #hookadd
[#hr]: #hookremove
[#hr2]: #hookrun
[#hgt]: #hookgettable

# Types
### Contents:
> * [`HookFunction`][@hf]
> * [`HookTable`][@ht]
***

## `HookFunction`
<pre>
<ct>func</ct>(<ca avrg>parameters</ca>:&nbsp;<ct>any</ct>)
  ► <ct amt=6>any</ct>
</pre>
> ## Parameters:
> ### <ca vrg>`parameters`</ca>
> > ##### <ct>`any`</ct>
> > The parameters that were passed in by [<code link ulink><cf>hook.run</cf>()</code>][#hr].
> ## Returns:
> ### <ct amt=6>`any`</ct>
> > The values to return from this function and from the hook.  
> > Return <cv>`nil`</cv> as the first value (or don't return at all) to continue the hook.
> ## Description:
> A function used by a hook.

&nbsp;
## `HookTable`
<pre>
<cv>{</cv>
  [<ca>hook_name</ca>:&nbsp;<ct>string</ct>]:&nbsp;<cv>{</cv>
    [<ca>identifier</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>]:&nbsp;<cc>HookFunction</cc>
  <cv>}
}</cv>
</pre>
> ## Description:
> A table containing all of the hooks and their functions.  
> It is *not* recommended to add or remove hooks or hook functions from this table manually as there is some internal stuff that is not properly synced if this happens. You *can* swap out functions however.

&nbsp;
# Library
### Contents:
> * [`hook`][#h]
>   * [`hook.add()`][#ha]
>   * [`hook.remove()`][#hr]
>   * [`hook.run()`][#hr2]
>   * [`hook.getTable()`][#hgt]
***

## `hook`
### <ct>`table`</ct>
> Contains the entire hook library.

&nbsp;
## `hook.add()`
<pre>
<cf>hook.add</cf>(<ca>hook_name</ca>:&nbsp;<ct>string</ct>, <ca>identifier</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>, <ca>func</ca>:&nbsp;<cc>HookFunction</cc>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`hook_name`</ca>
> > ##### <ct>`string`</ct>
> > The name of the hook to add the function to.
> ### <ca>`identifier`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The unique identifier that identifies and orders the function.
> ### <ca>`func`</ca>
> > ##### [<cc link>`HookFunction`</cc>][@hf]
> > The function to add to this hook.  
> > This function can accept any amount of parameters which are passed in when the hook runs. The meaning of these parameters changes from hook to hook.  
> > If this function returns a non-<cv>`nil`</cv> first value, it will stop the hook immediately and cause the hook to return the returned values.
> ## Description:
> Adds a function to a hook. All functions added to a hook run when the hook does.  
> <ca>`func`</ca> can accept a variable amount of arguments which are passed through when [<code link ulink><cf>hook.run</cf>()</code>][#hr2] is called.  
> If a function returns a non-nil first value, the hook is stopped immediately and the returned values are returned by the hook.

&nbsp;
## `hook.remove()`
<pre>
<cf>hook.remove</cf>(<ca>hook_name</ca>:&nbsp;<ct>string</ct>, <ca>identifier</ca>:&nbsp;<ct>string</ct>|<ct>number</ct>)
  ► <ct>void</ct>
</pre>
> ## Parameters:
> ### <ca>`hook_name`</ca>
> > ##### <ct>`string`</ct>
> > The name of the hook to remove the function from.
> ### <ca>`identifier`</ca>
> > ##### <ct>`string`</ct> **or** <ct>`number`</ct>
> > The unique identifier of the function to remove.
> ## Description:
> Removes a function from a hook.  
> This can be used to reduce the cost of a hook by at *least* 12 instructions per function for an extended period.  
> Do not use this to constantly remove and add a hook; it is expensive to recalculate the hook order.

&nbsp;
## `hook.run()`
<pre>
<cf>hook.run</cf>(<ca>hook_name</ca>:&nbsp;<ct>string</ct>, <ca avrg>parameters</ca>:&nbsp;<ct>any</ct>)
  ► <ct amt=6>any</ct>
</pre>
> ## Parameters:
> ### <ca>`hook_name`</ca>
> > ##### <ct>`string`</ct>
> > The name of the hook to run.
> ### <ca vrg>`parameters`</ca>
> > ##### <ct>`any`</ct>
> > The values to send with the hook.
> ## Returns:
> ### <ct amt=6>`any`</ct>
> > The values this hook returned.  
> > If no function in the hook returned anything this will be <cv>`nil`</cv>.
> ## Description:
> Runs a hook, causing all functions added to that hook to run in order.  
> The following order is used:
> * **First:** All <ct>`numerical`</ct> identifiers in numerical order
> * **Second:** All <ct>`string`</ct> identifiers in character order. (Not quite alphanumeric order since strings containing *any* characters are ordered, not just A-Z and 0-9.)

&nbsp;
## `hook.getTable()`
<pre>
<cf>hook.getTable</cf>()
  ► <cc>HookTable</cc>
</pre>
> ## Returns:
> > ### [<cc link>`HookTable`</cc>][@ht]
> > A table containing all of the hooks and their functions.
> ## Description:
> Returns a table containing hooks and their contained functions. This is mostly for *viewing* purposes since there is some internal sorting done that is not reflected in the hook table.
