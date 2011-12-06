require 'spec_helper'

 describe Group do
  before (:each) do
    @follower = Factory(:user)
    @leader = Factory(:user, :email => Factory.next(:email))
    @attr = {:leader_id => @leader.id}

  end

  it "should create a new group given valid attributes" do
    @follower.groups.create!(@attr)
  end

  it "should build and save a new group given valid attributes" do
    @group = @follower.groups.build(:leader_id =>@leader.id)
    @group.save!
  end

  describe "validations" do
    it "should require a follower_id" do
      Group.new(@attr).should_not be_valid
    end

    it "should require a leader_id" do
      @follower.groups.build.should_not be_valid
    end

  end

  describe "follow methods" do
    before(:each) do
      @group = @follower.groups.create!(@attr)
    end

    it "should have a follower attribute" do
      @group.should respond_to(:follower)
    end

    it "should have the right follower" do
      @group.follower.should == @follower
    end

    it "should have a leader attribute" do
      @group.should respond_to(:leader)
    end

    it "should have the right leader" do
      @group.leader.should == @leader
    end

    it "should follow another user" do
      @follower.follow!(@leader)
      @follower.should be_following(@leader)
    end
  end
end
