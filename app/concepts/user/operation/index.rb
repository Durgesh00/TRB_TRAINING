module User::Operation
  class Index < Trailblazer::Operation
    step :valid_user?
    step :get_users

    def get_users(ctx,**)
      ctx[:model] = User.all
    end

    def valid_user?(ctx, **)
      false
    end
    # step :is_valid_user?
    # step :load_data
    # fail :set_errors
    # pass :build_user

    # def is_valid_user?(ctx, **)
    #   false
    # end

    # def load_data(ctx, **)
    #   ctx[:users] = User.all
    # end

    # def set_errors(ctx, **)
    #   ctx[:errors] = 'Invalid Users'
    # end

    # def build_user(ctx, **)
    #   ctx[:build_result] = "Builded successfully"
    # end
  end
end