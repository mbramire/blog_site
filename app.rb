require 'dotenv'
Dotenv.load

require "sinatra"
require "action_mailer"
require "sinatra/activerecord"
require "bcrypt"
require "carrierwave"
require "carrierwave/orm/activerecord"

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/ddl3r9urh0p0sb')

enable :sessions

require_relative 'config/initializers/carrierwave'
require_relative 'uploaders/image_uploader'
require_relative 'models/models'
require_relative 'helpers/helpers'
require_relative 'routes/routes'

configure do
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
  }
  ActionMailer::Base.view_paths = File.expand_path('views')
end

class Mailer < ActionMailer::Base
  def contact
    mail(
      to: "email@address.com",
      from: "email",
      subject: "subject") do |format|
        format.html
    end
  end
end