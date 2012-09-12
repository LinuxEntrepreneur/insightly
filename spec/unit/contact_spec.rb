require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Insightly::Contact do
  before(:each) do
    Insightly::Configuration.api_key = INSIGHTLY_API_KEY

    @contact = Insightly::Contact.build({"CONTACT_ID" => 1234567,
                                     "SALUTATION" => nil,
                                     "FIRST_NAME" => "John",
                                     "LAST_NAME" => "Doe",
                                     "BACKGROUND" => nil,
                                     "CONTACT_FIELD_1" => nil,
                                     "CONTACT_FIELD_2" => nil,
                                     "CONTACT_FIELD_3" => nil,
                                     "CONTACT_FIELD_4" => nil,
                                     "CONTACT_FIELD_5" => nil,
                                     "CONTACT_FIELD_6" => nil,
                                     "CONTACT_FIELD_7" => nil,
                                     "CONTACT_FIELD_8" => nil,
                                     "CONTACT_FIELD_9" => nil,
                                     "CONTACT_FIELD_10" => nil,
                                     "DATE_CREATED_UTC" => "2012-03-13 05:19:10",
                                     "DATE_UPDATED_UTC" => "2012-03-13 05:19:10",
                                     " ADDRESSES" => [],
                                     "CONTACTINFOS" => [{
                                                            "CONTACT_INFO_ID" => 7894561,
                                                            "TYPE" => "EMAIL",
                                                            "SUBTYPE" => nil,
                                                            "LABEL" => "Home",
                                                            "DETAIL" => "johndoe@insight.ly"
                                                        }],
                                     "VISIBLE_TO" => "EVERYONE",
                                     "VISIBLE_TEAM_ID" => nil
                                    })
    #  @task_links = Insightly::TaskLink.all
    #  d = 1
  end
  it "should have a url base" do
    Insightly::Contact.new.url_base.should == "Contacts"
  end
  it "should know the contact id" do

  end
  it " should know the contact id " do
    @contact.contact_id.should == 1234567
  end
  it "should know the remote id " do
    @contact.remote_id.should == @contact.contact_id
  end

# it "should be able to create an contact" do
#   @contact = Insightly::Contact.new
#
#   @contact.visible_to = "EVERYONE"
#   @contact.first_name = "000 Dummy"
#   @contact.last_name = "Test Contact"
#   @contact.background =  "This contact was created for test purposes and can be deleted."
#
#   @contact.save
#
#   @new_contact = Insightly::Contact.new(@contact.remote_id)
#   @new_contact.last_name.should == @contact.last_name
#end
  context "addresses" do
    before(:each) do
      @contact = Insightly::Contact.new(20315449)
      @contact.addresses = []
      @contact.save

      @address = Insightly::Address.new
      @address.address_type = "Work"
      @address.street = "123 Main St"
      @address.city = "Indianpolis"
      @address.state = "IN"
      @address.postcode = "46112"
      @address.country = "US"
    end
    it "should allow you to update an address" do
      @contact.addresses.should == []
      @contact.add_address(@address)

      @contact.save
      @address = @contact.addresses.first
      @address.state = "TX"
      @contact.addresses = [@address]
      @contact.addresses.length.should == 1

      @contact.save

      @contact.reload

      @contact.addresses.length.should == 1
      @contact.addresses.first.state.should == "TX"
    end
    it "should allow you to add an address" do


      @contact.addresses.should == []
      @contact.add_address(@address)

      @contact.save
      @contact.reload
      @contact.addresses.length.should == 1
      @contact.addresses.first.street.should == "123 Main St"
    end
    it "should allow you to remove an address" do

      @contact.addresses.should == []
      @contact.add_address(@address)

      @contact.save
      @contact.addresses = []
      @contact.save
      @contact.reload
      @contact.addresses.length.should == 0

    end
    it "should allow you to clear all addresses" do
      @contact.addresses.should == []
      @contact.add_address(@address)

      @contact.save
      @contact.addresses = []
      @contact.save
      @contact.reload
      @contact.addresses.length.should == 0
    end

    it "should not add an address if the same address is already on the organization" do

      @contact.addresses.should == []
      @contact.add_address(@address)

      @contact.add_address(@address)
      @contact.addresses.length.should == 1
    end
  end
end