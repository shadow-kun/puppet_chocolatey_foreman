require 'spec_helper'


describe 'puppet_chocolatey_foreman' do
  # Standard tests that aren't affected by an OS
  let(:facts) do {
    'os' => {
      'name'   => 'Undef',
      'family' => 'Undef'
    }
  }
  end

  #let(:facts) do {
  #  facts
  #}
  warn('Beginning Basic Tests')
  it { should contain_class('puppet_chocolatey_foreman') }
  it { is_expected.to compile.with_all_deps }

  context 'Testing windows functions' do
    warn ('Beginning Windows Tests')

    let(:facts) do {
      'os' => {
        'name'   => 'windows',
        'family' => 'windows'
      },

        #'choco_install_location'  => 'C:\ProgramData\chocolatey',
        #'use_7zip'                => false,
        #'download_url'            => 'http://chocopackages.internal.com/chocolatey/chocolatey.0.9.9.8.nupkg',
        #'log_output'              => true,

    }
    end
  end
end
