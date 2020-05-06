require 'csv'
require 'time'

require './code/structs/database_backup'

class BackupsExtractor
  THIRTY_DAYS_IN_SECONDS = 30 * 24 * 60 * 60

  def initialize(input_filename)
    @input_filename = input_filename
  end

  def call
    filter_recent(extract_from_logfile)
  end

  private

  def extract_from_logfile
    CSV.foreach(@input_filename, col_sep: '  ', headers: true).map do |db_backup|
      DatabaseBackup.new(*db_backup.fields)
    end
  end

  def filter_recent(database_backups)
    database_backups.reject { |backup| Time.parse(backup.created_at) < (Time.now - THIRTY_DAYS_IN_SECONDS) }
  end
end
