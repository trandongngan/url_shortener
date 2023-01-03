# frozen_string_literal: true

require "rails_helper"

RSpec.describe Base62 do
  let(:tests) do
    {
      "aoykuA" => 10_000_000_000,
      "boykuA" => 10_000_000_001,
      "h4zkuA" => 10_000_000_999,
      "tKumZs" => 50_000_000_991,
      "n9oZ9l1" => 99_999_999_999
    }
  end

  describe "encode" do
    it "encodes the number" do
      tests.each do |k, v|
        expect(described_class.encode(v)).to eq(k)
      end
    end
  end

  describe "decode" do
    it "decodes the string" do
      tests.each do |k, v|
        expect(described_class.decode(k)).to eq(v)
      end
    end
  end
end
