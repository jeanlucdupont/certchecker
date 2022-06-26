#------------------------------------------------------------------------------------------
# DB connection. Not to be published
#------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------
# Imports
#------------------------------------------------------------------------------------------
import mysql.connector

#------------------------------------------------------------------------------------------
# Constant
#------------------------------------------------------------------------------------------
C_DBHOST = "127.0.0.1"
C_DBUSER = "xxx"
C_DBPWD = "xxx"
C_DBNAME = "certchecker"

def f_connectdb():
    """ connect to the DB """
    return(mysql.connector.connect(host=C_DBHOST,  user=C_DBUSER,  passwd=C_DBPWD,  database=C_DBNAME, auth_plugin='mysql_native_password', allow_local_infile=True,autocommit=True))

