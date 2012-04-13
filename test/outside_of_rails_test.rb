require 'test_helper'

class OutsideOfRails < ActiveSupport::TestCase
  EXPECTED_CSV = <<-CSV
"price","name"
"beer","9"
"milk","5"
"tuna","3"
CSV

  EXPECTED_CSV_WITHOUT_HEADERS = <<-CSV
"beer","9"
"milk","5"
"tuna","3"
CSV

  def setup
    assert @inventory = [
      { :name => 'beer', :price => 9 },
      { :name => 'milk', :price => 5 },
      { :name => 'tuna', :price => 3 } ]
  end

  test "can use csvsion on POROS" do
    assert sample_stack = SampleStack.new( :foo => 'foo', :bar => 'bar' )
    assert sample_stack.respond_to?( :to_csv )
    assert csv = sample_stack.to_csv( :headers => false )
    assert_match /foo/, csv
    assert_match /bar/, csv
  end

  test "can make use of class methods" do
    assert sample_stack = SampleStack.new({ :name => 'groceries'}, @inventory)
    assert SampleStack.respond_to?( :to_csv )
    assert csv = SampleStack.to_csv
    assert_equal EXPECTED_CSV.chomp, csv
  end

  test "can use option filters on POROS" do
    assert sample_stack = SampleStack.new({ :name => 'groceries'}, @inventory)
    assert csv = SampleStack.to_csv( :headers => false )
    assert_equal EXPECTED_CSV_WITHOUT_HEADERS.chomp, csv
  end
end
