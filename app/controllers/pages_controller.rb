class PagesController < ApplicationController

	layout "admin"
	
	def index
		@pages = Page.order("position ASC")
	end

	def show
		@page = Page.find(params[:id])
	end

	def new
		@page = Page.new
		@subjects = Subject.order("position ASC")
		@page_count = Page.count
	end

	def create
		@page = Page.new(page_params)
		if @page.save
			flash[:notice] = "Page created successfully."
			redirect_to :action => 'index'
		else
			@subjects = Subject.order("position ASC")
			@page_count = Page.count
			render 'new'
		end
	end

	def edit
		@page = Page.find(params[:id])
		@subjects = Subject.order("position ASC")
		@page_count = Page.count
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(page_params)
			flash[:notice] = "Page updated successfully."
			redirect_to :action => 'show'
		else
			@subjects = Subject.order("position ASC")
			@page_count = Page.count
			render 'edit'
		end
	end

	def delete
		@page = Page.find(params[:id])
	end

	def destroy
		page = Page.find(params[:id]).destroy
		flash[:notice] = "Page deleted successfully."
		redirect_to :action => 'index'
	end


	private
		def page_params
			params.require(:page).permit(:name, :position, :visible, :permalink, :subject_id)
		end
end
