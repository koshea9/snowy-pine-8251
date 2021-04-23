require 'rails_helper'

RSpec.describe Airline, type: :model do
  it {should have_many :flights}
  it {should have_many(:manifests).through(:flights)}
  it {should have_many(:passengers).through(:manifests)}
end
