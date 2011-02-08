require 'sinatra/base'
require 'base64'

class JumboUpload < Sinatra::Base
  post '/upload' do
    content_type :json
    
    p "incoming params #{params.to_yaml}"
    
    if params[:file]
      tmpfile = params[:file][:tempfile]
      name = params[:file][:filename]
    end

    unless params[:file] && tmpfile && name
      @error = "No file selected"
      return {}.to_json
    end
    
    block = tmpfile.read
    block_64 = Base64.encode64(block)

    attrs = { :name => params[:file][:filename], :type => params[:file][:type], :size => block.length }

    
    client = Faye::Client.new('http://localhost:9292/faye')
    EM.run do
      client.publish('/files', { :data => "data:#{attrs[:type]};base64,#{block_64}" }.merge(attrs))
    end
    
    attrs.to_json
  end
end
