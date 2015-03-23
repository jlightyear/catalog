class Color < ActiveRecord::Base

  has_many :products
  has_many :preproducts, through: :products

  validates_presence_of :color
  validates_uniqueness_of :color
  validates_length_of :color, :maximum => 50
  validates_presence_of :ref_col
  validates_uniqueness_of :ref_col
  validates_length_of :ref_col, :maximum => 5

  scope :sorted, lambda { order("colors.ref_col ASC") }

end
