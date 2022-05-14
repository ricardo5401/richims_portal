
server '143.198.224.239', port: 22, roles: %i(web app db), primary: true
set :stage, 'production'

set :nvm_node, 'v14.17.0'
set :nvm_map_bins, %w{node yarn webpack rake}
set :nvm_roles, :all