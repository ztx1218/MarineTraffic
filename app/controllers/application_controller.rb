 require 'httparty'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
      render html: "hello world!"
  end
 def index
    # Choose the URL to visit
    # @app_url = "http://www.marinetraffic.com/en/ais/index/ships/all/_:c35428865d60c383702431a7d936ca65/flag:CN/shipname:MIL" 
     @app_url = "http://news.google.com"
    # Ensure it starts with http
    @app_url = "http://#{@app_url}" unless @app_url.starts_with?("http")

    begin
      # Retrieve the webpage
      @news = HTTParty.get(@app_url)
    rescue StandardError 
      # When something goes wrong create a fallback message
      @news = OpenStruct.new(:code => nil, :message => "Domain not found")
    end
    
    render html: "<span> <%= raw #{@news.code} %> <%= #{@news.message} %> </span>" 
  end
end
