class GateController < ApplicationController

    def confirm # Сюда будет стучаться сервис провайдер # post '/gate', to: 'gate#confirm'
        case params[:method]
        when 'confirm'
            #Если сервис-провайдер отправил некорректный токен - то свой мы не отдадим
            if (params[:hashed_token] != Digest::MD5.hexdigest(Rails.application.config.token)) 
                render json: {errors: { invalid_service: 'U dont now my token :)' }}
            else
                render json: {token: Rails.application.config.token} # При запросе на подтверждение отправляем свой токен
            end
        when 'update'
            Rails.application.config.auth_server_host = params[:services]['auth'] # Сохраняем хосты других сервисов в конфиги
            Rails.application.config.admin_host = params[:services]['admin']
            Rails.application.config.rest_api_host = params[:services]['rest_api']
            render status: 200
        else
            render status: 400 # Возвращаем 400 потому что не поняли запрос
        end
    end
end
