class ProfilesController < ApplicationController
    def new
        # form where a user can fill out their own profile
        @user = User.find( params[:user_id]) #determines who is logged in
        @profile = @user.build_profile #method available because of established model association btw users and profiles
    end
end