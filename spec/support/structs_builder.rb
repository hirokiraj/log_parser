def build_database_backup
  DatabaseBackup.new('testid', Time.now.to_s, 'Completed', '200MB', 'DATABASE')
end

def build_database_backups
  3.times.map { build_database_backup }
end

def build_success_removal_result
  RemovalResult.new('goodid', Time.now.to_s, 'Removed', '200')
end

def build_error_removal_result
  RemovalResult.new('errorid', Time.now.to_s, 'Error', '500', 'internal error')
end

def build_removal_results
  2.times.map { build_success_removal_result } + 2.times.map { build_error_removal_result }
end
