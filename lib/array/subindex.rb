require "array/subindex/version"

class Array

  # Here is where the magic starts, where we redefine the core Array operator,
  # something you *should NEVER do*, but we are. I debated using `alias` to
  # preserve the old method and pass "regular" requests to that, but I decided
  # I wanted to recreate functionality to make sure I understand how the
  # method works in the original Array class.
  #
  # The existing Array operator accepts either a single index, a Range, or a
  # starting index and a length (similar to String#slice). These values are
  # expected to be Fixnums in this original version.
  #
  # We try to preserve all the previous functionality while also allowing
  # other Ruby numeric classes (Float, Rational and BigDecimal) to be used in
  # place of Fixnum. Passing a Fixnum is still valid, of course.
  #
  # All the numbers passed in are coerced to Floats. This includes Fixnums,
  # which means Fixnum `10` will be turned in to Float `10.0`. The standard
  # "subindex" logic is then applied so, in the case of a Fixnum, the code
  # _should_ return the same result as the core Array class, even though it's
  # being processed in a very different way.
  def [](index, length=nil)

    if index.respond_to?(:to_f) && !index.is_a?(Fixnum)
      fetch_subindex(index)
    elsif index.is_a?(Range)
      fetch_range(index)
    else
      fetch_integer_index(index, length)
    end
  end

private

  # Calculate the subindex with one value (not a range and without length).
  # Needs some refactoring since it's hard to tell at a glance what the code
  # is doing.
  def fetch_subindex(index)
    subindex = index.to_f - index.to_i

    f = index.to_f.floor
    c = index.to_f.ceil
    f_value = self.at(f)
    c_value = self.at(c)

    f_value = array_subset(f_value, subindex, :to_end) if
      array_like?(f_value)
    c_value = array_subset(c_value, subindex, :from_beginning) if
      array_like?(c_value)

    if (numeric?(f_value) && numeric?(c_value))
      subindex_as_number(subindex, f_value, c_value)
    else
      subindex_as_string(subindex, f_value, c_value)
    end
  end

  def fetch_slice(index, length)
    # If length is nil it will turn in to 0 which give the same result as
    # not passing a length at all.
    self.slice(index, length.to_i)
  end

  def fetch_integer_index(index,length)
    if length
      fetch_slice(index, length.to_i)
    else
      self.at(index)
    end
  end

  # Converts a range call to a slice call. I have a feeling the logic is wrong.
  def fetch_range(range)
    self.slice(range.first, range.to_a.length)
  end

  def subindex_as_number(subindex, f_value, c_value)
    f_fractional = f_value.to_f * (1.0 - subindex)
    c_fractional = c_value.to_f * subindex
    f_fractional + c_fractional
  end

  # This method could be optimized but the verbose form easier to understand.
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

  # Tests if value is "number-like" by checking if it's string form
  # is nothing but numbers containing a decimal.
  def numeric?(test)
    (test.class != String) && (!!(test.to_s =~ /[\d\.\/]+/))
  end

  # Tests is a value behaves like an array. Specifically, if I can coerce
  # it in to an array. Array#to_a returns itself, so they're valid.
  def array_like?(test)
    test.respond_to?(:to_a)
  end

  # If adjacent array indexes are "array-like", return the correct proportion
  # based in the index passed. This method is pretty tortuous and could use
  # some refactoring.
  def array_subset(value, subindex, direction)
    value = [*value] # .to_a gives deprication warings in 1.8.7  
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
