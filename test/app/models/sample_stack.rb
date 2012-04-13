class SampleStack
  include CSVision
  attr_accessor :attributes

  add_csvision :csv_headers => %w/price name/, :body => lambda { |s| [ s[:name], s[:price] ] }

  def initialize( attributes={}, inventory = [] )
    @attributes = attributes
    @@inventory = inventory
  end

  def self.count
    @@inventory.size
  end

  def self.find_each( opts={} )
    @@inventory.each do |item|
      yield item
    end
  end
end
