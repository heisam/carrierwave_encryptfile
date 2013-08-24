require 'spec_helper'

describe CarrierwaveEncryptfile do

  TEST_FILE_NAME = "spec/fixtures/secret.txt"

  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end

  it "should be well tested" do
    pending "Write some tests"
  end

end