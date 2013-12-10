require "array/subindex/version"

class Array
  def [](index)
    if (subindex = index.to_f - index.to_i) > 0
      f = index.to_f.floor
      c = index.to_f.ceil
      f_value = self.fetch(f)
      c_value = self.fetch(c)
      if (numeric?(f_value) && numeric?(c_value))
        subindex_as_number(subindex, f_value, c_value)
      else
        subindex_as_string(subindex, f_value.to_s, c_value.to_s)
      end
    else
      self.fetch(index)
    end
  end

private

  def subindex_as_number(subindex, f_value, c_value)
    f_fractional = f_value.to_f * subindex
    c_fractional = c_value.to_f * (1.0 - subindex)
    # raise "#{subindex} #{f_value} #{c_value} #{f_fractional} #{c_fractional}"
    return  f_fractional + c_fractional
  end

  def subindex_as_string(subindex, f_value, c_value)
    f_value = f_value.to_s
    c_value = c_value.to_s
    f_index = (f_value.length * subindex).to_i
    c_index = (c_value.length * (1.0 - subindex)).to_i
    # raise "#{subindex} '#{f_value}' '#{c_value}' #{f_index} #{c_index} #{f_value.slice(f_index, f_value.length-1)} #{c_value.slice(0, c_index)}"
    [
      f_value.slice(f_index, f_value.length-1),
      c_value.slice(0, c_index)
    ].join
  end

  def numeric?(test)
    !!(test.to_s =~ /[\d\.\/]+/)
  end

end
