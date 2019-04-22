class RegistrationController < ApplicationController
    skip_before_action :authenticate_request

    def register 
        command = RegisterUser.call(params[:login], params[:password], params[:password_confirmation])
        command = AuthenticateUser.call(params[:login], params[:password]) if command.success?

        if command.success?
            render json: {auth_token: command.result}
        else
            render json: {error: command.errors}, status: :unauthorized
        end
    end
end