# frozen_string_literal: true

require 'rspec/core/rake_task'

namespace :rswag do
  namespace :specs do
    desc 'Generate Swagger JSON files from integration specs'
    RSpec::Core::RakeTask.new('swaggerize') do |t|
      t.pattern = ENV.fetch(
        'PATTERN',
        'spec/requests/**/*_spec.rb, spec/api/**/*_spec.rb, spec/integration/**/*_spec.rb'
      )

      # NOTE: rspec 2.x support
      if Rswag::Specs::RSPEC_VERSION > 2 && Rswag::Specs.config.swagger_dry_run
        t.rspec_opts = ['--tag only_swagger --format Rswag::Specs::SwaggerFormatter', '--dry-run', '--order defined']
      else
        t.rspec_opts = ['--tag only_swagger --format Rswag::Specs::SwaggerFormatter', '--order defined']
      end
    end
  end

  namespace :specs2 do
    desc 'Generate Swagger JSON files from integration specs for API v2 only'
    RSpec::Core::RakeTask.new('swaggerize') do |t|
      t.pattern = ENV.fetch(
        'PATTERN',
        'spec/requests/**/*_spec.rb, spec/api/**/*_spec.rb, spec/integration/**/*_spec.rb'
      )

      # NOTE: rspec 2.x support
      if Rswag::Specs::RSPEC_VERSION > 2 && Rswag::Specs.config.swagger_dry_run
        t.rspec_opts = ['--tag only_swagger --tag api:v2 --format Rswag::Specs::SwaggerFormatter', '--dry-run', '--order defined']
      else
        t.rspec_opts = ['--tag only_swagger --tag api:v2 --format Rswag::Specs::SwaggerFormatter', '--order defined']
      end
    end
  end
end

task rswag: ['rswag:specs2:swaggerize']
