class Printer < ActiveRecord::Base
  attr_accessible :name, :printer_id

  belongs_to :user
  belongs_to :user_account

  def print_document file
    #TODO make this accept a PDF, and print to selected printer (instance method)
    # use ./public/example-address-label.pdf if you want
  end

end
