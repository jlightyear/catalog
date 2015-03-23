class Section < ActiveRecord::Base

  has_many :preproducts

  has_attached_file :image,
    :styles => {
    :thumb    => ['100x100',  :jpg, :quality => 70],
    :preview  => ['290x290',  :jpg, :quality => 70],
    :standard => ['400x400',  :jpg, :quality => 70]
  },
  :convert_options => {
    :thumb    => '-set colorspace sRGB -strip',
    :preview  => '-set colorspace sRGB -strip',
    :standard => '-set colorspace sRGB -strip'
  }

  validates_presence_of :titulo
  validates_length_of :titulo, :maximum => 50
  validates_presence_of :ref_sec
  validates_uniqueness_of :ref_sec
  validates_length_of :ref_sec, :maximum => 5

  scope :sorted, lambda { order("sections.id ASC") }

end
