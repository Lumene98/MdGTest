require 'json'
require 'rexml/document'

xml = File.open('./hr_test_1.xml')
#trasformo il file in document per facilitare l'accesso
doc = REXML::Document.new(xml)

invii = []

#costruisco la mia array di invii hash
doc.root.elements["data"].elements.each do |invio|
    hashInvio = {}
    hashInvio["id"] = invio.attributes["id"]
    hashInvio.update(Hash[invio.elements.map{|element| [element.name, element.text]}]) 
    hashInvio["Address"] = Hash[invio.elements["Address"].elements.map{|element| [element.name, element.text]}]
    invii.push(hashInvio)
end

hash = {}

#trasformo il document in hash
hash["InvioPostale"] = Hash["unique_id", doc.root.attributes["unique_id"]]
hash["InvioPostale"].update(Hash["topic", doc.root.elements["Topic"].text])
hash["InvioPostale"].update(Hash["office", doc.root.attributes["office"]])
#aggiungo l'array di invii
hash["InvioPostale"].update(Hash["data", invii])

#trasformo l'hash in json e lo indento
json = JSON.pretty_generate(JSON.parse(hash.to_json))

#scrivo il json nel file di output
File.open("./output.json","w") do |f|
    f.write(json)
end



