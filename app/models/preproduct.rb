class Preproduct < ActiveRecord::Base

  belongs_to :section
  has_many :products
  has_many :colors, through: :products
  
  validates_presence_of :titulo
  validates_length_of :titulo, :maximum => 75
  validates_presence_of :ref_pre
  validates_uniqueness_of :ref_pre
  validates_length_of :ref_pre, :maximum => 10
  validates_presence_of :section_id

  scope :sorted, lambda { order("preproducts.ref_pre ASC") }

end
