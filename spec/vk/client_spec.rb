require 'spec_helper'

describe Vk::Client do
  describe 'class' do
    subject { described_class }

    it { should respond_to(:auth_key) }
    it { should respond_to(:authenticated?) }
    it { Vk::Client.auth_key(VK_VIEWER_ID).should == VK_AUTH_KEY }
    it { Vk::Client.authenticated?(VK_VIEWER_ID, VK_AUTH_KEY).should be_true }
  end

  describe 'instance' do
    subject(:client) { described_class.new }

    it { should respond_to(:request) }
  end
end
