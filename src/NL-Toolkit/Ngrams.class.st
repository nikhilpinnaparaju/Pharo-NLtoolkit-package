Class {
	#name : #Ngrams,
	#superclass : #Object,
	#instVars : [
		'tokens',
		'nvalue'
	],
	#category : #'NL-Toolkit'
}

{ #category : #accessing }
Ngrams >> get_ngrams [
	| ngrams_list tokensize cur iters gram|
	ngrams_list := OrderedCollection new.
	tokensize := tokens size.

	iters := tokensize - nvalue + 1.
	tokens = 0 ifTrue: [ ^ngrams_list ].
	
	cur := 1.
	[ cur <= iters ] whileTrue: [ gram := (tokens copyFrom: cur to: (cur + nvalue - 1)).
	ngrams_list add: gram.
	cur := cur + 1.
	].
	
	^ngrams_list
]

{ #category : #accessing }
Ngrams >> nvalue [ 
	^ nvalue 
]

{ #category : #accessing }
Ngrams >> nvalue: newValue [
	nvalue := newValue 
]

{ #category : #accessing }
Ngrams >> tokens [ 
	^ tokens
]

{ #category : #accessing }
Ngrams >> tokens: input [
	tokens := input
]
