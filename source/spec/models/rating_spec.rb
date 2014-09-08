require_relative '../../config/environment'

describe "Rating" do
  describe "inheritance" do
    it "inherits from ActiveRecord::Base" do
      expect(Rating < ActiveRecord::Base).to be true
    end
  end
end
