require 'spec_helper'



describe 'puppet_chocolatey_foreman' do
  let(:facts) do {
    'os' => {
      'name'   => 'Undef',
      'family' => 'Undef'
    }
  }
  end

  context 'with default values for all parameters' do
    it { should contain_class('puppet_chocolatey_foreman') }
    it { is_expected.to compile.with_all_deps }
  end

  context 'with default values set for windows' do

      #let(:facts) do {
      #  'os' => {
      #    'name'   => 'windows',
      #    'family' => 'windows'
      #  },
  end
end
