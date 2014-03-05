class ApplauseMailer < ActionMailer::Base

  def applause_mail(applause)
    @applause = applause
    mail(
      :subject => 'Yeah, yeah, yeah! Go on with writing your damn great paper: ' + applause.paper.title,
      :to      => 'sebastian@woinar.de',
      :from    => 'sebastian@woinar.de'
    )
  end

end