class UsersController < ApplicationController

  def show
    user = User.find( params[:id])
    @name = user.name
    @profile = user.profile
    @position = user.position
    @occupation = user.occupation
    @prototypes = user.prototypes
   

  end
  
end
