require 'sinatra/base'

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
    
    client = Faye::Client.new('http://localhost:9292/faye')
    EM.run do
      client.publish('/files', 'filename' => name, 'message' => 'received file')
    end

    path = File.join('public', 'files', name)
    written = 0
    File.open(path, "wb") do |f|
      while blk = tmpfile.read(65535)
        f.write(blk)
        written += blk.length
        
        EM.run do
          client.publish('/files', 'filename' => name, 'message' => 'writing blocks')
        end
      end
    end
    
    EM.run do
      client.publish('/files', 'filename' => name, 'message' => 'finished writing blocks')
    end
    
    { :name => params[:file][:filename], :type => params[:file][:filetype], :size => written }.to_json
  end
end
