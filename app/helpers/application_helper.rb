# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def hagahot?
  AppConfig.find_by_key("hagahot").value=="true"
end  
  
end
