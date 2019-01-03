# Homework 4 - Part 2 - Regular Expressions
#	William Ah Tou
#	3/12/17
#	Mustafa Al-Lail
import re

# REGULAR EXPRESSIONS

# Write patterns for regular expressions a-c here.
# You must use a single regular expression for each item.

a = re.compile(r"\$"
			   r"([1-9]\d*|0)"
			   r"(\.\d{2}|)$")

b = re.compile(r"^[025-9]*3"
			   r"[025-9]*1"
			   r"[025-9]*4"
			   r"[025-9]*$")

c = re.compile(r"\["
			   r"(\'[a-zA-Z]\'\, )*"
			   r"(\'[a-zA-Z]\'|)\]")

# TESTS

# Write additional tests for each item.
# Include both matching and non-matching tests.
# A portion of your grade will be based on the thoroughness of your tests.

print("----Part a tests that match:")
print(a.search("$3.56"))
# Write additional tests here.
print(a.search("$0"))
print(a.search("$0.77"))
print(a.search("$77"))
print(a.search("$777.77"))
print(a.search("$1234567.89"))
print(a.search("$98765432.10"))
print(a.search("$700.00"))

print("----Part a tests that do not match:")
print(a.search("3.56"))
# Write additional tests here.
print(a.search("$07.77"))
print(a.search("$77.7"))
print(a.search("$77.777"))
print(a.search("$seven"))




print("----Part b tests that match:")
print(b.search("098388719400"))
# Write additional tests here.
print(b.search("314"))
print(b.search("777314"))
print(b.search("377714"))
print(b.search("317774"))
print(b.search("314777"))


print("----Part b tests that do not match:")
print(b.search("098388749100"))
# Write additional tests here.
print(b.search("431"))
print(b.search("413"))
print(b.search("134"))
print(b.search("143"))
print(b.search("3314"))
print(b.search("3114"))
print(b.search("3144"))
print(b.search("3h14"))


print("----Part c tests that match:")
print(c.search("['H', 'e', 'l', 'l', 'o']"))
# Write additional tests here.
print(c.search("['o']"))
print(c.search("[]"))
print(c.search("['o', 'H']"))


print("----Part c tests that do not match:")
print(c.search("['H', 'e', 'l', '7', 'o']"))
# Write additional tests here.
print(c.search("['o' 'P']"))
print(c.search("['H', 'e', 'l', 'l', 'o'"))
print(c.search("'H', 'e', 'l', 'l', 'o']"))
print(c.search("['H', o]"))
print(c.search("[H, 'o']"))
print(c.search("['o',  'H']"))
print(c.search("['?']"))

