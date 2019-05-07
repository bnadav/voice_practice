# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def hagahot?
  AppConfig.find_by_key("hagahot").value=="true"
end  
  
 def uri_root
   "#{request.base_url}/voice_data"
 end

end
