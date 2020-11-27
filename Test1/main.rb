require 'json'
require 'rexml/document'
require_relative './lib/convert'


xml = File.open('./hr_test_1.xml')
#Transforming my xml into document for easier access
doc = REXML::Document.new(xml)
convert = Convert.new(doc) 

hash = {}

#Add attributes and elements to the hash
convert.addAttributeToHash("unique_id")
convert.addElementToHash("Topic")
convert.addAttributeToHash("office")
#Add the data(invii) to the hash
convert.addDataToHash()

#Cast the hash in json and indent it
json = JSON.pretty_generate(JSON.parse(convert.getHash().to_json))

#Write in the output file
File.open("./output.json","w") do |f|
    f.write(json)
end



