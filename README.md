rails-defaults
==============

Ruby modul for Rails to Patch default used server / port , etc 

### Examples for use


```ruby

    require 'rails-defaults'

    RailsDefaults.port          3003
    RailsDefaults.server        :puma
    RailsDefaults.environment   :development

```

or you can use the hash input way with the options/opts call

```ruby

    require 'rails-defaults'

    RailsDefaults.opts port:    3210,
                       server:  :puma,
                       env: :development

```

now you can use simple rails start up like 'rails s' || 'rails server'