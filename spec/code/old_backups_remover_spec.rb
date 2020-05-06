RSpec.describe OldBackupsRemover do
  subject(:old_backups_remover_call) { described_class.new(**remover_options).call }

  let(:backups_extractor_instance) { instance_spy(BackupsExtractor) }
  let(:backup_remover_instance) { instance_spy(BackupRemover) }
  let(:report_log_writer_instance) { instance_spy(ReportLogWriter) }
  let(:remover_options) { { input_filename: 'spec/tmp/test_input.txt', output_filename: 'spec/tmp/test_output.txt' } }

  before do
    allow(BackupsExtractor).to receive(:new).and_return(backups_extractor_instance)
    allow(BackupRemover).to receive(:new).and_return(backup_remover_instance)
    allow(ReportLogWriter).to receive(:new).and_return(report_log_writer_instance)
    old_backups_remover_call
  end

  it { expect(backups_extractor_instance).to have_received(:call) }
  it { expect(backup_remover_instance).to have_received(:call) }
  it { expect(report_log_writer_instance).to have_received(:call) }
end
