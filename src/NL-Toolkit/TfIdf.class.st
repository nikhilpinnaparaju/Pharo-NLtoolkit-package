Class {
	#name : #TfIdf,
	#superclass : #Object,
	#instVars : [
		'corpus',
		'tfidf_table',
		'vocab'
	],
	#category : #'NL-Toolkit'
}

{ #category : #'as yet unclassified' }
TfIdf >> bow: doc [
	"comment stating purpose of message"

	| bagofwords |
	bagofwords := Bag new.
	
	doc do: [ :each | bagofwords add: each ].
	
	^bagofwords
]

{ #category : #'as yet unclassified' }
TfIdf >> build_tf_doc: doc [
	"calculate Term frequencies of a single doc"
	| tokens len tfs |
	tokens := Bag new.
	len := 0.
	doc do: [ :each | tokens add: each.
							len := len + 1
		 ].
	tfs := OrderedDictionary new.
	vocab do: [ :each | tfs at: each put: ((tokens occurrencesOf: each)/len) ].
	^tfs
]

{ #category : #'as yet unclassified' }
TfIdf >> build_tfidf [
	"Build TF-IDF Dataframe from tokenized corpus"
	
	| tfvect tftable idfvect |
	tfvect := OrderedCollection new.
	
	self build_vocab.
	corpus do: [ :each | tfvect add: (((self build_tf_doc: each) values) asPMVector) . ].
	
	tfvect := tfvect asArray.
	vocab := vocab asArray.
	
	idfvect := vocab collect: [ :each | self idf: each ]. 
	idfvect := idfvect asPMVector.
	tfvect := tfvect collect: [:each | each dot: idfvect ].
	
	tftable := DataFrame withRows: tfvect columnNames: vocab.
	^tftable   
]

{ #category : #'as yet unclassified' }
TfIdf >> build_vocab [
	"Build Vocabulary from tokenized corpus"
	vocab := Set  new.
	corpus do: [ :each |	vocab := vocab union: (each asSet). ] .
	^vocab
]

{ #category : #accessing }
TfIdf >> corpus [
	^corpus
]

{ #category : #accessing }
TfIdf >> corpus: newCorpus [
	"pass corpus"

	corpus := newCorpus
]

{ #category : #'as yet unclassified' }
TfIdf >> idf: word [
	"calculate idf for a word"

	| n k bow_corpus |
	n := (self corpus) size.
	k := n.
	
	bow_corpus := corpus collect: [ :each | self bow: each ].
	bow_corpus do: [ :each | (each occurrencesOf: word) = 0 ifTrue: [k:= k-1]].
	
	^((n/k) log).
]

{ #category : #'as yet unclassified' }
TfIdf >> tfidfvector: doc [
	"tfidf vector for each word in doc"

	| vect |
	vect := Dictionary new.
	doc keysDo: [ :key | vect at: key put: ((self idf: key) * (doc at: key))].
	
	^vect
]
