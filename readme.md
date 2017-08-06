#WebCmd

A locally hosted replacement for Yubnub



##Usage

Create the file ~/.webcmd.json in your home directory with a content similar to this:

    {
      "g": "https://www.google.com/search?q=%s",
      "wp": "https://en.wikipedia.org/?search=%s",
      "gim": "https://www.google.com/search?q=%s&um=1&ie=UTF-8&hl=en&tbm=isch",
      "twits": "https://twitter.com/#!/search/%s"
    }

Then start "webcmd.rb". Add a new search engine in your browser, with the url
`http://localhost:8000/?q=%s` (the exact syntax might be different, this is
an example for Google Chrome)

Now you can use "g webcmd" as a shortcut for a google search.

You can stop the server by using the `server:stop` command. Type `server:help`
to see all available commands.
