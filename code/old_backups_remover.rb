require './code/services/backups_extractor'
require './code/services/backup_remover'
require './code/services/report_log_writer'

class OldBackupsRemover
  def initialize(input_filename: 'inputs/logfile.txt', output_filename: 'outputs/output_a.txt')
    @input_filename = input_filename
    @output_filename = output_filename
  end

  def call
    database_backups = BackupsExtractor.new(@input_filename).call
    removal_results = BackupRemover.new(database_backups).call
    ReportLogWriter.new(removal_results, @output_filename).call
  end
end
