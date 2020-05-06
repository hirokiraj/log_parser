# rubocop:disable Metrics/MethodLength
def write_input_file
  time_now = formatted_time_now
  time_ago = formatted_time_ago
  File.open('spec/tmp/test_input.txt', 'wb') do |file|
    file.puts('ID  Created at  Status  Size  Database')
    file.puts("a810  #{time_now}  Completed 2019-07-10 00:18:53 +0000  482.43MB  DATABASE")
    file.puts("a179  #{time_now}  Completed 2019-07-09 00:23:42 +0000  480.99MB  DATABASE")
    file.puts("a278  #{time_now}  Completed 2019-07-08 00:16:04 +0000  479.59MB  DATABASE")
    file.puts("a827  #{time_ago}  Completed 2019-07-07 00:18:43 +0000  481.75MB  DATABASE")
    file.puts("a222  #{time_ago}  Completed 2020-04-29 00:22:22 +0000  222.22MB  DATABASE2")
    file.puts("a333  #{time_ago}  Completed 2020-04-28 00:33:33 +0000  333.33MB  DATABASE3")
    file.puts("a444  #{time_ago}  Completed 2020-04-27 00:44:44 +0000  444.44MB  DATABASE4")
  end
end
# rubocop:enable Metrics/MethodLength

def formatted_time_now
  DateTime.now.new_offset(0).strftime('%Y-%m-%d %H:%M:%S %z')
end

def formatted_time_ago
  (DateTime.now.new_offset(0) - 50).strftime('%Y-%m-%d %H:%M:%S %z')
end

def remove_input_file
  File.delete('spec/tmp/test_input.txt')
end

def remove_output_file
  File.delete('spec/tmp/test_output.txt')
end

def read_output_file
  CSV.read('spec/tmp/test_output.txt', col_sep: '  ', headers: true)
end
