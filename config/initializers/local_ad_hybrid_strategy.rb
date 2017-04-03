require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LocalAdHybridStrategy < Authenticatable
      def valid?
        true
      end

      def authenticate!
        if params[:user]
          user = User.find_by_username(params[:user][:username])
          # Caso o usuário esteja no banco com a coluna ad_user como false,
          # ele permitirá autenticação híbrida, tentando autenticar primeiro com o AD
          # e depois com a senha do banco local em caso de falha no AD
          if user && !user.ad_user? && user.valid_password?(params[:user][:password])
            # Check if the user exists, is able to log in and the password is valid.
            success!(user)
          else
            return fail(:invalid)
          end
        else
          fail
        end
      end
    end
  end
end

Warden::Strategies.add(:local_ad_hybrid_strategy, Devise::Strategies::LocalAdHybridStrategy)
