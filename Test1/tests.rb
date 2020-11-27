require "test/unit/assertions"
require 'rexml/document'
include Test::Unit::Assertions
require_relative './lib/convert'

#Test Constructor
doc = REXML::Document.new("<NotInvioPostale>test</NotInvioPostale>")

assert_raise("Error in the constructor: Cannot find `InvioPostale`"){ Convert.new(doc) }

puts "Invalid doc test passed: thrown an error in the constructor \n\n"

doc = REXML::Document.new("<InvioPostale>test</InvioPostale>")
initializedHash = Convert.new(doc).getHash();
assert_equal({"InvioPostale"=>{}}, initializedHash)

puts "Initialize test passed: check if the hash is initialized \n\n"

#Test getInvii
assert_raise("Error at getInvii: Cannot find data element"){ Convert.new(doc).getInvii() }

puts "Invii test 1 passed: thrown an error because of no data element \n"

doc = REXML::Document.new("
<InvioPostale>
    <data>
        <invio id=\"1\">
            <FirstName>Giovanni</FirstName>
            <LastName>Panasiti</LastName>
            <ContactNo>1234567890</ContactNo>
            <AttachmentName>cartolina_auguri_123.pdf</AttachmentName>
            <Address>
                <City>ROMA RM</City>
                <Street>Via di monte del gallo 51</Street>
                <Zip>00165</Zip>
                <Country>Italy</Country>
            </Address>
        </invio>
    </data>
</InvioPostale>")

invii = Convert.new(doc).getInvii();

assert_equal(Array.new(1).length(), invii.length())

puts "Invii test 2 passed: return an array of data with 1 invio \n"

assert_equal("1", invii[0]["id"])

puts "Invii test 3 passed: found id \n"

doc = REXML::Document.new("
<InvioPostale>
    <data>
        <invio id=\"1\">
            <FirstName>Giovanni</FirstName>
            <LastName>Panasiti</LastName>
            <ContactNo>1234567890</ContactNo>
            <AttachmentName>cartolina_auguri_123.pdf</AttachmentName>
        </invio>
    </data>
</InvioPostale>")

assert_raise("Error at getInvii: Address not found in invio with id 1"){ Convert.new(doc).getInvii() }

puts "Invii test 44 passed: invalid Address \n\n"

#Test addAttributeToHash
doc = REXML::Document.new("<InvioPostale></InvioPostale>")

assert_raise("Error at addAttributeToHash: Cannot find the 'test' attribute"){ Convert.new(doc).addAttributeToHash("test") }

puts "Add Attribute to Hash test 1 passed: attribute not found \n"

doc = REXML::Document.new("<InvioPostale test=\"test\"></InvioPostale>")

convert = Convert.new(doc)
convert.addAttributeToHash("test")

assert_equal({"InvioPostale"=>{"test"=> "test"}}, convert.getHash())

puts "Add Attribute to Hash test 2 passed: returned hash with test attribute  \n\n"

#Test addElementToHash
doc = REXML::Document.new("<InvioPostale></InvioPostale>")

assert_raise("Error at addElementToHash: Cannot find the 'test' element"){ Convert.new(doc).addAttributeToHash("test") }

puts "Add Element to Hash test 1 passed: element not found \n"

doc = REXML::Document.new("<InvioPostale><test>test</test></InvioPostale>")

convert = Convert.new(doc)
convert.addElementToHash("test")

assert_equal({"InvioPostale"=>{"test"=> "test"}}, convert.getHash())

puts "Add Element to Hash test 2 passed: returned hash with test element  \n\n"

#Test addDataToHash
doc = REXML::Document.new("
<InvioPostale>
    <data>
        <invio id=\"1\">
            <FirstName>Giovanni</FirstName>
            <LastName>Panasiti</LastName>
            <ContactNo>1234567890</ContactNo>
            <AttachmentName>cartolina_auguri_123.pdf</AttachmentName>
            <Address>
                <City>ROMA RM</City>
                <Street>Via di monte del gallo 51</Street>
                <Zip>00165</Zip>
                <Country>Italy</Country>
            </Address>
        </invio>
    </data>
</InvioPostale>")

convert = Convert.new(doc)
convert.addDataToHash()

assert_equal(1, convert.getHash().length())

puts "Add Data to Hash passed: the data array lenght matches  \n\n"