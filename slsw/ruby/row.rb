module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.csv'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

    def each(&block)
      @csv_contents.each do |row|
        block.call(CsvRow.new(@headers, row))
      end
    end
  end
end

class CsvRow
  def initialize(headers, row)
    @headers = headers
    @row = row
  end

  def method_missing(name, *args)
    index = @headers.index(name.to_s)
    if index
      @row[index]
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    @headers.include?(name.to_s) || super
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

csv = RubyCsv.new
csv.each { |row| puts row.dva }