require 'support/structs_builder'
require 'support/files_helper'

RSpec.describe ReportLogWriter do
  subject(:output_content) { read_output_file }

  before(:all) do
    described_class.new(build_removal_results, 'spec/tmp/test_output.txt').call
  end

  after(:all) { remove_output_file }

  let(:proper_headers) { ['ID', 'Created at', 'Status', 'Code', 'ErrorDescription'] }

  it { expect(output_content.to_a.size).to eq(5) }
  it { expect(output_content.headers).to eq(proper_headers) }
  it { expect(output_content[0].fields).to include('goodid', 'Removed', '200', nil) }
  it { expect(Time.parse(output_content[0][1])).to be_within(1).of(Time.now) }
  it { expect(output_content[3].fields).to include('errorid', 'Error', '500', 'internal error') }
  it { expect(Time.parse(output_content[3][1])).to be_within(1).of(Time.now) }
end
