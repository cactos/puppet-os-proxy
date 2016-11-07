require 'spec_helper'
describe 'cactos_os_proxy' do
  context 'with default values for all parameters' do
    it { should contain_class('cactos_os_proxy') }
  end
end
