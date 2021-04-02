require 'score_card'

describe ScoreCard do 
  let(:bowl) { ScoreCard.new }
  describe '#frame_count' do 
    it 'should be 1 by default' do 
      expect(bowl.frame_count).to eq 1
    end 
  end 
  
  describe '#next_frame' do 
    it 'should add up a new frame' do 
      bowl.next_frame

      expect(bowl.frame_count).to eq 2
    end 
    it 'should keep adding up' do 
      3.times { bowl.next_frame }

      expect(bowl.frame_count).to eq 4
    end 
    it 'should end the game at 10 frames' do
      10.times { bowl.next_frame }

      expect(bowl.frame_count).to eq 10
    end  
  end 

  describe '#roll_count' do 
    it 'should be 1 by default' do
      expect(bowl.roll_count).to eq 1 
    end 
  end 
  describe '#next_roll' do 
    it 'should add up a new roll' do 
      bowl.next_roll 

      expect(bowl.roll_count).to eq 2
    end 
    it 'should reset after two rolls and add up a new frame' do 
      2.times { bowl.next_roll }

      expect(bowl.roll_count).to eq 1
      expect(bowl.frame_count).to eq 2
    end
  end
end 