require './app'
Routes = Rack::Mount::RouteSet.new do |set|
  set.add_route RouterAdmin
  set.add_route RouterPublic
end

run Routes
