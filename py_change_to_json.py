#########################################################
# py_change_to_json.py_change_to_json 					#
# David Fry												#
# 8-5-14												#
#														#
# This script creates an array from a txt file and then #
# turn the array into a json file.  					#
#########################################################

import json



def splitTextFile(file_name):
	# takes in a txt file and splits the lines into strings
	# then add them into an array and then returns the array
	# splitTextFile(char, string, emptyArray) -> array
	text_array = []
	#opens the file
	with open(file_name) as file:
		# goes through each line and splits the text and adds to the array
		for line in file:
			text_array.append(line.split())
		return text_array

def creatDictionaryArray(textArray):
	# creates an array with dictionaries from the text array

	finalDictArray = []
	# loops through the textArray and adds the key and value to each dictionary
	for item in textArray:
		tempDict = {}

		if len(item) == 1:
			tempDict["firstName"] = item[0]
			tempDict["lastName"] = "none"
			finalDictArray.append(tempDict)
		
		elif len(item) == 2:
			tempDict["firstName"] = item[0]
			tempDict["lastName"] = item[1]
			finalDictArray.append(tempDict)

		elif len(item) == 3:
			tempDict["firstName"] = item[0]
			tempDict["lastName"] = item[1] + " " + item[2]
			finalDictArray.append(tempDict)

	return finalDictArray

def createJSONfile(final_dict_array, file_name):
	# opens the file to be written to and then adds the contents of 
	# final_dict_array. To make the final json file
	with open (file_name, 'w') as outfile:
		json.dump(final_dict_array, outfile)
	print "Finished creating your file!"

my_array = []
#text_array = splitTextFile("classRoster.txt")
my_file = open("name_with_ids.txt", 'w')
for key in text_array:
	#open root
	my_file.write("id:{id} : name:{name}".format(id=key["id"], name=key["name"]))
my_file.close()
#class_roster = creatDictionaryArray(text_array)
#createJSONfile(class_roster, "roster2.json")