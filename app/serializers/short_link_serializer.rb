# frozen_string_literal: true

class ShortLinkSerializer < ActiveModel::Serializer
  def attributes(*agrs)
    return {short_url: object.short_url} unless is_decode?

    {original_url: object.original_url}
  end

  def is_decode?
    @instance_options[:is_decode]
  end
end
