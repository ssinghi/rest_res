class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.valid_email_regex
    /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def self.valid_phone_regex
    /\A[-()\.\s\dx]+\z/
  end
end
