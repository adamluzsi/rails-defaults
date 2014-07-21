module RailsDefaults

  module Helpers
    class << self

      def must_be_instance_of obj, *classes

        var= classes.map { |class_name|

          if obj.class <= class_name
            true
          else
            nil
          end

        }.compact

        if var.empty?
          raise ArgumentError,"invalid input object, must be instance from one of these or they subclasses class: #{classes.join(', ')}"
        end

      end

    end
  end

  module OPTS

    def port obj= nil
      unless obj.nil?
        Helpers.must_be_instance_of obj, Numeric, Symbol, String
        @port= obj.to_i
      end
      return @port || 3000
    end

    def debugger obj= nil
      unless obj.nil?
        Helpers.must_be_instance_of obj, TrueClass,FalseClass
        @debugger= obj
      end
      return @debugger || false
    end

    def daemonize obj= nil?
      unless obj.nil?
        Helpers.must_be_instance_of obj, TrueClass,FalseClass
        @daemonize= obj
      end
      return @daemonize || false
    end

    def server server_name= nil

      unless server_name.nil?
        Helpers.must_be_instance_of server_name, String, Symbol
        @server= server_name
      end

      ###OLD WORKAROUND
      #require 'rack/handler'
      #begin
      #  eval " ::Rack::Handler::WEBrick = Rack::Handler.get(server_name)"
      #rescue LoadError
      #  STDERR.puts("#{server_name} gem is not installed, using WEBrick as default")
      #end

      return @server || :webrick
    end


    def environment obj= nil
      unless obj.nil?
        Helpers.must_be_instance_of obj,  String,Symbol
        @environment= obj.to_s
      end
      return @environment || "development"
    end

    alias :env :environment

    def options opts_var= {}
      opts_var.each do |method_name, value|
        begin
          self.__send__ method_name.to_s.downcase, value
        rescue NoMethodError

          raise ArgumentError,
                "invalid key #{method_name}, try use one from the followings: #{self.singleton_methods-[:opts,:options]}"

        end
      end
    end

    alias :opts :options

  end

  extend OPTS

  module DefaultOptions

    def default_options
      super.merge!(
          {
              Port:         :port,
              environment:  :environment,
              daemonize:    :daemonize,
              debugger:     :debugger,
              server:       :server
          }.map { |default_key,method_name|
            [ default_key, ::RailsDefaults.__send__(method_name)]
          }.reduce({}){ |m,ary| m.merge!({ary[0] => ary[1]}) unless ary[1].nil? }
      )
    end

    def server
      options[:server] ||= default_options[:server]
      super
    end

  end

end

require 'rails/commands/server'
Rails::Server.__send__( :prepend, RailsDefaults::DefaultOptions )