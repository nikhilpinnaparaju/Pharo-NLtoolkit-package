Class {
	#name : #SingleDocTfTest,
	#superclass : #TestCase,
	#instVars : [
		'tf'
	],
	#category : #'NL-Toolkit-Tests'
}

{ #category : #running }
SingleDocTfTest >> setUp [
	"setup single doc test"
   |arr|
	tf := TfIdf new.
	arr := #('Hello' '3' 'Hello').
	tf corpus: (tf build_tf_doc: arr).
	
]

{ #category : #tests }
SingleDocTfTest >> testOccurrences [
	"test if occurances are correct"
	self assert: ((tf corpus) occurrencesOf: 'Hello') equals: 2.
	self assert: ((tf corpus) occurrencesOf: '3') equals: 1.
	self assert: ((tf corpus) occurrencesOf: 'foo') equals: 0.
]
