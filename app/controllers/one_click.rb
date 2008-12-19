class OneClick < Application
  before :check_login, :exclude => [:authenticate, :login]
  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    @proposals = Decision.all(:open => true)
    render
  end
  
  def login
    render 
  end
  
  def logout
    session('cookie')[:current_user_id] = nil
    redirect url('login')
  end
  
  def authenticate
    user = Member.first(:email => params[:email])
    if user && params[:password] == 'oneclick'
      session('cookie')[:current_user_id] = user.id
      redirect url('')
    else
      redirect url('login')
    end
  end
  
  def constitution
    render
  end
end