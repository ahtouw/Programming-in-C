#	hw4-1.py
#	William Ah Tou
#	3/12/17
#	Mustafa Al-Lail

from itertools import chain
from collections import Counter
import sys

def genListItems(tupleList):
	return list(chain.from_iterable(tupleList))

def createTupleList(fileName):
	inFile = open(fileName, "r")				           	# File initially opened to get number of lines
	lineStrings = inFile.readlines()			
	numLine = len(lineStrings)						# Number of lines given in file
	inFile.close()
	if numLine:
		inFile = open(fileName, "r")
		parseFile = []
		dataList = []
		for i in range(0, numLine):				
			lineString = inFile.readline()
			words = lineString.split()
			for word in words:
				dataList.append(word)
			parseFile.append(dataList)
			parseFile.append([])
			dataList = []
		parseFile.pop()
		tupleList = [tuple(l) for l in parseFile]
		inFile.close()
	else:
		tupleList = []
	return tupleList

txtFile = sys.argv[1]
tupleList = createTupleList(txtFile)

count = Counter()
for word in genListItems(tupleList):
	count[word] += 1
wordCount = dict(count)
print(wordCount)

filtTuple = list(filter(lambda x: x != (), tupleList))
print(filtTuple)