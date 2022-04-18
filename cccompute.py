#------------------------------------------------------------------------------------------
# Pre-compute cert-checker KPI for faster display
# JL Dupont
#------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------
# Imports
#------------------------------------------------------------------------------------------
import sys
from db_common import f_connectdb


#------------------------------------------------------------------------------------------
# Constant
#------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------
# functions
#------------------------------------------------------------------------------------------
def f_daterisk(id, nbdays):
    query = "update site set daterisk = %s where sslsite_id = %s "
    g_cursor.execute(query, (nbdays, id, ))


#------------------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------------------

#-- DB init
g_mydb = f_connectdb()
g_cursor = g_mydb.cursor(buffered=True)

# Get the first certificate that's about to expire
query = """ WITH dateval AS
            (SELECT sslsite_id, expiration, ROW_NUMBER() OVER (PARTITION BY sslsite_id ORDER BY expiration) row_num FROM sitecert WHERE expiration > NOW())
            SELECT 
            sslsite_id, DATEDIFF(expiration, NOW()) AS nbdays
            FROM dateval
            WHERE row_num = 1
        """
g_cursor.execute(query)
mylist = g_cursor.fetchall()
for myitem in mylist:
    f_daterisk(myitem[0], myitem[1])

# Get the oldest certificate that has expired
query = """ WITH dateval AS
            (SELECT sslsite_id, expiration, ROW_NUMBER() OVER (PARTITION BY sslsite_id ORDER BY expiration) row_num FROM sitecert WHERE expiration < NOW())
            SELECT 
            sslsite_id, DATEDIFF(expiration, NOW()) AS nbdays
            FROM dateval
            WHERE row_num = 1
        """
g_cursor.execute(query)
mylist = g_cursor.fetchall()
for myitem in mylist:
    f_daterisk(myitem[0], myitem[1])


# End of file
