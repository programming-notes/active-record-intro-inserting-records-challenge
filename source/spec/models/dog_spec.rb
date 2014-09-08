require_relative '../../config/environment'

describe "Dog" do
  describe "inheritance" do
    it "inherits from ActiveRecord::Base" do
      expect(Dog < ActiveRecord::Base).to be true
    end
  end
end
