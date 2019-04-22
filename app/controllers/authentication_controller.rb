class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request
   
    def authenticate
        command = AuthenticateUser.call(params[:login], params[:password])
    
        if command.success?
            render json: { auth_token: command.result }
        else
            render json: { error: command.errors }, status: :unauthorized
        end
    end

    def get_user
        render json: {auth_token: JsonWebToken.decode(params[:auth_token]) }
    end
end