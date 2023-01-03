# frozen_string_literal: true

RSpec.shared_context "with authenticate user" do
  let(:user){ create(:user) }
  let(:token){ user.access_tokens.last.token }
  let(:headers){ {Authorization: ["Bearer", token].join(" ")} }
end
