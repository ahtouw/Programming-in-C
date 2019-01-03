# Homework 4 - Part 3 - Substitution
#	William Ah Tou
#	3/12/17
#	Mustafa Al-Lail
import sys
import re

inFile = sys.argv[1]
outFile = sys.argv[2]

def readFile(fileName):
    with open(fileName,'r') as f:
        lines = f.read().splitlines()

    return lines
	
def writeFile(newLine):
    appendStr = newLine + '\n'

    with open(outFile,'a') as i:
        i.write(appendStr)
		
def modify(testStr):
	a = re.compile(r"(\("
				   r"\d\d\d"
				   r"\)"
				   r"\d\d\d"
				   r"\-"
				   r"\d\d\d\d)")
	b = re.compile(r"(\("
				   r"\d\d\d"
				   r"\)\-"
				   r"\d\d\d"
				   r"\-"
				   r"\d\d\d\d)")
	c = re.compile(r"(\("
				   r"\d\d\d"
				   r"\)\s"
				   r"\d\d\d"
				   r"\-"
				   r"\d\d\d\d)")
	d = re.compile(r"("
				   r"\d\d\d"
				   r"\-"
				   r"\d\d\d"
				   r"\-"
				   r"\d\d\d\d)")
	e = re.compile(r"(\("
				   r"\d\d\d"
				   r"\)"
				   r"\d\d\d"
				   r"\."
				   r"\d\d\d\d)")
	f = re.compile(r"(\("
				   r"\d\d\d"
				   r"\)\."
				   r"\d\d\d"
				   r"\."
				   r"\d\d\d\d)")
	g = re.compile(r"(\("
				   r"\d\d\d"
				   r"\)\s"
				   r"\d\d\d"
				   r"\."
				   r"\d\d\d\d)")
	h = re.compile(r"("
				   r"\d\d\d"
				   r"\."
				   r"\d\d\d"
				   r"\."
				   r"\d\d\d\d)")
	substit = testStr
	if a.search(substit):
		substit = testStr
	if b.search(substit):
		substit = re.sub(r"(\(\d\d\d\))-(\d\d\d)-(\d\d\d\d)",r"\1\2-\3",substit)
	if c.search(substit):
		substit = re.sub(r"(\(\d\d\d\))\s(\d\d\d)-(\d\d\d\d)",r"\1\2-\3",substit)
	if d.search(substit):
		substit = re.sub(r"(\d\d\d)-(\d\d\d)-(\d\d\d\d)", r"(\1)\2-\3", substit)
	if e.search(substit):
		substit = re.sub(r"(\(\d\d\d\))(\d\d\d).(\d\d\d\d)", r"\1\2-\3", substit)	
	if f.search(substit):
		substit = re.sub(r"(\(\d\d\d\)).(\d\d\d).(\d\d\d\d)", r"\1\2-\3", substit)
	if g.search(substit):
		substit = re.sub(r"(\(\d\d\d\))\s(\d\d\d).(\d\d\d\d)", r"\1\2-\3", substit)
	if h.search(substit):
		substit = re.sub(r"(\d\d\d).(\d\d\d).(\d\d\d\d)", r"(\1)\2-\3", substit)
	print(substit)
	return(substit)


lines = readFile(inFile)
modLines = []
for i in lines:
    modLines.append(modify(i))
for i in modLines:
   writeFile(i)