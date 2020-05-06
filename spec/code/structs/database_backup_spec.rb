RSpec.describe DatabaseBackup do
  let(:proper_attributes) { %i[id created_at status file_size database] }

  it { is_expected.to have_attributes(Hash[proper_attributes.map { |x| [x, nil] }]) }
end
