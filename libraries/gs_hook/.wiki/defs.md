### [❮ Go back](../) ❙ [Main Page](./_main.md)

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
```ts
func(...parameters: any)
  ► any × 6
```
> ## Parameters:
> ### `...parameters`
> > ##### `any`
> > The parameters that were passed in by [`hook.run()`][#hr].
> ## Returns:
> ### `any` × 6
> > The values to return from this function and from the hook.  
> > Return `nil` as the first value (or don't return at all) to continue the hook.
> ## Description:
> A function used by a hook.

&nbsp;
## `HookTable`
```ts
{
  [hook_name: string]: {
    [identifier: string|number]: HookFunction
  }
}
```
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
### `table`
> Contains the entire hook library.

&nbsp;
## `hook.add()`
```ts
hook.add(hook_name: string, identifier: string|number, func: HookFunction)
  ► void
```
> ## Parameters:
> ### `hook_name`
> > ##### `string`
> > The name of the hook to add the function to.
> ### `identifier`
> > ##### `string` **or** `number`
> > The unique identifier that identifies and orders the function.
> ### `func`
> > ##### [`HookFunction`]
> > The function to add to this hook.  
> > This function can accept any amount of parameters which are passed in when the hook runs. The meaning of these parameters changes from hook to hook.  
> > If this function returns a non-`nil` first value, it will stop the hook immediately and cause the hook to return the returned values.
> ## Description:
> Adds a function to a hook. All functions added to a hook run when the hook does.  
> `func` can accept a variable amount of arguments which are passed through when [`hook.run()`] is called.  
> If a function returns a non-nil first value, the hook is stopped immediately and the returned values are returned by the hook.

&nbsp;
## `hook.remove()`
```ts
hook.remove(hook_name: string, identifier: string|number)
  ► void
```
> ## Parameters:
> ### `hook_name`
> > ##### `string`
> > The name of the hook to remove the function from.
> ### `identifier`
> > ##### `string` **or** `number`
> > The unique identifier of the function to remove.
> ## Description:
> Removes a function from a hook.  
> This can be used to reduce the cost of a hook by at *least* 12 instructions per function for an extended period.

&nbsp;
## `hook.run()`
```ts
hook.run(hook_name: string, ...parameters: any)
  ► any × 6
```
> ## Parameters:
> ### `hook_name`
> > ##### `string`
> > The name of the hook to run.
> ### `...parameters`
> > ##### `any`
> > The values to send with the hook.
> ## Returns:
> ### `any` × 6
> > The values this hook returned.  
> > If no function in the hook returned anything this will be `nil`.
> ## Description:
> Runs a hook, causing all functions added to that hook to run in order.  
> The following order is used:
> * **First:** All `number` identifiers in numerical order
> * **Second:** All `string` identifiers in character order. (Not quite alphanumeric order since strings containing *any* characters are ordered, not just A-Z and 0-9.)

&nbsp;
## `hook.getTable()`
```ts
hook.getTable()
  ► HookTable
```
> ## Returns:
> > ### [`HookTable`]
> > A table containing all of the hooks and their functions.
> ## Description:
> Returns a table containing hooks and their contained functions. This is mostly for *viewing* purposes since there is some internal sorting done that is not reflected in the hook table.
