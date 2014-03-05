class ApplauseController < ApplicationController
  skip_before_filter :verify_authenticity_token


  # POST /applause/
  def create
    paper = Paper.find(params[:paper_id])
    applause = Applause.new({:paper => paper, 
      :source_ip => request.remote_ip, 
      :user_agent => request.env['HTTP_USER_AGENT'],
      :referer => request.env['HTTP_ORIGIN']})

    mail = ApplauseMailer.applause_mail(applause).deliver
    
    if applause.save && mail.delivered
      flash[:notice] = "Applause was successfully sent. The author has been cheered up and disturbed."
    else
      flash[:error] = "The applause could not be sent"
    end
    redirect_to paper

  end



end
