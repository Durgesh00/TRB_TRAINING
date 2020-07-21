module User::Operation
  class Create < Trailblazer::Operation
    #step Subprocess(User::Operation::New)
    step Model(User, :new)

    step Contract::Build(constant: User::Contract::Form)
    step Contract::Validate(key: :user)
    step Contract::Persist()
  end
end























# module User::Operation
#     class Create < Trailblazer::Operation
#       step :create_user
#       step :address_present?, Output(:failure) => Id(:sent_mail)
#       step :create_address
#       step :send_mail
#       step :set_response

#       def create_user(ctx, user_params:, **)
#         ctx[:user]= User.create(user_params)
#       end

#       def address_present(ctx, **)
#         ctx[:address_present].present?
#       end

#       def create_address(ctx, address_params:, **)
#         ctx[:user].create_address(address_params)
#       end
      
#       def sent_mail(ctx, **)
#         p "inside sent mail"
#       end
     
#     end
#   end