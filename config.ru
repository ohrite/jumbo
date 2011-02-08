require 'config/init'
require 'jumbo'
require 'faye'

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 45,
                       :extensions => []

run Jumbo
