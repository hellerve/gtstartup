# gtstartup

in which i keep my gt image build scripts.

## usage

we call

```
bash mk.sh
```

and wait for 10 minutes or so while a development image is built. it will
be put in a directory named after the current date and time and be started
automatically.

if you need to setup `gt4gemstone` as well for Gemstone interoperability,
use `--withgs`.

```
bash mk.sh --withgs
```

this will require superuser privileges.

all other options will be ignored.

Ubuntu needs 
```
sudo apt install libgl1-mesa-dev
```

## customization

i have a few scripts that i run at startup to configure the image for my
needs. you can add your own by pasting them in the `scripts` directory,
but you will likely want to tweak what mine are doing.

currently, i use:
- `01-requirements.st`: pulls in the requirements i use (currently only `gt4dd`,
  you probably need something else).
- `02-git.st`: switches the git tool to use the cli git adapter.
- `03-llm.st`: enables experimental llm features, enables ollama, and picks
  a random llm backend as the default (because i need to test them all).
- `04-pager.st`: enables the new tree-based pager.
- `05-lepiter.st`: loads all lepiter databases in repositories we loaded.

take any and all of them at your leisure. they are mostly extremely simple.

<hr/>

have fun!
