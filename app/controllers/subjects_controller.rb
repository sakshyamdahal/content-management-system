class SubjectsController < ApplicationController

  layout false

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end


  # new displays the form
  def new
    @subject = Subject.new
  end

  def create
    # instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # save the object
    if @subject.save
      # if save succeeds, redirect to index action
      redirect_to :action => "index"
    else
      # if save fails, redisplay the form so user can fix problems
      render 'new'
    end
  end

  def edit

  end

  def delete
  end

  private
    def subject_params
      # same as using params[:subject] , except that it raises 
      # an error if :subject is not present
      # allows listed attributes to be massed assigned
      params.require(:subject).permit(:name, :position, :visible)
    end
end
