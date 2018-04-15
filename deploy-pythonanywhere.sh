#!/bin/bash
#set -x  # echo on


# Настройка блога на PythonAnywhere. 
# Загружаем код на PythonAnywhere.

# После регистрации на PythonAnywhere на странице «Consoles» выбераем опцию старта консоли «Bash» 
# — это версия консоли PythonAnywhere, аналогичная локальному терминалу.

# Загружаем код из GitHub на PythonAnywhere, создав «клон» репозитория.
# Введим команду в консоли на PythonAnywhere:
git clone https://github.com/YOUR_LOGIN_NAME_HERE/YOUR_REPO_HERE.git
# Команда загружает копию кода с GitHub на PythonAnywhere.
# Проверяем это, набрав:
tree YOUR_REPO_HERE

# По аналогии с локальной версией создаем виртуальное окружение на PythonAnywhere:
cd YOUR_REPO_HERE
virtualenv --python=python3.6 myvenv
source myvenv/bin/activate

# pip install django~=1.11.0
pip install -r requirements.txt

# Создаём базу данных на PythonAnywhere.
# Одно отличие локального компьютера и сервера — они используют разные базы данных. 
# Таким образом, пользовательские аккаунты и записи в блоге на сервере и локальном компьютере могут отличаться друг от друга. 
# Необходимо инициализировать базу данных— с помощью команд migrate и createsuperuser:
python manage.py migrate
python manage.py createsuperuser --username=YOUR_LOGIN_NAME_HERE --email=YOUR_EMAIL_HERE
# YOUR_PASSWORD_HERE

# Публикация нашего блога как веб-приложения.
# Возвращаемся в панель управления PythonAnywhere, нажав на лого в верхнем левом углу, 
# затем переключаемся на вкладку Web и нажимаем кнопку Add a new web app.
# После подтверждения доменного имени выбераем Manual configuration (не «Django»!) в диалоговом окне.
# Затем выбираем Python 3.6 и завершаем работу мастера.

# Настройка виртуального окружения.
# На странице настройки приложения в секции "Virtualenv" кликаем по красному тексту "Enter the path to a virtualenv" 
# и набираем /home/<your-username>/YOUR_REPO_HERE/myvenv/.
# Нажимаем на синий прямоугольник с галочкой, чтобы сохранить изменения, прежде чем двигаться дальше.

# Настройка файла WSGI.
# Django использует протокол WSGI, стандартный протокол для обслуживания веб-сайтов, использующих Python, который поддерживается PythonAnywhere. 
# Используя файл настроек WSGI, мы позволим PythonAnywhere распознать наш Django блог.
# Кликаем по ссылке "WSGI configuration file"
# (в секции «Code» наверху страницы — она будет выглядеть следующим образом: /var/www/<your-username>_pythonanywhere_com_wsgi.py)
# Удаляем все содержимое и заменяем его на:

# import os
# import sys
#
# path = os.path.expanduser('~/my-blog-django')
# if path not in sys.path:
# 	sys.path.append(path)
#
# os.environ['DJANGO_SETTINGS_MODULE'] = 'myproject.settings'
#
# from django.core.wsgi import get_wsgi_application
# from django.contrib.staticfiles.handlers import StaticFilesHandler
# application = StaticFilesHandler(get_wsgi_application())

# Задача данного файла — сказать PythonAnywhere, где находится наше веб-приложение и как называется файл настроек Django.
# StaticFilesHandler нужен для обработки наших CSS.
# Она происходит автоматически во время разработки при запуске runserver.
# Нажмаем Save и переключаемся на вкладку Web.
