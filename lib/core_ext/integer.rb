# frozen_string_literal: true

class Integer
  def to_base62_encode
    Base62.encode(self)
  end
end
