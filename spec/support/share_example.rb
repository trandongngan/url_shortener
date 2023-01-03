# frozen_string_literal: true

RSpec.shared_examples "with response success" do
  it "conforms to request schema" do
    subject

    expect(response).to have_http_status(:ok)

    assert_response_schema_confirm
  end
end

RSpec.shared_examples "with response bad request" do
  it "conforms to request schema" do
    subject

    expect(response).to have_http_status(:bad_request)

    assert_response_schema_confirm
  end
end

RSpec.shared_examples "when resource not found" do
  it "conforms to request schema" do
    subject

    expect(response).to have_http_status(:not_found)

    assert_response_schema_confirm
  end
end
