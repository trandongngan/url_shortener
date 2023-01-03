# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/api/v1/short_links" do
  include_context "with authenticate user"

  describe "POST /api/v1/encode" do
    subject(:request){ post api_v1_encode_path, params: params, headers: headers }

    context "when invalid params" do
      context "without the original url" do
        let(:params){ {} }

        it "response bad request" do
          request

          expect(response).to have_http_status(:bad_request)

          expect(JSON.parse(response.body)).to eq({"erorr_message" => "Bad request"})
        end
      end

      context "when url format wrong" do
        let(:params){ {url: "abc"} }

        it "response invalid record" do
          request

          expect(response).to have_http_status(:unprocessable_entity)

          expect(JSON.parse(response.body)).to eq({"erorr_message" => ["Original url is invalid"]})
        end
      end
    end

    context "when valid params" do
      let(:params){ {url: "https://codesubmit.io/library/react"} }

      it "response encode url" do
        request

        expect(response).to have_http_status(:ok)

        base_url = ENV["BASE_URL"] || "localhost:3000"
        short_url = Base62.encode(ShortLink::COUNTER + ShortLink.first.id)

        expect(JSON.parse(response.body)).to eq({"short_url" => [base_url, short_url].join("/")})
      end
    end
  end

  describe "POST /api/v1/decode" do
    subject(:request){ post api_v1_decode_path, params: params, headers: headers }

    context "without the short url" do
      let(:params){ {} }

      it "response bad request" do
        request

        expect(response).to have_http_status(:bad_request)

        expect(JSON.parse(response.body)).to eq({"erorr_message" => "Bad request"})
      end
    end

    context "when record not found" do
      let(:params){ {short_url: "abc"} }

      it "response not_found" do
        request

        expect(response).to have_http_status(:not_found)

        expect(JSON.parse(response.body)).to eq({"erorr_message" => "Resource not found"})
      end
    end

    context "when decode short url successfully" do
      let(:short_link){ create(:short_link, user: user) }
      let(:original_url){ short_link.original_url }
      let(:params){ {short_url: short_link.short_url} }

      it "response original url" do
        request

        expect(response).to have_http_status(:ok)

        expect(JSON.parse(response.body)).to eq({"original_url" => original_url})
      end
    end
  end
end
