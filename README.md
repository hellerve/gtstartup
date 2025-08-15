# gtstartup

in which i keep my gt image build scripts.

## usage

we call

```
bash mk.sh
```

and wait for 10 minutes or so while a development image is built.

if you need to setup `gt4gemstone` as well for Gemstone interoperability,
use `--withgs`.

```
bash mk.sh --withgs
```

this will require superuser privileges.

all other options will be ignored.

## customization

firstly, you will need to change the build script (`mk.sh`) for your system.
i use macos, so i have to use: `curl https://dl.feenk.com/scripts/mac.sh | bash`
in the script. you change the script to your os as described at the bottom
of the [download page](https://gtoolkit.com/download/) of gtoolkit. this
part should be straightforward and take 5 seconds.

i have a few scripts that i run at startup to configure the image for my
needs. you can add your own by pasting them in the `scripts` directory,
but you will likely want to tweak what mine are doing.

currently, i use:
- `requirements.st`: pulls in the requirements i use (currently only `gt4dd`,
  you probably need something else).
- `git.st`: switches the git tool to use the cli git adapter.
- `llm.st`: enables experimental llm features, enables ollama, and picks
  a random llm backend as the default (because i need to test them all).
- `pager`: enables the new tree-based pager.

take any and all of them at your leisure. they are mostly extremely simple.

<hr/>

have fun!
