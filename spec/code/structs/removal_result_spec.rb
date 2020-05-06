RSpec.describe RemovalResult do
  let(:proper_attributes) { %i[id created_at status code error_description] }

  it { is_expected.to have_attributes(Hash[proper_attributes.map { |x| [x, nil] }]) }
end
