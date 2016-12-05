class Users::RegistrationsController < Devise::RegistrationsController
    
    def create # override the def create in the devise/registrationsConstroller file
        super do |resource|
            if params[:plan]
                resource.plan_id = params[:plan]
                if resource.plan_id == 2
                    resource.save_with_payement
                else
                    resource.save
                end
            end
        end
    end
end