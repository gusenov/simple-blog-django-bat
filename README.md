# Django

Django - это высокоуровневая веб-инфраструктура Python, которая позволяет быстро создавать безопасные и поддерживаемые веб-сайты.

Django (джанго) — бесплатный и свободный фреймворк для веб-приложений, написанный на Python.

Фреймворк — это набор компонентов, которые помогают разрабатывать веб-сайты быстро и просто.

Django используют такие крупные сайты, как Disqus, Instagram, Knight Foundation, MacArthur Foundation, Mozilla, National Geographic, Open Knowledge Foundation, Pinterest и Open Stack.

# Что происходит, когда кто-то запрашивает веб-сайт у сервера?

Когда на сервер приходит запрос, он переадресуется Django, который пытается сообразить, что же конкретно от него просят. 

Для начала он берет адрес веб-страницы и пробует понять — что же нужно сделать. 

Эту часть процесса в Django выполняет urlresolver (адрес веб-сайта называется URL — Uniform Resource Locator — Единый указатель ресурсов, так что название urlresolver, resolver == определитель, имеет определенный смысл).

Он берет список шаблонов и пытается сопоставить их с URL.

Django сверяет шаблоны сверху вниз и, если что-то совпадает, он переправляет запрос соответствующей функции (которая называется view).




# Схема взаимодействия

![Схема взаимодействия](%D1%81%D1%85%D0%B5%D0%BC%D0%B0-%D0%B2%D0%B7%D0%B0%D0%B8%D0%BC%D0%BE%D0%B4%D0%B5%D0%B9%D1%81%D1%82%D0%B2%D0%B8%D1%8F.png)




# Django. Элементы.

**urls.py** URL-mapper используется для перенаправления HTTP-запросов в соответствующее представление на основе URL-адреса запроса. 
URL-mapper также может извлекать данные из URL-адреса в соответствии с заданным шаблоном и передавать их в соответствующую функцию в виде аргументов.

**view**: Представление (view) – это функция обработчика запросов, которая получает HTTP-запросы и возвращает ответы. 
View имеет доступ к данным через модели (необходимым для удовлетворения запросов и делегирования ответа в шаблоны).

**Models**: Модели представляют собой объекты Python, которые определяют структуру данных приложения и предоставляют механизмы для управления (добавления, изменения, удаления) и выполнения запросов в базу данных.

**HTML Templates**: Template (шаблон) – это текстовый файл определяющий структуру или разметку страницы (например HTML страницы), с полями для подстановки используемыми для представления актуального содержимого.




# Links

- [Django - avoiding typing password for superuser | code @ informatikaMihelac](http://source.mihelac.org/2009/10/23/django-avoiding-typing-password-for-superuser/)


- [Памятка по virtualenv и изолированным проектам на Python | Записки программиста](https://eax.me/python-virtualenv/)
- [windows - A python script that activates the virtualenv and then runs another python script? - Stack Overflow](https://stackoverflow.com/a/47422656/2289640)


- [Call - Windows CMD - SS64.com](https://ss64.com/nt/call.html)
- [How can I use a batch file to write to a text file? - Stack Overflow](https://stackoverflow.com/a/29635767/2289640)
- [Batch files - Escape Characters](http://www.robvanderwoude.com/escapechars.php)
- [windows - How to echo a message with a colon in it? - Stack Overflow](https://stackoverflow.com/a/45985974/2289640)
- [Echo a blank (empty) line to the console from a Windows batch file - Stack Overflow](https://stackoverflow.com/a/20691061/2289640)
- [Command Redirection, Pipes - Windows CMD - SS64.com](https://ss64.com/nt/syntax-redirection.html)
- [How to launch Internet Explorer from the command prompt? - Super User](https://superuser.com/a/113348)
- [Batch file to delete files with .bak extension - Stack Overflow](https://stackoverflow.com/a/22871724/2289640)


- [Русский текст в консоли - Batch (CMD/BAT) - Киберфорум](http://www.cyberforum.ru/cmd-bat/thread738351.html)
- [Использование UTF-8 в cmd.exe: anvarichn](https://anvarichn.livejournal.com/43752.html)
- [I18N: Unicode at the Windows command prompt (C++; .Net; Java)](http://illegalargumentexception.blogspot.com/2009/04/i18n-unicode-at-windows-command-prompt.html)


- [How can you find and replace text in a file using the Windows command-line environment? - Stack Overflow](https://stackoverflow.com/a/60055/2289640)
- [What characters do I need to escape when using sed in a sh script? - Unix &amp; Linux Stack Exchange](https://unix.stackexchange.com/a/33005/40014)
- [Sed creates un-deleteable files in Windows - Stack Overflow](https://stackoverflow.com/a/29975064/2289640)
- [shell - sed command creates randomly named files - Stack Overflow](https://stackoverflow.com/a/7734075/2289640)


- [Windows batch file file download from a URL - Stack Overflow](https://stackoverflow.com/a/14342976/2289640)
