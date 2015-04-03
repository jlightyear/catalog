class SearchController < ApplicationController

  require 'will_paginate/array'
  layout 'products'
  
  def index
    common_variable_sections

    unless params[:searchbox].blank? 
      @products = Product.search(params[:searchbox]).paginate(:page => params[:page], :per_page => 4)

      respond_to do |format|
        format.html
        format.js
      end
      
    else
      redirect_to catalogo_index_path
    end
  end

  def show
    common_variable_sections

    if params[:product_id] && !params[:searchbox].blank?
      @product = Product.find(params[:product_id])
      @products = Product.search(params[:searchbox])

      if @products[(@products.index(@product))] != @products.last
        @next_product = @products[(@products.index(@product)) + 1]
      else
        @next_product = @products[0]
      end

      if @products[(@products.index(@product))] != @products[0]
        @previous_product = @products[(@products.index(@product)) - 1]
      else
        @previous_product = @products.last
      end

    else
      redirect_to catalogo_index_path
    end
  end

end
