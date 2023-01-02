# frozen_string_literal: true

class ShortLinkSerializer < ActiveModel::Serializer
  def attributes(*_agrs)
    return {short_url: object.short_url} unless decode?

    {original_url: object.original_url}
  end

  private

  def decode?
    @instance_options[:type].to_sym == :decode
  end
end
