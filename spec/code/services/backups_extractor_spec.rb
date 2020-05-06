require 'support/files_helper'

RSpec.describe BackupsExtractor do
  subject(:backups_extractor_call) { described_class.new('spec/tmp/test_input.txt').call }

  before(:all) { write_input_file }

  after(:all) { remove_input_file }

  let(:success_result_attributes_sample) { { id: 'a810', file_size: '482.43MB', database: 'DATABASE' } }
  let(:thirty_days_in_s) { 30 * 24 * 60 * 60 }

  it { expect(backups_extractor_call).to be_a(Array) }
  it { expect(backups_extractor_call.size).to eq(3) }
  it { expect(backups_extractor_call.map(&:class).uniq.size).to eq(1) }
  it { expect(backups_extractor_call.first).to be_a(DatabaseBackup) }
  it { expect(backups_extractor_call.first).to have_attributes(success_result_attributes_sample) }
  it { expect(Time.parse(backups_extractor_call.first.created_at)).to be_within(thirty_days_in_s).of(Time.now) }
end
