require 'net/http'

require './code/structs/removal_result'

class BackupRemover
  REMOVAL_URL = 'http://localhost:4567/remove-backup?backup_id='.freeze

  def initialize(database_backups)
    @database_backups = database_backups
  end

  def call
    @database_backups.map do |database_backup|
      response = request_removal(database_backup)
      construct_removal_result(database_backup, response)
    end
  end

  private

  def request_removal(database_backup)
    uri = URI("http://localhost:4567/remove-backup?backup_id=#{database_backup.id}")
    Net::HTTP.start(uri.host, uri.port).request(Net::HTTP::Put.new(uri))
  end

  def construct_removal_result(database_backup, response)
    if response.code == '200'
      RemovalResult.new(database_backup.id, database_backup.created_at, 'Removed', response.code)
    else
      RemovalResult.new(database_backup.id, database_backup.created_at, 'Error', response.code, response.body)
    end
  end
end
