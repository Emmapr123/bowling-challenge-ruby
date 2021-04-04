class ScoreCard

  attr_reader :frames

  def initialize
    @frames = []
    @score = 0
  end

  def play(user_input)
    final_frame ? tenth_round(user_input) : roll(user_input)
  end 

  def roll(user_input)
    if @frames.length == 0 || @frames.last.is_strike? || @frames.last.rolls.length == 2 
      frame = Frame.new
      @frames << frame
    else 
      frame = @frames.last
    end
    frame.roll(user_input)
    total
  end 

  def tenth_round(user_input)
    @frames.last.roll(user_input)
    @score == 270 ? @score -= 30 : @score
    tenth_round_score + @score 
  end

  def tenth_round_score
    @frames.last.rolls.sum
  end 

  def total
    if !final_frame
      @score = @frames.map.with_index { |frame, index|
        bonus = 0 
        if previous_two_frames_are_strikes(index)
            bonus += frame.rolls.first 
        end
        if previous_frame_is_strike(index) 
            bonus += frame.rolls.sum
        elsif previous_frame_is_spare(index)
            bonus += frame.rolls.first
        end
          bonus += frame.rolls.sum
      }.sum
    end
  end 
  
  private

  def previous_frame_is_strike(index)
    @frames[index - 1] && @frames[index - 1].is_strike?
  end

  def previous_two_frames_are_strikes(index)
    @frames[index - 2] && @frames[index - 2].is_strike? && previous_frame_is_strike(index)
  end

  def previous_frame_is_spare(index)
    @frames[index - 1] && @frames[index - 1].is_spare?
  end 

  def final_frame
    @frames.length > 9
  end 
end