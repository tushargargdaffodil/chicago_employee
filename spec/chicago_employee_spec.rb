require "spec_helper"

RSpec.describe ChicagoEmployee do
  it "has a version number" do
    expect(ChicagoEmployee::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
