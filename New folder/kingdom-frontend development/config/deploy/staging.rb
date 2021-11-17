server '18.117.154.124', user: 'ubuntu', roles: %w{app db web}
set :deploy_to, '~/projects/KINGDOM/staging'
set :branch, 'staging'
set :stage, :production
set :rails_env, :production
set :enable_ssl, false
