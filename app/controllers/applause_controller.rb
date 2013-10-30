class PapersController < ApplicationController
  skip_before_filter :verify_authenticity_token


  # POST /applause/
  def create
    paper = Paper.find(params[:paper_id])
    ApplauseMailer.applause_email(paper).deliver

    respond_to do |format|
      format.html { redirect_to paper, notice: 'Applause was successfully sent.' }      
      #if @paper.save
       ## format.html { redirect_to @paper, notice: 'Paper was successfully created.' }
       # format.json { render action: 'show', status: :created, location: @paper }
      #else
      #  format.html { render action: 'new' }
      #  format.json { render json: @paper.errors, status: :unprocessable_entity }
      #end
    end
  end



end
