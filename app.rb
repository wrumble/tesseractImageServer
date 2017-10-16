require 'sinatra'
require "json"
require 'sinatra/base'
require 'sinatra'
require 'json'
require 'fileutils'
require 'tempfile'
require "base64"

set :protection, except: [ :json_csrf ]

port = ENV['PORT'] || 8080
puts "STARTING SINATRA on port #{port}"
set :port, port
set :bind, '0.0.0.0'

post '/extractText' do
  begin
    bas64Image = Base64.decode64(params[:image])
    imageFile = Tempfile.new(['image', '.jpg'])
    imageFile.write(bas64Image)
    imageFile.close
    system("textcleaner #{imageFile.path} #{imageFile.path}")
    output = `tesseract #{imageFile.path} --psm 6 stdout`
    p output
  rescue
    status 402
    return "Error reading image"
  end
  status 200
  return output.to_json
end