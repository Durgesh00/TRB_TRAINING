class UsersController < ApplicationController
  #skip_before_action :authorized, only: [:new, :create, :index]
  skip_before_action :verify_authenticity_token

  def index
    run User::Operation::Index.() do |result|
          return render cell(User::Cell::Index, @model)

    end
    redirect_to welcome_index_path
    #return render cell(User::Cell::Index)
  end

  def new 
    run User::Operation::New do | result |
      #return render cell(User::Cell::New, nil, form: @form)
    end
  end

  def create
    run User::Operation::Create do | result |
      byebug
      token = JsonWebToken.encode(user_id: result[:model].id)
      render json: { token: token,username: result[:model].name }, status: :ok
    end
    #return render cell(User::Cell::New, nil, form: @form)
  end

   def login
    if User::Operation::Validate.(email: params[:email], password: params[:password])
      byebug
      @user = User::Operation::Show.(email: params[:email])[:user]
      if @user && @user.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        #session[:token] = token  
        render json: { token: token,username: result[:model].name }, status: :ok
      else   
        error = "Invalid Credentials"   
        render json: { error: error }
      end
    else   
        error = "One or more fields blank" 
        render json: { error: error }    
      end

  end
end