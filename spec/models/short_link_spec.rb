require "rails_helper"

RSpec.describe ShortLink do
  let(:user){ create(:user) }

  describe "when record invalid" do
    subject(:short_link){ described_class.new(user: user, original_url: original_url) }

    describe "without original url" do
      let(:original_url){ nil }

      it "returns short url" do
        expect(short_link).not_to be_valid
        expect(short_link.errors.full_messages.first).to eq("Original url can't be blank")
      end
    end

    describe "when original url format wrong" do
      let(:original_url){ "abc" }

      it "returns short url" do
        expect(short_link).not_to be_valid
        expect(short_link.errors.full_messages.first).to eq("Original url is invalid")
      end
    end
  end

  describe "when create successfully" do
    subject(:short_link){ described_class.create(user: user, original_url: original_url) }

    let(:original_url){ "https://abc.com/test_short/testne" }

    it "returns short url" do
      expect{ short_link }.to change(described_class, :count).from(0).to(1)
      expect(described_class.first.original_url).to eq(original_url)
    end
  end
end
