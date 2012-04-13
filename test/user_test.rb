require 'test_helper'

class UserTest < ActiveSupport::TestCase
  EXPECTED_CSV = <<-CSV
"street_cred","nickname","incognito"
"495","user0","0resu"
"998","user3","3resu"
"1501","user6","6resu"
"2004","user9","9resu"
"2546","user12","21resu"
CSV

  EXPECTED_CSV_WITH_SCOPE = <<-CSV
"street_cred","nickname","incognito"
"495","user0","0resu"
"998","user3","3resu"
"1501","user6","6resu"
CSV

  EXPECTED_CSV_WITHOUT_HEADERS = <<-CSV
"495","user0","0resu"
"998","user3","3resu"
"1501","user6","6resu"
"2004","user9","9resu"
"2546","user12","21resu"
CSV

  def setup
    5.times { |i| assert User.create( :nickname => "user#{ i * 3}", :points => i * 5 ) }
  end

  test "can call to_csv directly from model" do
    assert User.respond_to?(:to_csv)
    assert csv = User.to_csv
    assert_equal EXPECTED_CSV.chomp, csv
  end

  test "can chain scopes into the csv call" do
    assert csv = User.flunky.to_csv
    assert EXPECTED_CSV_WITH_SCOPE.chomp, csv
  end

  test "can pass options to t_csv" do
    assert csv = User.to_csv( :headers => false )
    assert_equal EXPECTED_CSV_WITHOUT_HEADERS.chomp, csv
  end
end
