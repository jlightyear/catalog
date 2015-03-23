class Admin < ActiveRecord::Base
	
  has_secure_password

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :username,              :length => {:within => 8..25},
                                    :uniqueness => true
  validates :password,              :presence => true, :on => :create,
                                    :length => {:within => 5..12},
                                    :confirmation => true
  validates :password_confirmation, :presence => true, :on => :create
  validates :email,                 :presence => true,
                                    :length => {:maximum => 100},
                                    :format => EMAIL_REGEX,
                                    :uniqueness => true,
                                    :confirmation => true

  scope :sorted, lambda { order("id ASC") }
  scope :active, lambda { where(:active => true) }

end
