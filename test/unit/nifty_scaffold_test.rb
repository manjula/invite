require 'test_helper'

class NiftyScaffoldTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert NiftyScaffold.new.valid?
  end
end
