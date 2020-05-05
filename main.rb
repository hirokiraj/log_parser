require 'csv'
require 'time'
require 'net/http'

THIRTY_DAYS_IN_SECONDS = 30 *24 * 60 * 60

DatabaseBackup = Struct.new(:id, :created_at, :status, :size, :database)
RemovalResult = Struct.new(:id, :created_at, :status, :code, :error_description)

database_backups = []
removal_results = []

CSV.foreach('logfile.txt', col_sep: '  ', headers: true) do |db_backup|
  database_backups << DatabaseBackup.new(*db_backup.fields)
end

database_backups.reject! { |backup| Time.parse(backup.created_at) > (Time.now - THIRTY_DAYS_IN_SECONDS) }

database_backups.each do |database_backup|
  uri = URI("http://localhost:4567/remove-backup?backup_id=#{database_backup.id}")
  response = Net::HTTP.start(uri.host, uri.port).request(Net::HTTP::Put.new(uri))

  removal_results << if response.code == '200'
    RemovalResult.new(database_backup.id, database_backup.created_at, 'Removed', response.code)
  else
    RemovalResult.new(database_backup.id, database_backup.created_at, 'Error', response.code, response.body)
  end
end

output_header = ['ID', 'Created at', 'Status', 'Code', 'ErrorDescription']
CSV.open('output.txt', 'wb', quote_char: '', col_sep: '  ', headers: output_header, write_headers: true) do |csv|
  removal_results.each { |removal_result| csv << removal_result.values }
end
