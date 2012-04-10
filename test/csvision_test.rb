require 'test_helper'

class CSVisionTest < ActiveSupport::TestCase
  def setup
    assert @hash_demo = ActiveSupport::OrderedHash.new
    assert @hash_demo[:a] = 'a'
    assert @hash_demo[:b] = 'b'
    assert @hash_demo[:c] = 'c'
  end

  test "check plugin type" do
    assert_kind_of Module, CSVision
  end

  test "hashes are successfully turned into csv" do
    assert_match /[abc]\'\,/, @hash_demo.to_csv(:delimeter => "'")
  end

  test "can call get a csv cached after turned into csv once" do
    assert_nil @hash_demo.cached_csv
    assert_match /[abc]\'/, @hash_demo.to_csv(:delimeter => "'")

    assert @hash_demo[:d] = 'd'
    assert_not_equal @hash_demo.cached_csv, @hash_demo.to_csv
  end

  test "can create csv without headers" do
    assert_match /[abc]\"\,/, @hash_demo.to_csv(:headers => false)
  end

  test "can set different separator and spacer" do
    assert_match /[abc]\|/, @hash_demo.to_csv(:delimeter => '', :separator => '|')
  end
end
