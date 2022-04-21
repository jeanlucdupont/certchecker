# certchecker
Fed up with expired SSLs that block systems.<br>
I wanted a system that warns me when a cert is about to expire. Or that tells me when some certs are at risk (e.g. weak encryption, self-signed, ...)<br>
<br>
Three steps:<br>
1: Make a python proggy that parses SSLYZE outputs and update a DB<br>
2: Make a web interface.<br>
3: Make a scheduler do send alerts and reports<br>
<br>
2022 04 14 Step #1 is done. Python<br>
2022 04 20 Working on step #2. Main page interface is done.

![image](https://user-images.githubusercontent.com/103344686/164353503-052ba92f-fda0-4e5e-a8ec-dfa0728ebe2c.png)


