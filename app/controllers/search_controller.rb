class SearchController < ApplicationController

  require 'will_paginate/array'
  layout 'products'
  
  def index
    @sections = Section.sorted

    unless params[:searchbox].blank? 
      @products = Product.search(params[:searchbox]).paginate(:page => params[:page], :per_page => 4)
    else
      redirect_to catalogo_index_path
    end
  end

  def show
    if params[:product_id] 
      @product = Product.find(params[:product_id])
    else
      redirect_to catalogo_index_path
    end
  end

end
