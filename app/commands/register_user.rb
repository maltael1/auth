class RegisterUser
    prepend SimpleCommand
  
    def initialize(login, password, password_confirmation)
      @login = login.to_s
      @password = password.to_s
      @password_confirmation = password_confirmation.to_s
    end
  
    def call
        create_user
    end
  
    private
  
    attr_accessor :login, :password, :password_confirmation
  
    def create_user
        user = User.create(login: login, password: password, password_confirmation: password_confirmation)
        return user if user.valid?
        user.errors.messages.each do |key, value|
            errors.add key.to_sym, value
        end
        nil
    end
  end