@echo on

set project_dir=..\my-blog-django
set virtual_environment_dir=myvenv

cd "%project_dir%"

start "" "http://127.0.0.1:8000/"
start "" "http://127.0.0.1:8000/admin/"

call %virtual_environment_dir%\Scripts\activate.bat
python manage.py runserver

pause
