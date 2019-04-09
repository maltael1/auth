require 'uri'
require 'net/http'

class RegisterServiceJob < ApplicationJob
  queue_as :default

  def perform
    uri = URI.parse(Rails.application.config.discovery_host) #Вытаскиваем discovery_host из конфигов
    params = {
      token: Rails.application.config.service_token,
      host: Rails.application.config.host,
      gate_host: Rails.application.config.gate_host
    } # Формируем параметры
    response = Net::HTTP.post_form(uri, params) # Отправляем запрос
    Rails.application.config.token = JSON.parse(response.body)['token'] # Сохраняем свой токен в конфиги
    
  end
end
