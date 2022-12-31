# frozen_string_literal: true

module Base62
  CHARS = (0..9).collect(&:to_s) + ("A".."Z").to_a + ("a".."z").to_a

  class << self
    def decode(str)
      out = 0

      str.chars.each_with_index do |char, index|
        out += CHARS.index(char) * (CHARS.size**index)
      end

      out
    end

    def encode(int)
      raise "Can not encode negative number" if int.negative?

      return "0" if int.zero?

      result = "".dup

      while int.positive?
        result << CHARS[int % CHARS.size]
        int /= CHARS.size
      end

      result
    end
  end
end
