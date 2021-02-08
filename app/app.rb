require 'rack/mount'
require 'sinatra/base'
require_relative './controllers/user'

# Main router
class Router < Sinatra::Base
  @@user = User.new({ name: 'Michele', role: 'admin' })
end

# My public router
class RouterPublic < Router
  ['/', '/add'].each do |path|
    get path do
      erb :'user/layout'
    end
  end

  not_found do
    status 404
    erb :'user/404'
  end
end

# My Admin router
class RouterAdmin < Router
  get %r{/admin(/|/(.+))?} do
    if @@user.role != 'admin'
      status 404
      return erb :'user/404'
    end

    erb :'admin/layout'
  end
end
