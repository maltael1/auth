class JsonWebToken
    class << self
        def encode(payload, exp = 24.hours.from_now)
            payload[:exp] = exp.to_i
            JWT.encode(payload, Rails.application.secrets.secret_key_base)
        end
   
        def decode(token)
            puts JWT.decode(token, Rails.application.secrets.secret_key_base).to_json
            body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
            HashWithIndifferentAccess.new body
        rescue
            nil
        end
    end
end