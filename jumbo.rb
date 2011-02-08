require 'sinatra/base'

class Jumbo < Sinatra::Base
  #use JumboLogin
  use JumboUpload
  use JumboRenderers
  helpers Sinatra::Partials
  
  helpers do
    def ie_tag(name=:html, attrs={}, &block)
      attrs = attrs.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
      haml_concat("<!--[if lt IE 7 ]> #{ capture_haml { haml_tag(name, attrs.merge({:class => 'ie6'}), true) } } <![endif]-->")
      haml_concat("<!--[if IE 7 ]>    #{ capture_haml { haml_tag(name, attrs.merge({:class => 'ie7'}), true) } } <![endif]-->")
      haml_concat("<!--[if IE 8 ]>    #{ capture_haml { haml_tag(name, attrs.merge({:class => 'ie8'}), true) } } <![endif]-->")
      haml_concat("<!--[if IE 9 ]>    #{ capture_haml { haml_tag(name, attrs.merge({:class => 'ie9'}), true) } } <![endif]-->")
      haml_concat("<!--[if (gte IE 9)|!(IE)]><!-->")
      haml_tag name, attrs do
        haml_concat("<!--<![endif]-->")
        block.call
      end
    end
  end
  
  get '/' do
    p " going  to #{Sinatra::Application.views}"
    haml :index, :layout => :'layouts/application'
  end
end
