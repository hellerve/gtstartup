"Load all Lepiter databases from git repositories"
allLepiterDirs := IceRepository registry copy 
	collect: [ :eachRepository | 
	eachRepository repositoryDirectory ifNotNil: [ :aRepoDir | 
		aRepoDir exists ifTrue: [
			aRepoDir directories 
				detect: [ :eachDir | 
				eachDir allFiles anySatisfy: [ :eachFile | 
					eachFile basename = LepiterCoreDefaults databasePropertiesBasename ] ]
			ifFound: [ :aDir | aDir ] 
			ifNone: [ nil ] ]
		ifFalse: [ nil ] ] ]
	thenReject: #isNil.

unloadedLepiterDirs := allLepiterDirs reject: [ :eachDir | 
	| isLoaded |
	isLoaded := false.
	LeDatabasesRegistry uniqueInstance 
		currentLoadedDefaultLogicalDatabase databasesDo: [ :eachDatabase | 
			eachDatabase localStoreRootDirectory resolve = 
				eachDir resolve ifTrue: [ 
					isLoaded := true ] ].
	isLoaded ].

unloadedLepiterDirs do: [ :eachDir | 
	LeDatabasesRegistry defaultLogicalDatabase properties
		addRegisteredDirectory: eachDir ].

"Reload Lepiter databases"
LeDatabasesRegistry default defaultLogicalDatabase reload.

15 seconds wait.

BlHost pickHost universe snapshot: true andQuit: true.
