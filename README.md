# certchecker
Fed up with expired SSLs that block systems?<br>
I wanted a system that warns me when a cert is about to expire. Or that tells me when some certs are at risk (e.g. weak encryption or algo). It provides a web site + an alerting by email.<br>
<br>
The solution is a bit rough around the edges. 
1. There is NO installation script. Read the installation documentation at the bottom of this document. Contact me jl(.)dupont[@]gmail(.)com if you're stuck.
2. There is NO user management. It's open source. Feel free to add it ;)

Main page. Gives you a global status of your sites using SSL.
![image](https://user-images.githubusercontent.com/103344686/175818325-e0a95d46-338e-4088-874c-f16da7b14d0d.png)

Certificate setting page. Define what you believe are acceptable SSL/TLS protocoles and Cyphers. 
![image](https://user-images.githubusercontent.com/103344686/175818377-568a1d1d-247b-4cf9-9e54-0da6bbde4dd9.png)

Add/Remove sites
![image](https://user-images.githubusercontent.com/103344686/175818450-94e965ec-4287-49f7-87c6-6659a2e44e95.png)

Email report example
![image](https://user-images.githubusercontent.com/103344686/175818571-987c6de1-4e8e-4b4f-85a3-ed8f3064ddb5.png)


------------------------------------------------
- How to install
------------------------------------------------
Runs on Linux. Developped on Ubuntu 20.0

Must have:
- Python 3
- MySQL
- PHP
- Smarty (https://www.smarty.net/quick_install)
- SSLyse (https://nabla-c0d3.github.io/sslyze/documentation/installation.html) 
- An authenticating mail server listening on TCP/465


1. Get the source of the solution: https://github.com/jeanlucdupont/certchecker.git
3. Database
- Connect to your mysql console (Must have enough right to create a DB).
- Do 'source certchecker.sql' from your mysql console.
4. Web server
- Copy www subdir to /var/www/html/certchecker
- Modify your Apache configuration accordingly
- Edit /var/www/html/certchecker/connect_db.php and put the right login/password/IP
- Try the web server. 
- Add sites (e.g.  192.168.1.2, www.abcdefghuj.com:1088, omg.org ). No http/https prefix.
- Add an email address in email settings
5. Scripts
- Edit db_common.py and put the right login/password/IP
- Edit mailer.py and change the values for C_USER, C_PWD and C_SMTPSERVER
- Run certchecker.py and look for error. If you miss a module, add it with pip3
- Run mailer.py and look for error. If you miss a module, add it with pip3
- Schedule certchecker.py and mailer.py to run daily (cron, or cron.daily). Make sure mailer.py is ran after certchecker.py

