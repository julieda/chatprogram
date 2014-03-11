require 'faye'
require 'rack'

bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
run faye_server
bayeux.listen(9292)
