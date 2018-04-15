@echo off
cls

chcp 65001

rem set "is_commit="
set "is_commit=y"

set "is_push="
rem set "is_push=y"




setlocal

set project_dir=..\my-blog-django

set git_user_name=Аббас Гусенов
set git_user_email=gusenov@live.ru
set git_remote_url=https://YOUR_LOGIN_NAME_HERE:YOUR_PASSWORD_HERE@github.com/YOUR_LOGIN_NAME_HERE/YOUR_REPO_HERE.git

set git_first_commit_message=root

set virtual_environment_dir=myvenv
set git_venv_ignore_commit_msg=Файл .gitignore для виртуального окружения (VirtualEnv).

set django_project_dir=myproject
set django_version=1.11.0
set git_create_django_project_msg=Скелет нового Django-проекта.
set git_py_ignore_commit_msg=Файд .gitignore для Python.

set django_project_time_zone=Asia/Almaty
set git_time_zone_commit_msg=Настройка проекта: установка часового пояса Asia/Almaty.
rem https://stackoverflow.com/q/13866926/2289640

set django_project_lang_code=ru-ru
set git_lang_code_commit_msg=Настройка проекта: установка русского языка.

set git_static_url_commit_msg=Настройка проекта: добавление информации о расположении статических файлов.

set python_anywhere_url=gusenov.pythonanywhere.com
set git_allowed_hosts_commit_msg=Настройка проекта: добавление разрешённых хостов.

set django_app_name=myapp
set git_create_app_commit_msg=Создание отдельного приложения в проекте.
set git_use_app_commit_msg=Настройка проекта: использование созданного отдельного приложения.

set git_model_post_commit_msg=Создание модели Post представляющей пост в блоге.
set git_model_mig_commit_msg=Файл с миграцией для добавления модели поста Post в базу данных.
set git_model_post_adm_commit_msg=Импорт и регистрация модели Post в панели управления администратора Django.

set django_admin_name=gusenov
set django_admin_email=gusenov@live.ru
rem set django_admin_password=YOUR_PASSWORD_HERE

set git_blog_css_commit_msg=Установка посредством CSS цвета заголовка.
set git_base_commit_msg=Создание базового шаблона - общей типовой формы страницы.
set git_post_list_commit_msg=Шаблон страницы списка постов.
set git_post_detail_commit_msg=Создание шаблона поста - страницы для отображения конкретной записи.

set django_blog_title_text=Аббас Гусенов
rem YOUR_TITLE_HERE
set django_blog_header_text=Блог Аббаса Гусенова
rem YOUR_HEADER_HERE
set django_blog_header_text_color=#006621

set git_views_commit_msg=Представления для соединения между собой модели Post и шаблонов: post_list.html, post_detail.html.

set git_redirect_commit_msg=Перенаправление всех запросов к %django_app_name%.urls для поиска там дальнейших инструкций.
set git_blog_urls_commit_msg=Файл %django_app_name%/urls.py.

set git_requirements_commit_msg=Сохранение списка всех зависимостей проекта в файл с именем requirements.txt.




rem Создадим директорию:
if not exist "%project_dir%" ^
mkdir "%project_dir%"

cd "%project_dir%"

if not exist ".git" ^
call :GitInit "%git_user_name%" "%git_user_email%" "%git_remote_url%" "%git_first_commit_message%"

if not exist "%virtual_environment_dir%" ^
call :CreateVirtualEnv "%virtual_environment_dir%"

if not exist "%virtual_environment_dir%\.gitignore" ^
call :DownloadGitIgnore "%virtual_environment_dir%/.gitignore"^
 "https://raw.githubusercontent.com/github/gitignore/master/Global/VirtualEnv.gitignore"^
 "%git_venv_ignore_commit_msg%"

if not exist ".gitignore" ^
call :DownloadGitIgnore ".gitignore"^
 "https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore"^
 "%git_py_ignore_commit_msg%"

if not exist "%virtual_environment_dir%\Lib\site-packages\django" ^
call :InstallDjango "%virtual_environment_dir%" %django_version% & ^
call :SaveRequirements "%virtual_environment_dir%" "%git_requirements_commit_msg%"

if not exist "%django_project_dir%" ^
call :CreateDjangoProject "%virtual_environment_dir%" "%django_project_dir%" "%git_create_django_project_msg%" & ^
call :ConfigDjangoSite "%django_project_dir%"^
 "%django_project_time_zone%" "%git_time_zone_commit_msg%"^
 "%django_project_lang_code%" "%git_lang_code_commit_msg%"^
 "%git_static_url_commit_msg%"^
 "%python_anywhere_url%" "%git_allowed_hosts_commit_msg%"

if not exist "db.sqlite3" call :CreateDatabase "%virtual_environment_dir%"

if not exist "%django_app_name%" ^
call :CreateApp "%virtual_environment_dir%" "%django_app_name%" "%git_create_app_commit_msg%" "%git_use_app_commit_msg%" "%django_project_dir%"

if not exist "%django_app_name%/migrations/0001_initial.py" ^
call :CreateModelPost "%virtual_environment_dir%" "%django_app_name%" "%git_model_post_commit_msg%" "%git_model_mig_commit_msg%" "%git_model_post_adm_commit_msg%" & ^
call :CreateSuperUser "%virtual_environment_dir%" "%django_admin_name%" "%django_admin_email%"

if not exist "%django_app_name%\templates\%django_app_name%" call :CreateHtmlTemplates "%django_app_name%"^
 "%git_blog_css_commit_msg%"^
 "%git_base_commit_msg%"^
 "%git_post_list_commit_msg%"^
 "%git_post_detail_commit_msg%"^
 "%django_blog_title_text%"^
 "%django_blog_header_text%"^
 "%django_blog_header_text_color%" & ^
call :CreateViews "%django_app_name%" "%git_views_commit_msg%"

if not exist "%django_app_name%\urls.py" call :MapUrls "%django_project_dir%"^
 "%git_redirect_commit_msg%"^
 "%django_app_name%"^
 "%git_blog_urls_commit_msg%"

if exist %django_app_name%\templates\%django_app_name%\sed* del %django_app_name%\templates\%django_app_name%\sed*
if exist "%django_project_dir%\sed*" del %django_project_dir%\sed*

if defined is_push (git push -u origin master)

pause

endlocal
EXIT /B %ERRORLEVEL%




:GitInit
echo #1 GitInit
setlocal

git init

git config --local user.name "%~1"
git config --local user.email "%~2"
git config --local core.quotepath false

git remote add origin %~3

if defined is_commit (git commit -m "%~4" --allow-empty)

endlocal
exit /B 0




:CreateVirtualEnv
echo #2 CreateVirtualEnv
setlocal

rem Настройка virtualenv:
rem Virtualenv изолирует зависимости Python/Django для каждого отдельного проекта. 
rem Это значит, что изменения одного сайта никогда не затронут другие сайты.
rem Создадим виртуальное окружение под именем %~1. 
rem В общем случаем команда будет выглядеть так:
python -m venv %~1

endlocal
exit /B 0




:DownloadGitIgnore
echo #3 DownloadGitIgnore(%~1)
setlocal

wget -q --no-check-certificate -O "%~1" "%~2"
git add "%~1"
if defined is_commit (git commit -m"%~3")

endlocal
exit /B 0




:InstallDjango
echo #4 InstallDjango
setlocal

rem Запустим виртуальное окружение:
call %~1\Scripts\activate.bat

rem Перед этим необходимо удостовериться, что установлена последняя версия pip:
python -m pip install --upgrade pip

rem Установка Django:
pip install django~=%~2

endlocal
exit /B 0




:SaveRequirements
echo #5 SaveRequirements
setlocal

rem Запустим виртуальное окружение:
call %~1\Scripts\activate.bat

pip freeze > requirements.txt

git add "requirements.txt"
if defined is_commit (git commit -m"%~2")

endlocal
exit /B 0




:CreateDjangoProject
echo #6 CreateDjangoProject
setlocal

rem Запустим виртуальное окружение:
call %~1\Scripts\activate.bat

rem Проект на Django:
rem Первый шаг - создать новый проект Django. 
rem В сущности, это значит, что мы запустим несколько стандартных скриптов из поставки Django, которые создадут для нас скелет проекта (каталоги и файлы).
rem Названия этих каталогов и файлов очень важны для Django (нельзя переименовывать или перемещать).
django-admin.exe startproject %~2 .
rem django-admin.py - это скрипт, который создаст необходимую структуру директорий и файлы.

git add "manage.py"
git add "%~2/"
if defined is_commit (git commit -m"%~3" -m"django-admin.exe startproject %~2 .")

endlocal
exit /B 0




:ConfigDjangoSite
echo #7 ConfigDjangoSite
setlocal

rem Изменяем настройки.
rem Внесём изменения в %~1/settings.py:

rem Установим корректный часовой пояс:
sed -i "s|TIME_ZONE = 'UTC'|TIME_ZONE = '%~2'|g" "%~1/settings.py"
git add "%~1/settings.py"
if defined is_commit (git commit -m"%~3")

rem Изменим язык, отредактировав следующую строку:
sed -i "s|LANGUAGE_CODE = 'en-us'|LANGUAGE_CODE = '%~4'|g" "%~1/settings.py"
git add "%~1/settings.py"
if defined is_commit (git commit -m"%~5")

rem Добавим в настройки информацию о расположении статических файлов 
rem (в конеце файла и после переменной STATIC_URL добавим новую - STATIC_ROOT):
sed -i "s|STATIC_URL = '/static/'|STATIC_URL = '/static/'\nSTATIC_ROOT = os.path.join(BASE_DIR, 'static')|g" "%~1/settings.py"
git add "%~1/settings.py"
if defined is_commit (git commit -m"%~6")

rem Добавим разрешённый host (имя пользователя на PythonAnywhere):
sed -i "s|ALLOWED_HOSTS = \[\]|ALLOWED_HOSTS = \['127.0.0.1', '%~7'\]|g" "%~1/settings.py"
git add "%~1/settings.py"
if defined is_commit (git commit -m"%~8")

endlocal
exit /B 0




:CreateDatabase
echo #8 CreateDatabase
setlocal

rem Запустим виртуальное окружение:
call %~1\Scripts\activate.bat

rem Настройка базы данных:
rem Существует множество различных баз данных, которые могут хранить данные для твоего сайта.
rem Мы будем использовать стандартную - sqlite3.
rem Чтобы создать базу данных используем (директории, где расположен файл manage.py):
python manage.py migrate

endlocal
exit /B 0




:CreateApp
echo #9 CreateApp
setlocal

rem Запустим виртуальное окружение:
call %~1\Scripts\activate.bat

rem Создадим отдельное приложение в нашем проекте, используя:
python manage.py startapp %~2
rem (Перед этим необходимо запустить виртуальное окружение. )

git add "%~2/"
if defined is_commit (git commit -m"%~3")

rem После того, как приложение создано, нам нужно сообщить Django, что теперь он должен его использовать.
rem Сделаем это с помощью файла %~5/settings.py.
rem Нужно найти INSTALLED_APPS и добавить к списку '%~2', прямо перед ].
sed -i "s|    'django.contrib.staticfiles',|    'django.contrib.staticfiles',\n    '%~2',|g" "%~5/settings.py"

git add "%~5/settings.py"
if defined is_commit (git commit -m"%~4")

endlocal
exit /B 0




:CreateModelPost
echo #10 CreateModelPost
setlocal

rem Запустим виртуальное окружение:
call %~1\Scripts\activate.bat

rem Создание модели записи в блоге:
rem Модель в Django - это объект определённого свойства, он хранится в базе данных (используем SQLite).
rem В файле %~2/models.py определяем все модели (удалить все и добавить):
(
echo from django.db import models
echo from django.utils import timezone
echo.
echo class Post(models.Model^):
echo 	author = models.ForeignKey('auth.User', on_delete=models.CASCADE^)
echo 	title = models.CharField(max_length=200^)
echo 	text = models.TextField(^)
echo 	created_date = models.DateTimeField(default=timezone.now^)
echo 	published_date = models.DateTimeField(blank=True, null=True^)
echo.
echo def publish(self^):
echo 	self.published_date = timezone.now(^)
echo 	self.save(^)
echo.
echo def __str__(self^):
echo 	return self.title
) >%~2\models.py
rem http://www.robvanderwoude.com/escapechars.php
rem Character to be escaped	| Escape Sequence
rem )                       |              ^)

git add "%~2/models.py"
if defined is_commit (git commit -m"%~3")

rem Создаём таблицы моделей в базе данных:
rem Далее добавим модель в базу данных. 
rem Сначала мы должны дать Django знать, что сделали изменения в нашей модели.
python manage.py makemigrations %~2
rem (команда создаст файл с миграцией для базы данных)

git add "%~2/migrations/0001_initial.py"
if defined is_commit (git commit -m"%~4")

python manage.py migrate %~2

rem Администрирование Django:
rem Чтобы добавлять, редактировать и удалять записи используем панель управления администратора Django. 
rem Импортируем и регистрируем модель Post: 
rem Откроем файл %~2/admin.py и заменим его содержимое на 
rem (далее можно зайти на http://127.0.0.1:8000/admin/):
(
echo from django.contrib import admin
echo from .models import Post
echo.
echo admin.site.register(Post^)
) >%~2\admin.py

git add "%~2/admin.py"
if defined is_commit (git commit -m"%~5")

endlocal
exit /B 0




:CreateSuperUser
echo #11 CreateSuperUser
setlocal

rem Запустим виртуальное окружение:
call %~1\Scripts\activate.bat

rem Далее необходимо создать супер пользователя:
python manage.py createsuperuser --username=%~2 --email=%~3

endlocal
exit /B 0




:CreateHtmlTemplates
echo #12 CreateHtmlTemplates
setlocal

rem Создание шаблона:
rem Шаблоны сохраняются в директории %~1/templates/%~1/
rem Создаем директорию templates внутри папки %~1, далее другую директорию %~1 внутри папки templates.
mkdir %~1\templates\%~1

rem Добавление CSS:
rem Создаем новую папку под названием css внутри папки static, затем файл %~1.css внутри папки css.
mkdir %~1\static\css\
rem Изменим цвет заголовка:
(
echo h1 a {
echo 	color: %~8;
echo }
) >%~1\static\css\%~1.css

git add "%~1/static/css/%~1.css"
if defined is_commit (git commit -m"%~2")

rem Базовый шаблон - это наиболее общая типовая форма страницы, которую можно расширить для отдельных случаев.
rem Создаем файл base.html в директории %~1/templates/%~1/ и скопируем всё из post_list.html в base.html. 
rem Затем в файле base.html заменим всё между тегами <body> и </body> следующим кодом:
(
echo ^<html^>
echo 	^<head^>
echo 		^<title^>%~6^</title^>
echo 		^<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"^>
echo 		^<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"^>
echo 		^<link rel="stylesheet" href="/static/css/%~1.css"^>
echo 	^</head^>
echo	^<body^>
echo		^<div class="page-header"^>
echo			^<h1^>^<a href="/"^>%~7^</a^>^</h1^>
echo		^</div^>
echo		^<div class="content container"^>
echo			^<div class="row"^>
echo				^<div class="col-md-8"^>
echo					{%% block content %%}
echo					{%% endblock %%}
echo				^</div^>
echo			^</div^>
echo		^</div^>
echo	^</body^>
echo ^</html^>
) >%~1\templates\%~1\base.html

git add "%~1/templates/%~1/base.html"
if defined is_commit (git commit -m"%~3")

rem Создаем файл post_list.html внутри директории %~1/templates/%~1/ и добавляем следующий код:
(
echo ^<html^>
echo 	^<head^>
echo 		^<title^>%~6^</title^>
echo 		^<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"^>
echo 		^<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"^>
echo 		^<link rel="stylesheet" href="/static/css/%~1.css"^>
echo 	^</head^>
echo ^<body^>
echo 	^<div^>
echo 		^<h1^>^<a href="/"^>%~7^</a^>^</h1^>
echo 	^</div^>
echo	^<div class="container"^>
echo		^<div class="row"^>
echo			^<div class="col-md-8"^>
echo			 	{%% for post in posts %%}
echo			 		^<div class="post"^>
echo			 			^<div class="date"^>
echo							^<p^>Опубликовано: {{ post.published_date }}^</p^>
echo						^</div^>
echo			 			^<h1^>^<a href=""^>{{ post.title }}^</a^>^</h1^>
echo			 			^<p^>{{ post.text ^| linebreaksbr }}^</p^>
echo			 		^</div^>
echo			 	{%% endfor %%}
echo			^</div^>
echo		^</div^>
echo	^</div^>
echo ^</body^>
echo ^</html^>
) >%~1\templates\%~1\post_list.html

(
echo {%% extends '%~1/base.html' %%}
echo {%% block content %%}
echo 	{%% for post in posts %%}
echo 		^<div class="post"^>
echo 			^<div class="date"^>
echo 				{{ post.published_date }}
echo 			^</div^>
echo 			^<h1^>
echo 				^<a href=""^>{{ post.title }}^</a^>
echo 			^</h1^>
echo 			^<p^>{{ post.text ^| linebreaksbr }}^</p^>
echo 		^</div^>
echo 	{%% endfor %%}
echo {%% endblock %%}
) >%~1\templates\%~1\post_list.html

rem Необходимо создать страницу для отображения конкретной записи.
rem Добавим ссылку внутрь файла %~1/templates/%~1/post_list.html
sed -i "s|<a href=\"\">{{ post\.title }}</a>|<a href=\"{%% url 'post_detail' pk=post\.pk %%}\">{{ post\.title }}</a>|g" "%~1/templates/%~1/post_list.html"

git add "%~1/templates/%~1/post_list.html"
if defined is_commit (git commit -m"%~4")

rem Создадим шаблон для страницы поста:
rem Создадим файл post_detail.html в директории %~1/templates/%~1/
(
echo {%% extends '%~1/base.html' %%}
echo {%% block content %%}
echo 	^<div class="post"^>
echo 		{%% if post.published_date %%}
echo 			^<div class="date"^>
echo 				{{ post.published_date }}
echo 			^</div^>
echo 		{%% endif %%}
echo 		^<h1^>{{ post.title }}^</h1^>
echo 		^<p^>{{ post.text ^| linebreaksbr }}^</p^>
echo 	^</div^>
echo {%% endblock %%}
) >%~1\templates\%~1\post_detail.html

git add "%~1/templates/%~1/post_detail.html"
if defined is_commit (git commit -m"%~5")

endlocal
exit /B 0




:CreateViews
echo #X3 CreateViews
setlocal

rem Представления в Django.
rem View, или представление, - это то место, где находиться <логика> работы приложения. 
rem Оно запросит информацию из модели, которую мы создали ранее, и передаст её в шаблон.
rem Представления похожи на методы в Python.

rem Динамически изменяющиеся данные в шаблонах.
rem Необходимо отобразить записи в шаблоне HTML-страницы.
rem Для этого нужны представления: соединять между собой модели и шаблоны.
rem В post_list представлению нужно будет взять модели, которые необходимо отобразить, и передать их шаблону. 
rem В представлениях определяем, что будет отображена в шаблоне.

rem Откроем файл %~1/views.py и добавим представление:
(
echo from django.shortcuts import render
echo from django.utils import timezone
echo from .models import Post
echo.
echo def post_list(request^):
echo 	posts = Post.objects.all(^).order_by('published_date'^)
echo 	return render(request, '%~1/post_list.html', {'posts': posts}^)
) >%~1\views.py
rem Функция (def) с именем post_list, которая принимает request в качестве аргумента и возвращает (return) результат работы функции render, которая соберёт шаблон страницы %~1/post_list.html.

rem Представление для страницы поста.
rem В файле %~1/urls.py был создан шаблон URL под названием post_detail, который ссылался на представление под названием views.post_detail. 
rem Это значит, что Django ожидает найти функцию-представление с названием post_detail в %~1/views.py.
rem В файл %~1/views.py рядом с другими строками, начинающимися с from добавляем:
ren "%~1\views.py" "views.py.bak"
echo from django.shortcuts import render, get_object_or_404 >%~1\views.py
type "%~1\views.py.bak" >>%~1\views.py
del "%~1\views.py.bak"
rem В конец же файла добавляем новое представление:
(
echo.
echo def post_detail(request, pk^):
echo 	post = get_object_or_404(Post, pk=pk^)
echo 	return render(request, '%~1/post_detail.html', {'post': post}^)
) >>%~1\views.py

git add "%~1/views.py"
if defined is_commit (git commit -m"%~2")

endlocal
exit /B 0




:MapUrls
echo #14 MapUrls
setlocal

rem Создаем URL-адрес:
rem Необходимо, чтобы 'http://127.0.0.1:8000/' возвращал домашнюю страничку блога со списком записей в нём.
rem Файл %~1/urls.py (на локальном компьютере) должен выглядеть следующим образом:
(
echo from django.conf.urls import include, url
echo from django.contrib import admin
echo.
echo urlpatterns = [
echo 	url(r'^^admin/', admin.site.urls^),
echo 	url(r'', include('%~3.urls'^)^),
echo ]
) >%~1\urls.py
rem Django теперь будет перенаправлять все запросы 'http://127.0.0.1:8000/' к %~3.urls и искать там дальнейшие инструкции.

git add "%~1/urls.py"
if defined is_commit (git commit -m"%~2")

rem Создаем новый пустой файл %~3/urls.py и добавляем в него следующие строки:
(
echo from django.conf.urls import url
echo from . import views
echo.
echo urlpatterns = [ url(r'^^$', views.post_list, name='post_list'^), ]
) >%~3\urls.py
rem Импортируем функцию url Django и все views (представления) из приложения %~3 и связываем view под именем post_list с URL-адресом ^$.
rem Последняя часть name='post_list' - это имя URL, которое будет использовано, чтобы идентифицировать его.
rem Оно может быть таким же, как имя представления (view).

rem Создадим URL для страницы поста:
rem Создадим URL в файле %~3/urls.py и укажем Django на представление под названием post_detail, которое будет отображать пост целиком.
rem Добавим строчку url(r'^post/(?P<pk>\d+)/$', views.post_detail, name='post_detail'),
(
echo from django.conf.urls import url
echo from . import views
echo.
echo urlpatterns = [
echo 	url(r'^^$', views.post_list, name='post_list'^),
echo 	url(r'^^post/(?P^<pk^>\d+^)/$', views.post_detail, name='post_detail'^),
echo ]
) >%~3\urls.py

git add "%~3/urls.py"
if defined is_commit (git commit -m"%~4")

endlocal
exit /B 0
