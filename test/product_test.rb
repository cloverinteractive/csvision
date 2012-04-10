require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    5.times { |i| assert Product.create!( :name => "name_#{i}", :permalink => "permalink_#{i}", :description => "description_#{i}") }
  end

  test "ActiveRecord::Base objects should respond to add_csvision" do
    assert Product.respond_to? :add_csvision
  end

  test "ActiveRecord::Base classes should respond to to_csv" do
    assert Product.respond_to? :to_csv
  end

  test "ActiveRecord object should respond to to_csv" do
    assert product = Product.new
    assert product.respond_to? :to_csv
  end

  test "ActiveRecord objects can set either csv_only or csv_except" do
    # since csv_except is set to %w/creted_at updated_at/ csv should not contain these
    assert product = Product.new
    assert headers = product.to_csv.split("\n").first
    assert ! headers.include?( 'created_at' )
    assert ! headers.include?( 'updated_at' )
  end

  test "Can create a csv from a collection of products" do
    assert products_csv = Product.to_csv
    assert products_csv
    assert_match /[a-z_]+\"\,/, products_csv
  end
end
