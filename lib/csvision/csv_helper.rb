module CSVision
  module CSVHelper
    def add_csvision(options={})
      return if included_modules.include? InstanceMethods
      cattr_accessor :csv_except, :csv_only, :csv_delimeter, :csv_separator, :csv_headers, :body

      self.csv_only       = options[:only]
      self.csv_except     = options[:except]
      self.csv_delimeter  = options[:delimeter] || '"'
      self.csv_separator  = options[:separator] || ','
      self.csv_headers    = options[:csv_headers]
      self.body           = options[:body]

      include InstanceMethods
      extend  ClassMethods
    end

    module ClassMethods
      def to_csv(options={ :headers => true, :batch_size => 100 })
        options[:delimeter]   ||= csv_delimeter
        options[:separator]   ||= csv_separator
        options[:batch_size]  ||= 100

        unless self.count < 1
          headers, csv_array  = nil, []
          self.find_each :batch_size => options[:batch_size] do |object|
            unless self.body
              headers ||= object.csvize( object.attributes.only( *csv_only ).keys,     options ) if csv_only    && !csv_only.empty?
              headers ||= object.csvize( object.attributes.except( *csv_except ).keys, options ) if csv_except  && !csv_except.empty?

              csv_array << object.to_csv( options.merge(:headers => false) )
            else
              values    = self.body.call object
              headers ||= object.csvize( self.csv_headers, options ) if self.csv_headers
              csv_array << object.csvize( values, options )
            end
          end

          content = csv_array.join("\n")
          return headers + "\n" + content if options[:headers]
          content
        end
      end
    end

    module InstanceMethods
      def to_csv(options={})
        options[:delimeter] ||= '"'
        options[:separator] ||= ','
        options[:headers]     = true if options[:headers].nil?
        headers, values, rows = [], [], nil
        @csv = ''

        if self.respond_to?( :attributes ) && self.attributes.kind_of?( Hash )
          rows    = self.attributes.only( *csv_only ).to_a      if csv_only   && !csv_only.empty?
          rows  ||= self.attributes.except( *csv_except ).to_a  if csv_except && !csv_except.empty?
          rows  ||= self.attributes.to_a
        end

        ( rows || self.to_a ).each do |(key, value)|
          headers << key if options[:headers]
          values  << value
        end

        @csv  = csvize(headers, options) + "\n" if options[:headers]
        @csv += csvize(values, options)
      end

      def csvize(values, options={})
        delimeter = options[:delimeter] || csv_delimeter
        separator = options[:separator] || csv_separator

        values.map do |value|
          delimeter + value.to_s + delimeter
        end.join(separator)
      end

      def cached_csv
        @csv
      end
    end
  end
end
