class UserAccount < ActiveRecord::Base

  attr_accessible :uid, :provider, :refresh_token, :email
  
  belongs_to :user, :dependent => :destroy
  has_many :printers

  def create_unique_printer(cloud_printer)
    @printer = self.printers.find_or_initialize_by_printer_id( cloud_printer.id, :name => cloud_printer.name )
    @printer.user_id = self.user_id
    @printer.save
  end

end
