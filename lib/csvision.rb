require "csvision/version"
require "csvision/csv_helper"

module CSVision
  def self.included(base)
    base.extend CSVHelper
  end
end

ActiveRecord::Base.send( :include, CSVision ) if defined? ActiveRecord::Base
Hash.send( :include, CSVision::CSVHelper::InstanceMethods )
