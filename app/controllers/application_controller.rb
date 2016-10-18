require 'httparty'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  def index
    # Set the URL to visit
    @app_url = "http://www.marinetraffic.com/en/ais/index/ships/all/_:c35428865d60c383702431a7d936ca65/flag:#{params[:location]}/shipname:#{params[:vessel]}" 

    # Check Param Vessel 
    if params[:vessel].nil?
       render html: "No Vessel Input!"
    # Check Param Location
    elsif params[:location].nil?
       render html: "No Location Input!"
    else
      begin
         # Retrieve the webpage
         @response = HTTParty.get(@app_url)
         # Check Response Status
         if @response.code == 200
            redirect_to(@app_url)
         else
            render html: "Error: #{@response.code}"
         end
      rescue StandardError
         # When something goes wrong 
         render html: "Domain Not Found!"
      end
    end
  end
end
