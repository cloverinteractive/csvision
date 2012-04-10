require "csvision/version"
require "csvision/csv_helper"

module CSVision
  ::ActiveRecord::Base.send( :extend, CSVHelper ) if defined? ::ActiveRecord::Base
  ::Hash.send( :include, CSVHelper::InstanceMethods )
end
