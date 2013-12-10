require "array/subindex/version"

class Array
  def [](index)
    if (subindex = index.to_f - index.to_i) > 0
      f = index.to_f.floor
      c = index.to_f.ceil
      f_value = self.fetch(f)
      c_value = self.fetch(c)
      f_fractional = f_value * subindex
      c_fractional = c_value * (1.0 - subindex)
      # raise "#{subindex} #{f} #{c} #{f_value} #{c_value} #{f_fractional} #{c_fractional}"
      return  f_fractional + c_fractional
    else
      self.fetch(index)
    end
  end
end
