require 'sinatra/base'
require 'eventmachine'
require 'base64'
require 'faye'

class JumboUpload < Sinatra::Base
  attr_accessor :faye_server
  
  post '/upload' do
    content_type :json
    
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

    EM.run {
      env['faye.client'].publish('/files', attrs.merge({
        :data => "data:#{attrs[:type]};base64,#{block_64}"
      }))
    }

    attrs.to_json
  end
end
