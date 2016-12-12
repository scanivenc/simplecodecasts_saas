class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :only_current_user
    
    def new
        # form where a user can fill out their own profile
        @user = User.find( params[:user_id]) #determines who is logged in
        @profile = Profile.new #method available because of established model association btw users and profiles
    end
    
    def create
        @user = User.find( params[:user_id] )
        @profile = @user.build_profile(profile_params) #store the content from the form and binds it with the user_id
        if @profile.save
            flash[:sucess] = "Profile Updated!"
            redirect_to user_path( params[:user_id] )#path lead to the user show page
        else
            render action: :new
        end
    end
    
    def edit
        @user = User.find( params[:user_id] )
        @profile = @user.profile
    end 
    
    def update
        @user = User.find( params[:user_id] )
        @profile = @user.profile
        if @profile.update_attributes(profile_params)
            flash[:success] = "Profile Updated!"
            redirect_to user_path( params[:user_id] )
        else
            render action: :edit
        end
    end
    
    private #whitelist the params
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
        end
        
        def only_current_user
            @user = User.find( params[:user_id] )
            redirect_to(root_url) unless @user == current_user
        end
end