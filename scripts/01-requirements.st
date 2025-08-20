| aLepiterDir allLepiterDirs unloadedLepiterDirs |

"i don’t need to track changes here, so we disable them"
EpMonitor current disable.

[

Metacello new
	repository: 'github://hellerve/gt4dd:main/src';
	baseline: 'Gt4Dd';
	load.

Metacello new
	repository: 'github://hellerve/blog:master/src';
	baseline: 'VhBlog';
	load.
#BaselineOfVhBlog asClass loadLepiter

] ensure: [ EpMonitor current enable ].

15 seconds wait.

BlHost pickHost universe snapshot: true andQuit: true.
