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
    query = "update site set daterisk = %s where site_id = %s "
    g_cursor.execute(query, (nbdays, id, ))


def f_sslsum(id):
    query = "select heartbleed, cssinjection, renegodos from site where site_id = %s "
    g_cursor.execute(query, (id, ))
    row = g_cursor.fetchone()
    return row[0] + row[1] + row[2]


def f_sslrisk(id):
    query = "update site set sslrisk = %s where site_id = %s "
    g_cursor.execute(query, (f_sslsum(id), id, ))

def f_sslriskalgo(id):
    query = "update site set sslrisk = sslrisk + %s where site_id = %s "
    g_cursor.execute(query, (f_countbadssl(id), id, ))

def f_cypherrisk(id):
    query = "update site set cypherrisk = %s where site_id = %s "
    g_cursor.execute(query, (f_countbadcypher(id), id, ))


def f_countbadssl(id):
    query = "SELECT sitessl.sslsuite_id FROM sitessl, sslsuite WHERE sitessl.site_id = %s AND sitessl.sslsuite_id = sslsuite.sslsuite_id AND sslsuite.ok = 0 group by sitessl.sslsuite_id"
    g_cursor.execute(query, (id, ))
    return g_cursor.rowcount


def f_countbadcypher(id):
    query = "SELECT * FROM sitessl, cyphersuite WHERE sitessl.site_id = %s AND sitessl.cyphersuite_id = cyphersuite.cyphersuite_id AND cyphersuite.ok = 0"
    g_cursor.execute(query, (id, ))
    return g_cursor.rowcount



#------------------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------------------

#-- DB init
g_mydb = f_connectdb()
g_cursor = g_mydb.cursor(buffered=True)

# Get the first certificate that's will expire
query = """ WITH dateval AS
            (SELECT site_id, expiration, ROW_NUMBER() OVER (PARTITION BY site_id ORDER BY expiration) row_num FROM sitecert WHERE expiration > NOW())
            SELECT 
            site_id, DATEDIFF(expiration, NOW()) AS nbdays
            FROM dateval
            WHERE row_num = 1
        """
g_cursor.execute(query)
mylist = g_cursor.fetchall()
for myitem in mylist:
    f_daterisk(myitem[0], myitem[1])

# Get the oldest certificate that has expired
query = """ WITH dateval AS
            (SELECT site_id, expiration, ROW_NUMBER() OVER (PARTITION BY site_id ORDER BY expiration) row_num FROM sitecert WHERE expiration < NOW())
            SELECT 
            site_id, DATEDIFF(expiration, NOW()) AS nbdays
            FROM dateval
            WHERE row_num = 1
        """
g_cursor.execute(query)
mylist = g_cursor.fetchall()
for myitem in mylist:
    f_daterisk(myitem[0], myitem[1])

# ssl risk count
query = "select site_id from site where failcount = 0"
g_cursor.execute(query)
mylist = g_cursor.fetchall()
for myitem in mylist:
    f_sslrisk(myitem[0])
    f_sslriskalgo(myitem[0])
    f_cypherrisk(myitem[0])



# End of file
