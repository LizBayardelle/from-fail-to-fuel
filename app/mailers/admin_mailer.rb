class AdminMailer < ApplicationMailer

  def new_contact(contact)
    @contact = contact
    mail(
      to: "liz@thefailureproject.org",
      subject: 'New Message on The Failure Project'
    )
  end

end
