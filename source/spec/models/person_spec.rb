require_relative '../../config/environment'

describe "Person" do
  describe "inheritance" do
    it "inherits from ActiveRecord::Base" do
      expect(Person < ActiveRecord::Base).to be true
    end
  end
end
