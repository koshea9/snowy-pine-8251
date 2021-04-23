require 'rails_helper'

RSpec.describe Manifest, type: :model do
  describe "relationships" do
    it {should belong_to :flight}
    it {should belong_to :passenger}
  end
end
