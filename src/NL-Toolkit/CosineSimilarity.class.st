Class {
	#name : #CosineSimilarity,
	#superclass : #Object,
	#instVars : [
		'vect1',
		'vect2'
	],
	#category : #'NL-Toolkit'
}

{ #category : #'as yet unclassified' }
CosineSimilarity >> computeSimilarity [
	| score |
	score := vect1 productWithVector: vect2.
	
	^score
]

{ #category : #'instance creation' }
CosineSimilarity >> vect1: xVect vect2: yVect [
	"Vectors "
	vect1:= xVect. 
	vect2:= yVect.
]
