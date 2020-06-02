require './config/environment'

use Rack::MethodOverride
run ApplicationController
use GenresController
use ArtistsController
use SongsController
