class Convert 
    def initialize(doc)
        @hash = {} 
        @doc = doc
        if @doc.root.name() == "InvioPostale" then
            @hash["InvioPostale"] = {}
        else
            raise "Error in the constructor: Cannot find `InvioPostale`"
        end 
    end

    def getHash
        return @hash
    end

    def getDoc
        return @doc
    end
    
    def getInvii()
        if @doc.root.elements["data"] then
            invii = []
            @doc.root.elements["data"].elements.each do |invio|
                hashInvio = {}
                hashInvio["id"] = invio.attributes["id"]
                hashInvio.update(Hash[invio.elements.map{|element| [element.name, element.text]}]) 
                if hashInvio["Address"] then
                    hashInvio["Address"] = Hash[invio.elements["Address"].elements.map{|element| [element.name, element.text]}]
                else
                    raise "Error at getInvii: Address not found in invio with id #{hashInvio["id"]}"
                end
                invii.push(hashInvio)
            end
            return invii
        else
            raise "Error at getInvii: Cannot find data element"
        end
    end

    def addAttributeToHash(attribute)
        if  @doc.root.attributes[attribute] then
            @hash["InvioPostale"].update(Hash[attribute, @doc.root.attributes[attribute]])
        else
            raise "Error at addAttributeToHash: Cannot find the '#{attribute}' attribute"
        end
    end

    def addElementToHash(element)
        if  @doc.root.elements[element] then
            @hash["InvioPostale"].update(Hash[element.downcase, @doc.root.elements[element].text])
        else
            raise "Error at addElementToHash: Cannot find the '#{element}' element"
        end
    end

    def addDataToHash()
        invii = self.getInvii()
        @hash["InvioPostale"].update(Hash["data", invii])
    end

end
