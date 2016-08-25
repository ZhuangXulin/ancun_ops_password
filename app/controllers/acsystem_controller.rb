class AcsystemController < ApplicationController
	before_filter :authenticate_user!

	def index
    	@acsystem = Acsystem.get_system_password_list(nil,params[:search_key],params[:page])
	end

	def new
		@acsystem = Acsystem.new
    @action = :create
	end

	def create
		@acsystem = Acsystem.create(acsystem_params)
		respond_to do |format|
        if @acsystem.save
          format.html { redirect_to @acsystem, notice: 'System password was successfully created.' }
        else
          format.html { render :new ,notice: 'System password was unsuccessfully created.'}
        end
      end
	end

	def edit
		@acsystem = Acsystem.show(params[:id])
    @acsystem["system_password"] = Base64.decode64(@acsystem.system_password).sub!(/fuck this is the password salt/, '').sub!(@acsystem.system_password_salt,'')
    @action = :update
  end

  def update
  	@acsystem = Acsystem.show(params[:id])
    password_salt = @acsystem.system_password_salt
  	respond_to do |format|
    		if @acsystem.update_attributes(:system_name => acsystem_params["system_name"],
                                      :system_desc => acsystem_params["system_desc"],
                                      :system_ip => acsystem_params["system_ip"],
                                      :system_password => Base64.encode64(acsystem_params["system_password"]+'fuck this is the password salt'+password_salt)
                                      )
	    		
          format.html { redirect_to acsystem_url, notice: 'System password was successfully updated.' }
    		else
      		format.html { render action: "edit" ,notice: 'System password was unsuccessfully updated.'}
    		end
    	end
  end

  def destroy
  	@acsystem = Acsystem.find(params[:id])
  	@acsystem.destroy
  	respond_to do |format|
    		format.html { redirect_to acsystem_index_url }
  	end
	end

	def show
    	@acsystem = Acsystem.show(params[:id])
      @acsystem["system_password"] = Base64.decode64(@acsystem.system_password).sub!(/fuck this is the password salt/, '').sub!(@acsystem.system_password_salt,'')
  end

	private
  	def acsystem_params
    	params.require(:acsystem).permit(:system_name, :system_desc, :system_ip, :system_password)
  	end
end
