#########################################################
# make_xml.py											#
# David Fry												#
# 8-7-14												#
#														#
# This script creates an array from a txt file and then #
# turn the array into a xml file.  						#
#########################################################

def splitTextFile(file_name):
	'''	takes in a txt file and splits the lines into strings
	   	then add them into an array and then returns the array
		splitTextFile(char, string, emptyArray) -> array
	'''
	text_array = []
	#opens the file
	with open(file_name) as file:
		# goes through each line and splits the text and adds to the array
		for line in file:
			text_array.append(line.split())
		return text_array

def createDictionaryArray(textArray):
	''' creates an array with dictionaries from the text array
		createDictionaryArray(array) -> array<dictionaies>
	'''


	finalDictArray = []
	# loops through the textArray and adds the key and value to each dictionary
	for item in textArray:
		tempDict = {}

		if len(item) == 2:
			tempDict["id"] = item[0]
			tempDict["firstName"] = item[1]
			tempDict["lastName"] = "none"
			finalDictArray.append(tempDict)
		
		elif len(item) == 3:
			tempDict["id"] = item[0]
			tempDict["firstName"] = item[1]
			tempDict["lastName"] = item[2]
			finalDictArray.append(tempDict)

		elif len(item) == 4:
			tempDict["id"] = item[0]
			tempDict["firstName"] = item[1]
			tempDict["lastName"] = item[2] + " " + item[3]
			finalDictArray.append(tempDict)

	return finalDictArray



def createFullXMLTag(tag_name,value):
	'''
		Creates a full xml tag.
		createFullXMLTag(string, string) -> string
	'''
	return "<{tagName}>{value}</{tagName}>".format(tagName=tag_name, value=value)

def createOpenCloseXMLTag(tag_name, tag_start):
	'''	Creats eiter a start xml tag or a close tag based on the variable tag_start
		createOpenCloseXMLTag(string, bool) -> string
	'''
	if tag_start:
		return "<{tag_name}>".format(tag_name=tag_name)
	else:
		return "</{tag_name}>".format(tag_name=tag_name)


def createXML(new_file_name, array_of_dicts):
	''' creates the full XML doc, you need to add the file name for the new file
		and add the tags you want to use.
		createXML(string, array<dictionaies>) -> None
	'''
	my_file = open(new_file_name, 'w')
	for key in array_of_dicts:
		#open root
		my_file.write(createOpenCloseXMLTag("dict", True))
		my_file.write(createFullXMLTag("key", "id"))
		my_file.write(createFullXMLTag("string", key["id"]))
		my_file.write(createFullXMLTag("key", "firstName"))
		my_file.write(createFullXMLTag("string", key["firstName"]))
		my_file.write(createFullXMLTag("key", "lastName"))
		my_file.write(createFullXMLTag("string", key["lastName"]))
		#end root
		my_file.write("</dict>")

	my_file.close()

my_array = []
text_array = splitTextFile("name_with_ids.txt")
class_roster = createDictionaryArray(text_array)
createXML("TestXMLExport.txt", class_roster)
