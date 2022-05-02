# Libraries
This contains all my generic libraries that I have made public.

Libraries also contain a "wiki" explaining how to use the library and more technical stuff.  
Learn more in the [Library Wikis](#library-wikis) section below.

***
There are three versions of the libraries; all three versions are the same:
* > ### `SOURCE`
  > Contains the full source and EmmyLua documentation of the library.  
    This version is mainly used for developing with the library as functions are described in detail, parameters have type annotations, and variables have full names.
  >
  > **This version will always be the most up-to-date.**
* > ### `COMPRESSED`
  > Contains a compressed version of the library, using as little space as possible while still keeping the indenting.  
    This is mainly used if you are just using the library (you are done developing using the library, or didn't need to.) while also having the library show up easily in minimaps or similar.
  >
  > **This version will not always be up-to-date. If it is not and you want it to be, let me know.**
* > ### `LINE`
  > Contains a compressed version of the library that exists on as few lines as possible. (Usually 2.)  
    This is mainly used if you don't want the library to take up *any* vertical space in your script.
  >
  > **This version will usually match the version of `COMPRESSED`.**
***

## How To Use (Library User)
> **If a library told you to come here to import my libraries or plan to use my libraries for personal use, this is likely where you want to look.**
> ### You likely want to use the `COMPRESSED` or `LINE` versions of my libraries unless they are out of date.

To use any of these libraries, copy and paste them in your script.

If one of my libraries requires a library, place the required library above my library.  
If a library requires one of *my* libraries, place my library above that library.

## How To Use (Avatar Creator)
> **If you are looking to use my libraries in an avatar you are making, this is likely where you want to look.**
> ### You likely want to use the `SOURCE` version of my libraries if you are making a private avatar.
> ### You likely want to use the `SOURCE` version of my libraries if you are making a public avatar. Switch to `COMPRESSED` or `LINE` when releasing the avatar.

You are allowed to put an entire library in a completed avatar or script. You are *not* however allowed to put an entire library in your library. See the [How To Use (Library Creator)](#how-to-use-library-creator) section below.

If you upload your avatar or script to the Figura mod's Discord server make sure to credit me in the avatar's or script's showcase post.

All libraries have a small credit attached to the top to allow you to paste them in and still properly credit me in-script.

If you need to edit my library to fit a specific purpose, please look at [Editing My Libraries](#editing-my-libraries) below.

## How To Use (Library Creator)
> **If you are looking to use my libraries in a library you are making, this is likely where you want to look.**
> ### You likely want to use the `SOURCE` version of my libraries.

To *properly* require one of my libraries in yours. Do *not* insert my library into yours.  
Instead, check to make sure the library's variable is set and cause an error if it is not.  
(You can find a library's variable in the README or at the end of the library's script file.)

This allows you to keep your library light while also avoiding duplicated libraries.

If you need to edit one of my libraries for better use in your library, please look at [Editing My Libraries](#editing-my-libraries) below. 


&nbsp;
## Editing My Libraries
You may edit my libraries if there is something you want to add or fix.  
You can also make a Pull Request or send me the script file directly if you want to add or fix something in the main version of my libraries.

If you edited my library to better fit yours, you are allowed to insert the *edited* library into yours.

You should still credit me, even if you edit my library.

&nbsp;
## Library Wikis
You might have noticed that the libraries have "wikis" attached to them. You can view these in Github by clicking the ***`Learn More`*** link at the bottom of the library's README file.

If you are using VSCode to read the wikis, there are better versions you can view by clicking the ***`Learn More (VSCode)`*** link instead.  
If you choose to view the files in VSCode, I recommend using the [Markdown Preview Extension by Matt Bierner](vscode:extension/bierner.github-markdown-preview) as that is the extension that is used when making the VSCode wikis.
