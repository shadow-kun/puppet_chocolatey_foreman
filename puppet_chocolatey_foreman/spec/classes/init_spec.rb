require 'spec_helper'
describe 'puppet_chocolatey_foreman' do
  context 'with default values for all parameters' do
    it { should contain_class('puppet_chocolatey_foreman') }
  end
end
