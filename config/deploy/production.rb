server '54.65.13.181', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/yusuke/.ssh/id_rsa'
