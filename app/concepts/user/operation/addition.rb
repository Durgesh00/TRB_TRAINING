class User::Operation::Addition < Trailblazer::Operation
  step :process

  def process(ctx, input1:, input2:, **)
    ctx[:output] = input1 + input2
  end  
end
