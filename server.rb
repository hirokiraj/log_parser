require 'sinatra'

set(:probability) { |value| condition { rand <= value } }

put '/remove-backup', :probability => 0.1 do
  status 500
  { error: 'its a trap' }.to_json
end

put '/remove-backup', :probability => 0.1 do
  status 404
  { error: 'cant find object with given id' }.to_json
end

put '/remove-backup', :probability => 0.1 do
  status 422
  { error: 'unprocessable entity' }.to_json
end

put '/remove-backup' do
  return 200
end
