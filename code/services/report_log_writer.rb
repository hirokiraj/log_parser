require 'csv'

class ReportLogWriter
  OUTPUT_HEADERS = ['ID', 'Created at', 'Status', 'Code', 'ErrorDescription'].freeze

  def initialize(removal_results, output_filename)
    @removal_results = removal_results
    @output_filename = output_filename
  end

  def call
    CSV.open(
      @output_filename, 'wb',
      quote_char: '', col_sep: '  ', headers: OUTPUT_HEADERS, write_headers: true
    ) do |csv|
      @removal_results.each { |removal_result| csv << removal_result.values }
    end
  end
end
