require 'erb'
require 'pony'
 
class Mailer
  
  def initialize(options)
   Pony.options = options
  end

  def awesome_email(details)
    @to           = details[:to]
    @from         = details[:from]
    subject       = details[:subject]
    template_path = details[:template_path]
    
    # Not doing this will mean your template wont use your instance level variables
    context = binding
    body = ERB.new(File.read(template_path)).result(context)
 
    Pony.mail(:to => @to, :from => @from, :subject => subject, :html_body => body)
  end
end

# Needed my Mail to send our email
options = { :via_options           => {
                :address              => 'smtp.gmail.com',
                :port                 => 587,
                :domain               => 'gmail.com',
                :user_name            => 'makersbnb2019@gmail.com',
                :password             => 'testtickles2019',
                :authentication       => 'plain'
            },
            :via                  => :smtp }

mailer = Mailer.new(options)

# This is a Hash that will be passed to the awesome_email method
details = { to: 'yasmine.morawej@gmail.com', # LOGGED IN USER
            from: 'makersbnb2019@gmail.com',
            subject: 'Booking confirmed',
            template_path: 'views/awesome_email.erb' }


mailer.awesome_email(details)