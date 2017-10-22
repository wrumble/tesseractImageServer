require 'sinatra'
require "json"
require 'sinatra/base'
require 'sinatra'
require 'json'
require 'fileutils'
require 'tempfile'
require "base64"
require 'puma_worker_killer'

PumaWorkerKiller.enable_rolling_restart

set :protection, except: [ :json_csrf ]
port = ENV['PORT'] || 8080
set :port, port
set :bind, '0.0.0.0'

post '/extractText' do
  begin
    bas64Image = Base64.decode64(params[:image])
    imageFile = Tempfile.new(['image', '.png'])
    imageFile.write(bas64Image)
    imageFile.close
    # `textdeskew #{imageFile.path} #{imageFile.path}`
    `textcleaner -u -T #{imageFile.path} #{imageFile.path}`
    output = `tesseract #{imageFile.path} --psm 6 stdout`
    p output
  rescue
    status 402
    return "Error reading image"
  end
  status 200
  return output
end
