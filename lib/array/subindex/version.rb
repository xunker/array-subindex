# frozen_string_literal: true

class Array
  module Subindex
    # Version is semantic, built from last version of Ruby that this has
    # been tested with, and then a gem-specific patch level.
    GEM_PATCH_LEVEL = '0'
    MRI_VERSION = '3.2.2'
    VERSION = [MRI_VERSION, GEM_PATCH_LEVEL].join('.').freeze
  end
end
