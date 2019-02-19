class DashboardController < ApplicationController
	require 'open-uri'
  def home
  	# @cattribute_collection = Cattribute.all.group_by(&:readable_category)
  	get_cattributes
  end

  def get_traits
  	url = params[:url]

  	response = trait_call(url)

  	respond_to do |format|
  		format.json {
  			render :js => response.html_safe
  		}
  	end
  end

  private


  def trait_call(url)
	response = open(url,"x-api-token" => ENV['CK_API_KEY']).read
	return response
  end

  def get_cattributes
  	response = open("https://public.api.cryptokitties.co/v1/cattributes", "x-api-token" => ENV['CK_API_KEY'], "Content-Type" => "application/json").read
  	
  	JSON.parse(response).each do |value|
  		cattribute = Cattribute.new()
  		cattribute.gene = value['gene'].to_i
  		cattribute.category = value['type']
  		cattribute.name = value['description']
  		cattribute.save!
  	end
  end
end



