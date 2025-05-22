module RailsOneAi
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/app",
      "#{config.root}/app/models/message"
    ]
    config.eager_load_paths += Dir[
      "#{config.root}/app/models/app",
      "#{config.root}/app/models/message"
    ]

  end
end
