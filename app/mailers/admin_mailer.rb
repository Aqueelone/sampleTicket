class AdminMailer < ActionMailer::Base  
  
  default from: 'notifications@sampleTicket.com';

  def welcome_email(user)
    @user = user
    @url  = '/sign_in'
    @account = '/users/' << @user.id.to_s << '/edit' 
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail_deliv = mail(to: email_with_name, subject: 'Welcome to sampleTicket Service') do |format|
      format.html { render layout: 'admin_mailer/welcome_email.html' }
      format.text
    end 
    mail_deliv.deliver
  end
  
  def ticket_email(ticket)
    @user = ticket.user
    @id = ticket.id
    @url = '/ticket/' << @id.to_s  
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail_deliv = mail(to: email_with_name, subject: 'New ticket created') do |format|
      format.html { render layout: 'admin_mailer/ticket_email.html' }
      format.text
    end  
    mail_deliv.deliver
  end
  
  def ticket_update_email(ticket)
    @user = ticket.user
    @id = ticket.id
    @url = '/ticket/' << @id.to_s 
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail_deliv = mail(to: email_with_name, subject: 'Ticket updated') do |format|
      format.html { render layout: 'admin_mailer/ticket_update_email.html.erb' }
      format.text { render layout: 'admin_mailer/ticket_update_email.text.erb' }
    end  
    mail_deliv.deliver
  end
   
  def ticket_delete_email(ticket)
    @user = ticket.user 
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail_deliv = mail(to: email_with_name, subject: 'Ticket deleted') do |format|
      format.html { render layout: 'admin_mailer/ticket_delete_email.html' }
      format.text
    end  
    mail_deliv.deliver   
  end 
end
