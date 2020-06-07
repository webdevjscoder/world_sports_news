require_relative './config/environment'

use Rack::MethodOverride
use UsersController
use TeamsController
use CommentsController
run ApplicationController