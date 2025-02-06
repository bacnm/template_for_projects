#!/bin/bash

################################################################################ 
# Create Project
################################################################################

# provide sudo for the following commands (like chmod,...) and exit if wrong password or ctrl + c
if ! sudo true;
then
    exit 1
fi

#check project name
if [ $1 ];
then
	PROJECT_NAME="$1" # Store project name in a variable
    mkdir "$PROJECT_NAME" # Use variable and double quotes
else
    echo 'No project name'
	exit 1
fi

cd "$PROJECT_NAME" # Use variable and double quotes

# WHERE TO RUN PROJECT
cat > README.txt << EOF
- ALWAYS RUN PROJECT FROM HERE ( NOT IN src/ FOLDER) TO MAKE ALL LINK OF IMPORT FILE CORRECT
- Run file start.sh to run project
EOF

################################################################################ 
# git init
################################################################################


################################################################################ 
# Check virtual environment folder and requirements
################################################################################

######################################
# Check virtual environment folder
######################################
FLASK_ENV_FOLDER="flask_env"

python3 -m venv "$FLASK_ENV_FOLDER"
source "$FLASK_ENV_FOLDER/bin/activate"

############################in########
# install requirements
######################################

pip install flask


################################################################################ 
# Create templates for project
################################################################################

#######################################
# Create requirements.txt
#######################################
touch requirements.txt

#######################################
# create source folder
#######################################
mkdir src
cd src

#######################################
# Create models folđer
#######################################
mkdir models

#######################################
# Create template folder
#######################################
mkdir templates

#######################################
# Create static folder
#######################################
mkdir static
 
#######################################
# create constant folder
#######################################
mkdir constants

cat > constants/__init__.py << EOF
__all_ = ["http_status_code"]
EOF

cat > constants/http_status_code.py << EOF
HTTP_200_OK = 200
HTTP_201_CREATED = 201
HTTP_202_ACCEPTED = 202
HTTP_203_NON_AUTHORITATIVE_INFORMATION = 203
HTTP_204_NO_CONTENT = 204
HTTP_205_RESET_CONTENT = 205
HTTP_206_PARTIAL_CONTENT = 206
HTTP_207_MULTI_STATUS = 207
HTTP_208_ALREADY_REPORTED = 208
HTTP_226_IM_USED = 226
HTTP_300_MULTIPLE_CHOICES = 300
HTTP_301_MOVED_PERMANENTLY = 301
HTTP_302_FOUND = 302
HTTP_303_SEE_OTHER = 303
HTTP_304_NOT_MODIFIED = 304
HTTP_305_USE_PROXY = 305
HTTP_306_RESERVED = 306
HTTP_307_TEMPORARY_REDIRECT = 307
HTTP_308_PERMANENT_REDIRECT = 308
HTTP_400_BAD_REQUEST = 400
HTTP_401_UNAUTHORIZED = 401
HTTP_402_PAYMENT_REQUIRED = 402
HTTP_403_FORBIDDEN = 403
HTTP_404_NOT_FOUND = 404
HTTP_405_METHOD_NOT_ALLOWED = 405
HTTP_406_NOT_ACCEPTABLE = 406
HTTP_407_PROXY_AUTHENTICATION_REQUIRED = 407
HTTP_408_REQUEST_TIMEOUT = 408
HTTP_409_CONFLICT = 409
HTTP_410_GONE = 410
HTTP_411_LENGTH_REQUIRED = 411
HTTP_412_PRECONDITION_FAILED = 412
HTTP_413_REQUEST_ENTITY_TOO_LARGE = 413
HTTP_414_REQUEST_URI_TOO_LONG = 414
HTTP_415_UNSUPPORTED_MEDIA_TYPE = 415
HTTP_416_REQUESTED_RANGE_NOT_SATISFIABLE = 416
HTTP_417_EXPECTATION_FAILED = 417
HTTP_422_UNPROCESSABLE_ENTITY = 422
HTTP_423_LOCKED = 423
HTTP_424_FAILED_DEPENDENCY = 424
HTTP_426_UPGRADE_REQUIRED = 426
HTTP_428_PRECONDITION_REQUIRED = 428
HTTP_429_TOO_MANY_REQUESTS = 429
HTTP_431_REQUEST_HEADER_FIELDS_TOO_LARGE = 431
HTTP_451_UNAVAILABLE_FOR_LEGAL_REASONS = 451
HTTP_500_INTERNAL_SERVER_ERROR = 500
HTTP_501_NOT_IMPLEMENTED = 501
HTTP_502_BAD_GATEWAY = 502
HTTP_503_SERVICE_UNAVAILABLE = 503
HTTP_504_GATEWAY_TIMEOUT = 504
HTTP_505_HTTP_VERSION_NOT_SUPPORTED = 505
HTTP_506_VARIANT_ALSO_NEGOTIATES = 506
HTTP_507_INSUFFICIENT_STORAGE = 507
HTTP_508_LOOP_DETECTED = 508
HTTP_509_BANDWIDTH_LIMIT_EXCEEDED = 509
HTTP_510_NOT_EXTENDED = 510
HTTP_511_NETWORK_AUTHENTICATION_REQUIRED = 511

def is_informational(status):
    # 1xx
    pass

def is_success(status):
    # 2xx
    pass

def is_redirect(status):
    # 3xx
    pass

def is_client_error():
    # 4xx
    pass

def is_server_error():
    # 5xx
    pass
EOF


#######################################
# create App 
#######################################
touch app_config.py
cat > app_config.py << EOF
EOF

# create __init__.py file
cat > "__init__.py" << END_TEXT
from flask import Flask
from flask.json import jsonify
from src.constants.http_status_code import *

def create_app(config_filename=None):

	# create app object
    app = Flask(__name__)

    if config_filename is None:
	#	app.config.from_mapping (
	# 	SECRET_KEY=os.environ.get("SECRET_KEY"),
    #         SQLALCHEMY_DATABASE_URI=os.environ.get("SQLALCHEMY_DB_URI"),
    #         SQLALCHEMY_TRACK_MODIFICATIONS=False,
    #         JWT_SECRET_KEY=os.environ.get('JWT_SECRET_KEY'),


    #         SWAGGER={
    #             'title': "Bookmarks API",
    #             'uiversion': 3
    #         }
    #    )
        pass
    else:
        app.config.from_mapping(config_filename)

	
	# connect database
   
    # from yourapplication.model import db
    # db.init_app(app)


	# register blueprint

    # from yourapplication.views.admin import admin
    # from yourapplication.views.frontend import frontend
    # app.register_blueprint(admin)
    # app.register_blueprint(frontend)

    @app.route('/')
    def main_page():
        return "Hello world!"

    @app.errorhandler(HTTP_404_NOT_FOUND)
    def handle_404(e):
        return jsonify({'error': 'Not found'}), HTTP_404_NOT_FOUND

    @app.errorhandler(HTTP_500_INTERNAL_SERVER_ERROR)
    def handle_500(e):
        return jsonify({'error': 'Something went wrong, we are working on it'}), HTTP_500_INTERNAL_SERVER_ERROR

    return app
END_TEXT


#######################################
# create module folder
#######################################

# create module folder

mkdir modules
cat > modules/__init__.py << EOF
from . import *
EOF

cat > modules/readme.txt << EOF
If you want to create new flask module, create new folder

Each module have 4 default python files
- __init__.py => default file that helps python find each module (always need __all__)
- [module_name]_controller.py => define blueprint, route (@[blueprint].route) and call function from [module_nanme]_service.py files to solve request 
- [module_nanme]_service.py => define function to solve request
- [module_name]_config.py => config of blueprint in module
EOF

################################################################################ 
# Create script to run project
################################################################################
SCRIPT_DIR='
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
cd "$SCRIPT_DIR"'

SCRIPT_COMMAND="source $FLASK_ENV_FOLDER/bin/activate
flask --app src run"

cat > ../start.sh << EOF
#!/bin/bash
$SCRIPT_DIR
$SCRIPT_COMMAND
EOF

sudo chmod u+x ../start.sh
################################################################################ 
# DONE
################################################################################
echo "DONE"

################################################################################ 
# Run the first time to check errors
################################################################################

cd ..

sudo ./start.sh
