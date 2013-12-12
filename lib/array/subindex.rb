require "array/subindex/version"

class Array
  def [](index)
    if (subindex = index.to_f - index.to_i) > 0
      f = index.to_f.floor
      c = index.to_f.ceil
      f_value = self.fetch(f)
      c_value = self.fetch(c)

      f_value = array_subset(f_value, subindex, :to_end) if
        array_like?(f_value)
      c_value = array_subset(c_value, subindex, :from_beginning) if
        array_like?(c_value)

      if (numeric?(f_value) && numeric?(c_value))
        subindex_as_number(subindex, f_value, c_value)
      else
        subindex_as_string(subindex, f_value, c_value)
      end
    else
      self.fetch(index)
    end
  end

private

  def subindex_as_number(subindex, f_value, c_value)
    f_fractional = f_value.to_f * (1.0 - subindex)
    c_fractional = c_value.to_f * subindex
    f_fractional + c_fractional
  end

  def subindex_as_string(subindex, f_value, c_value)
    f_value = f_value.to_s
    c_value = c_value.to_s
    f_index = (f_value.length * subindex).to_i
    c_index = (c_value.length * subindex).to_i
    [
      f_value.slice(f_index, f_value.length),
      c_value.slice(0, c_index)
    ].join
  end

  def numeric?(test)
    (test.class != String) && (!!(test.to_s =~ /[\d\.\/]+/))
  end

  def array_like?(test)
    test.respond_to?(:to_a)
  end

  def array_subset(value, subindex, direction)
    value = value.to_a
    subarray = if value.size <= 1
      value
    else
      index = (value.length.to_f * subindex).to_i
      subarray = case direction.to_sym
      when :to_end
        value.slice(index, value.size-1)
      when :from_beginning
        value.slice(0, index)
      else
        raise "unknown direction :#{direction}"
      end
      subarray
    end

    if subarray.all?{ |a| numeric?(a) }
      subarray.inject(:+)
    else
      subarray.join
    end
  end

end
