# Sinatra Routers

A brief guide for use multiple routers in Sinatra.

## Sinatra
Sinatra is a minimalistic [dsl](https://en.wikipedia.org/wiki/Domain-specific_language "domain specific language") for creating web application in Ruby.
You can follow the [official readme](http://sinatrarb.com/intro.html "official readme") to get started.

By default, Sinatra doesn't give the power to mange multiple routers.

In this quick tutorial, we'll see how to do it with a few lines of code.

## Rack
You can achieve a multi-router system in Sinatra using the class [Rack::Mount::RouteSet](https://www.rubydoc.info/gems/rack-mount/0.8.3/Rack/Mount/RouteSet "RouteSet") offered by Rack.

## tl;dr
You can clone this repo and try it in your local machine.

`git clone git@github.com:mifrugo/sinatra_routers.git my_folder`

------------

## Structure
### app.rb
In an `app.rb` file, require [Sinatra/Base](https://www.rubydoc.info/gems/sinatra/Sinatra/Base "Sinatra/Base") and [Rack/Mount](https://www.rubydoc.info/gems/rack-mount/0.8.3/Rack/Mount "Rack/Mount") (install the gems if you haven't already).
```ruby
require 'sinatra/base'
require 'rack/mount'
```
Then create your main router, that will be a children of Sinatra/Base.
```ruby
class Router < Sinatra::Base; end
```

That's it!
You can now create as many sub-router as you want.
We are using a *main router* in order to have inheritance and easily share elements (such as an User instance -- see this Git files for an example) between the different routers.
```ruby
class RouterPublic < Router
  get '/' do
    'Homepage'
  end

  get '/about' do
    'About page'
  end
end
```

```ruby
class RouterAdmin < Router
  get '/admin' do
    'Admin Homepage'
  end
end
```

### config.ru
Since we will use Rack, we need to create a Rack file to run our server.
In the file, require the `app.rb` file and register the routers (this code is very basilar, we could automate the registration in multiple ways, but this goes beyond Sinatra).
```ruby
require './app'
Routes = Rack::Mount::RouteSet.new do |set|
  set.add_route RouterAdmin
  set.add_route RouterPublic
end

run Routes
```

## Run the server
After creating your files, open the terminal, go to the folder of the server and run `rackup`

The default Rack port should be 9292, so you'll be able to access your ruby server on `localhost:9292`
