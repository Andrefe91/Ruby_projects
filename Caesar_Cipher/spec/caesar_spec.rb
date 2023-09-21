require "rspec"
require "./caesar_cipher.rb"

describe "caesar_transformation" do
  it "Return same phrase with a shift factor of 0" do
    expect(caesar_transformation("hello", 0)).to eq("hello")
  end

  it "Return same phrase with a shift factor of 26" do
    expect(caesar_transformation("hello", 26)).to eq("hello")
  end

  it "Returns correct phrase with a shift factor of 5" do
    expect(caesar_transformation("hello", 5)).to eq("mjqqt")
  end

  it "Ignores punctuation characters" do
    expect(caesar_transformation("hello!!, how are you?", 5)).to eq("mjqqt!!, mtb fwj dtz?")
  end

  it "Respect the upper case" do
    expect(caesar_transformation("HellO!!", 5)).to eq("MjqqT!!")
  end

  it "Has no problems with spaces" do
    expect(caesar_transformation("H e l l o", 5)).to eq("M j q q t")
  end
end
