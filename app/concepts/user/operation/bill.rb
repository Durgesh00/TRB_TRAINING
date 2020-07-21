class User::Operation::Bill < Trailblazer::Operation
  step :process
  
  def process(ctx, menu:, **)
    total_bill = 0
    item_list = menu[:order_items]

    item_list.each do | hash |
      price = hash[:price]
      total_bill += price
    end
    #ctx[:output] = yo
    if menu[:self_pickup] == true
      ctx[:output] = total_bill 
    else
      ctx[:output] = total_bill + (total_bill*0.05)
    end
  end  

end