require_relative './config/environment'

use Rack::MethodOverride
use UsersController
use TeamsController
run ApplicationController