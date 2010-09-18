require File.dirname(__FILE__) + '/../spec_helper'

describe Search::Convenience do

  before(:each) do
    @convenience = {
      :allocations => [[nil, nil, nil, nil, [1,2,3,4,5,6,7,8]],
                       [nil, nil, nil, nil, [9,10,11,12,13,14,15,16]],
                       [nil, nil, nil, nil, [17,18,19,20,21,22,23]]],
      :offset => 123,
      :total => 12345,
      :duration => 0.12345
    }.extend Search::Convenience
  end

  # describe 'replace_ids_with' do
  #   before(:each) do
  #     @results = Search::Results.new [
  #         [nil, nil, nil, [1,2,3,4,5,6,7,8]],
  #         [nil, nil, nil, [9,10,11,12,13,14,15,16]],
  #         [nil, nil, nil, [17,18,19,20,21,22,23]]
  #       ], [], nil, 123, true, true, 0.123, 1234
  #   end
  #   it 'should replace the ids' do
  #     new_ids = (11..31).to_a # +10
  #     @results.replace_ids_with new_ids
  #     @results.ids.should == (11..31).to_a
  #   end
  # end

  describe 'clear_ids' do
    it 'should clear all ids' do
      @convenience.clear_ids

      @convenience.ids.should == []
    end
  end

  describe 'ids' do
    it 'should return the top default ids' do
      @convenience.ids.should == (1..21).to_a
    end
    it 'should return the top limit entries' do
      @convenience.ids(7).should == (1..8).to_a
    end
  end

  describe 'allocations_size' do
    it 'should just add up the allocations of both types' do
      @convenience.allocations_size.should == 3
    end
  end

  # describe 'render?' do
  #   context 'no ids' do
  #     before(:each) do
  #       @convenience.stub! :empty? => true
  #     end
  #     it 'should not render' do
  #       @convenience.render?.should == false
  #     end
  #   end
  #   context 'less results than the treshold' do
  #     before(:each) do
  #       @convenience.stub! :empty? => false
  #       @convenience.stub! :total => 7
  #     end
  #     it 'should render' do
  #       @convenience.render?.should == true
  #     end
  #   end
  #   context 'too many, but just in one allocation' do
  #     before(:each) do
  #       @convenience.stub! :empty? => false
  #       @convenience.stub! :total => 100
  #       @convenience.stub! :allocations_size => 1
  #     end
  #     it 'should render' do
  #       @convenience.render?.should == true
  #     end
  #   end
  #   context 'too many' do
  #     before(:each) do
  #       @convenience.stub! :empty? => false
  #       @convenience.stub! :total => 100
  #       @convenience.stub! :allocations_size => 2
  #     end
  #     it 'should not render' do
  #       @convenience.render?.should == false
  #     end
  #   end
  # end

  describe 'empty?' do
    context 'allocations empty' do
      before(:each) do
        @convenience.stub! :allocations => stub(:allocations, :empty? => true)
      end
      it 'should be true' do
        @convenience.empty?.should == true
      end
    end
    context 'allocations not empty' do
      before(:each) do
        @convenience.stub! :allocations => stub(:allocations, :empty? => false)
      end
      it 'should be false' do
        @convenience.empty?.should == false
      end
    end
  end

end