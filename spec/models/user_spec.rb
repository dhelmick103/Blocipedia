require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  it { should have_many(:wikis) }

# Username validations
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_length_of(:username).is_at_least(5) }

# Email validations
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should_not allow_value("invalidemail").for(:email) }

  #Password validations
  it { should validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(5) }

  describe "attributes" do
    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to premium?" do
      expect(user).to respond_to(:premium?)
    end

    it "responds to standard" do
      expect(user).to respond_to(:standard?)
    end
  end

  context "admin user" do
    before do
      user.admin!
    end

    it "returns false for #member?" do
      expect(user.standard?).to be_falsey
    end

    it "returns false for #premium?" do
      expect(user.premium?).to be_falsey
    end

    it "returns true for #admin?" do
      expect(user.admin?).to be_truthy
    end
  end

  context "standard user" do
    it "returns true for #standard?"
      expect(user.standard?).to be_truthy
    end

    it "returns false for #admin?" do
      expect(user.admin?).to be_falsey
    end

    it "returns flase for #premium?" do
      expect(user.premium?).to be_falsey
    end
  end

  context "premium user" do
    it "returns true for #premium?"
      expect(user.premium?).to be_truthy
    end

    it "returns false for #standard" do
      expect(user.premium?).to be_falsey
    end

    it "returns false for #admin" do
      expect(user.admin?).to be_falsey
    end
  end
end 
