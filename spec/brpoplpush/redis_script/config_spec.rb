# frozen_string_literal: true

RSpec.describe Brpoplpush::RedisScript::Config do
  let(:config)       { described_class.new }

  let(:script_name)  { :test }
  let(:scripts_path) { SCRIPTS_PATH }

  it { is_expected.to respond_to(:logger).with(0).arguments }
  it { is_expected.to respond_to(:logger=).with(1).arguments }
  it { is_expected.to respond_to(:scripts_path).with(0).arguments }
  it { is_expected.to respond_to(:scripts_path=).with(1).arguments }

  describe "scripts_path=" do
    subject(:set_scripts_path) { config.scripts_path = new_path }

    context "when directory exists" do
      let(:new_path) { SCRIPTS_PATH }

      it { expect { set_scripts_path }.to change { config.scripts_path }.from(nil).to(new_path) }
    end

    context "when directory does not exist" do
      let(:new_path) { SCRIPTS_PATH.join("non-existing", "path") }

      it do
        expect { set_scripts_path }.to raise_error(ArgumentError)
      end
    end
  end
end
