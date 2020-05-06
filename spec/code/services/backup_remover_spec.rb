require 'support/structs_builder'

RSpec.describe BackupRemover do
  subject(:backup_remover_call) { described_class.new(database_backups).call }

  let(:database_backups) { build_database_backups }

  describe 'when removal succeeds' do
    let(:success_result_attributes) { { id: 'testid', status: 'Removed', code: '200', error_description: nil } }

    before do
      stub_request(:put, /localhost*/).to_return(status: 200)
    end

    it { expect(backup_remover_call).to be_a(Array) }
    it { expect(backup_remover_call.size).to eq(3) }
    it { expect(backup_remover_call.map(&:class).uniq.size).to eq(1) }
    it { expect(backup_remover_call.first).to be_a(RemovalResult) }
    it { expect(backup_remover_call.first).to have_attributes(success_result_attributes) }
    it { expect(Time.parse(backup_remover_call.first.created_at)).to be_within(1).of(Time.now) }
  end

  describe 'when removal fails' do
    let(:error_result_attributes) { { id: 'testid', status: 'Error', code: '404', error_description: 'not found' } }

    before do
      stub_request(:put, /localhost*/).to_return(status: 404, body: 'not found')
    end

    it { expect(backup_remover_call.first).to have_attributes(error_result_attributes) }
  end
end
