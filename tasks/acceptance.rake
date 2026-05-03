namespace :acceptance do
  desc "shows components that can be tested"
  task :components do
    exec("dumb-vagrant-spec components --config=dumb-vagrant-spec.config.rb")
  end

  desc "runs acceptance tests"
  task :run do
    args = [
      "--config=dumb-vagrant-spec.config.rb",
    ]

    if ENV["COMPONENTS"]
      args << "--components=\"#{ENV["COMPONENTS"]}\""
    end

    command = "dumb-vagrant-spec test #{args.join(" ")}"
    puts command
    puts
    exec(command)
  end
end
