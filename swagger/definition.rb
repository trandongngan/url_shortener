# frozen_string_literal: true

module Swagger
  module Definition
    def self.call
      # The purpose of the method is to parse swagger definition yaml
      # `JsonRefs` parses only one layer, it fails to parse multi layer parse.
      hash = YAML.load_file(Rails.root.join("swagger/v1/main.yml"))
      loop do
        break unless hash.to_s.include?("$ref")

        hash = JsonRefs.call(hash)
      end
      hash
    end
  end
end
