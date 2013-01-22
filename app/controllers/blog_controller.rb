class BlogController < ApplicationController
  def proxy
    
    path = params[:id] || ""
    path += "/index.html" if path.match(/\S+\.\S+$/).nil?
    
    @content = File.read("./public/blog-generated/#{path}")
  end
end
