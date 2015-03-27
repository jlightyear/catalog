class Product < ActiveRecord::Base

	belongs_to :color
	belongs_to :preproduct
  belongs_to :product

  before_save :comprobar_referencia
  before_save :default_titulo, :unless => :titulo?
  before_save :default_descripcion, :unless => :descripcion?
  before_save :default_precio, :unless => :precio?
  before_save :default_referencia
  
  has_attached_file :image,
    :styles => {
    :thumb    => ['100x100',  :jpg, :quality => 70],
    :preview  => ['250x250',  :jpg, :quality => 70],
    :standard => ['400x400',  :jpg, :quality => 70],
    :large    => ['600>',     :jpg, :quality => 60]
  },
  :convert_options => {
    :thumb    => '-set colorspace sRGB -strip',
    :preview  => '-set colorspace sRGB -strip',
    :standard => '-set colorspace sRGB -strip',
    :large    => '-set colorspace sRGB -strip -sharpen 0x0.5'
  }

	scope :sorted, lambda { order("products.ref_pro ASC") }
  scope :next, ->(product) { where("ref_pro > ?", product.ref_pro).sorted }
  scope :previous, ->(product) { where("ref_pro < ?", product.ref_pro).sorted }

  private

    def default_titulo
      if self.color.ref_col == "NC"
        self.titulo = "#{self.preproduct.titulo}"
      else
        self.titulo = "#{self.preproduct.titulo} #{self.color.color}"
      end
    end

    def default_descripcion
      self.descripcion = "#{self.preproduct.descripcion}"
    end

    def default_precio
      self.precio = "#{self.preproduct.precio}"
    end

    def comprobar_referencia
      # if producto = Product.exists?(ref_pro: "#{self.preproduct.section.ref_sec}#{self.preproduct.ref_pre}#{self.color.ref_col}")
      cantidad = Product.where(ref_pro: "#{self.preproduct.section.ref_sec}#{self.preproduct.ref_pre}#{self.color.ref_col}").where("id != #{self.id}")
      if cantidad.size > 0
        errors.add(:ref_pro, "El producto ya existe") 
        return false
      end
    end

    def default_referencia
      self.ref_pro =  "#{self.preproduct.section.ref_sec}#{self.preproduct.ref_pre}#{self.color.ref_col}"
    end

    def self.search(search)
      result = where('titulo LIKE ?', "%#{search}%")
      result += where('descripcion LIKE ?', "%#{search}%")
      result += where('ref_pro LIKE ?', "%#{search}%")
      result.uniq
      result = result.sort_by &:ref_pro
    end

end
