#------------------------------------------------------------------------------------------
# Run SSLYZE on target, parson JSON, import into DB.
# JL Dupont
#------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------
# Imports
#------------------------------------------------------------------------------------------
import json
import sys
import os
from db_common import f_connectdb


#------------------------------------------------------------------------------------------
# Constant
#------------------------------------------------------------------------------------------
C_SSLYZE = "/usr/local/bin/sslyze"
C_SSLYZEJSON = "sslyze.json"


#------------------------------------------------------------------------------------------
# functions
#------------------------------------------------------------------------------------------
def f_siteadd(fqdn):
    query = "SELECT sslsite_id from site where `address` = %s"
    g_cursor.execute(query, (fqdn, ))
    if g_cursor.rowcount == 0:
        query = "insert into site (`address`) values (%s)"
        g_cursor.execute(query, (fqdn, ))
        return g_cursor.lastrowid
    else:
        row = g_cursor.fetchone()
        return row[0]

def f_siteupdate(siteid, myvar, myval):
    if myval == "True":
        myval = 1
    if myval == "False":
        myval = 0
    if myval == "+1":
        query = "update site set failcount = failcount + 1 where `sslsite_id` = %s"
        g_cursor.execute(query, (siteid, ))
        return
    if myval == "now":
        query = "update site set " + myvar + " = now() where `sslsite_id` = %s"
        g_cursor.execute(query, (siteid, ))
        return
    query = "update site set " + myvar + " = %s where `sslsite_id` = %s"
    g_cursor.execute(query, (myval, siteid, ))

def f_sitecertinit(siteid):
    query = "update sitecert set alive = 0 where `sslsite_id` = %s"
    g_cursor.execute(query, (siteid,))


def f_sitecertadd(siteid, serial):
    query = "SELECT sslsite_id, serial from sitecert where `sslsite_id` = %s and `serial` = %s"
    g_cursor.execute(query, (siteid, serial,))
    if g_cursor.rowcount == 0:
        query = "insert into sitecert (`sslsite_id`, `serial`) values (%s, %s)"
        g_cursor.execute(query, (siteid, serial,))

def f_sitecertupdate(siteid, serial, myvar, myval):        
    query = "update sitecert set " + myvar + " = %s, updatets = now(0) where `sslsite_id` = %s and `serial` = %s "
    g_cursor.execute(query, (myval, siteid, serial,))

def f_getsslsuiteid(suitename):
    query = "SELECT sslsuite_id from sslsuite where `sslsuite_name` = %s"
    g_cursor.execute(query, (suitename, ))
    row = g_cursor.fetchone()
    return row[0]

def f_sitesslinit(siteid):
    query = "update sitessl set alive = 0 where `sslsite_id` = %s"
    g_cursor.execute(query, (siteid,))

def f_sitessladd(siteid, suitename, cyphername):
    query = "SELECT sslsitesuite_id from sitessl where `sslsite_id` = %s and `sslsuite_id` = %s and `cyphersuite_id` = %s "
    g_cursor.execute(query, (siteid, f_getsslsuiteid(suitename), f_cypheradd(cyphername),))
    if g_cursor.rowcount == 0:
        query = "insert into sitessl (`sslsite_id`, `sslsuite_id`, `cyphersuite_id`) values (%s, %s, %s)"
        g_cursor.execute(query, (siteid, f_getsslsuiteid(suitename), f_cypheradd(cyphername),))
        return g_cursor.lastrowid
    else:
        row = g_cursor.fetchone()
        return row[0]

def f_sitesslupdate(sitesslid, myvar, myval):
    if myval == "True":
        myval = 1
    if myval == "False":
        myval = 0
    query = "update sitessl set " + myvar + " = %s, updatets = now(0) where `sslsitesuite_id` = %s "
    g_cursor.execute(query, (myval, sitesslid,))
    
def f_cypheradd(cyphername):
    query = "SELECT cyphersuite_id from cyphersuite where `cypher_name` = %s "
    g_cursor.execute(query, (cyphername, ))
    if g_cursor.rowcount == 0:
        query = "insert into cyphersuite (`cypher_name`, `ok`) values (%s, 0)"
        g_cursor.execute(query, (cyphername, ))
        return g_cursor.lastrowid
    else:
        row = g_cursor.fetchone()
        return row[0]
    
def f_cypherenum(cypherlist, sslsuite, supported, accepted):
    if supported == True:
        supported = 1
    else:
        supported = 0
    for cypher in cypherlist:
        sitesslid = f_sitessladd(g_siteid, sslsuite, cypher['cipher_suite']['name'])
        f_sitesslupdate(sitesslid, "alive", 1)
        f_sitesslupdate(sitesslid, "supported", supported)
        f_sitesslupdate(sitesslid, "keysize", cypher['cipher_suite']['key_size'])
        f_sitesslupdate(sitesslid, "cyphersuite_id", f_cypheradd(cypher['cipher_suite']['name']))        
        f_sitesslupdate(sitesslid, "accepted", accepted)        

def f_sitednsinit(siteid):
    query = "update sitedns set alive = 0 where `sslsite_id` = %s"
    g_cursor.execute(query, (siteid,))

def f_sitednsadd(siteid, dns):
    query = "SELECT sslsite_id from sitedns where `sslsite_id` = %s and `dns` = %s"
    g_cursor.execute(query, (siteid, dns, ))
    if g_cursor.rowcount == 0:
        query = "insert into sitedns (`sslsite_id`, `dns`) values (%s, %s)"
        g_cursor.execute(query, (siteid, dns))
    else:
        query = "update sitedns set updatets = now(0), alive = 1 where `sslsite_id` = %s"
        g_cursor.execute(query, (siteid, ))


#------------------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------------------
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Missing target:port")
        exit()

#-- DB init
g_mydb = f_connectdb()
g_cursor = g_mydb.cursor(buffered=True)

#-- Run SSLYZE 
v_fqdn = sys.argv[1].lower()
os.system(C_SSLYZE + " " + sys.argv[1] + " --json_out " + C_SSLYZEJSON + " > /dev/null 2>&1")

#-- Read JSON
with open(C_SSLYZEJSON, "r") as read_file:
    data = json.load(read_file)

#-- Add/update, site
g_siteid = f_siteadd(v_fqdn)

# Check if scan is completed    
v_completed = data['server_scan_results'][0]['connectivity_status']
if v_completed == "ERROR":
    # Treat error
    f_siteupdate(g_siteid, "failcount", "+1")
    print("Unable to connect")
    exit()


# Update site info
f_siteupdate(g_siteid, "failcount", 0)
f_siteupdate(g_siteid, "successts", "now")
f_siteupdate(g_siteid, "highestssl", data['server_scan_results'][0]['connectivity_result']['highest_tls_version_supported'])
f_siteupdate(g_siteid, "robotresult", data['server_scan_results'][0]['scan_result']['robot']['result']['robot_result'])
f_siteupdate(g_siteid, "heartbleed", data['server_scan_results'][0]['scan_result']['heartbleed']['result']['is_vulnerable_to_heartbleed'])
f_siteupdate(g_siteid, "cssinjection", data['server_scan_results'][0]['scan_result']['openssl_ccs_injection']['result']['is_vulnerable_to_ccs_injection'])
f_siteupdate(g_siteid, "renegodos", data['server_scan_results'][0]['scan_result']['session_renegotiation']['result']['is_vulnerable_to_client_renegotiation_dos'])
f_siteupdate(g_siteid, "secrenego", data['server_scan_results'][0]['scan_result']['session_renegotiation']['result']['supports_secure_renegotiation'])


# Get cert info
f_sitecertinit(g_siteid)
certdata = data['server_scan_results'][0]['scan_result']['certificate_info']['result']['certificate_deployments'][0]['received_certificate_chain']
for mydata in certdata:
    v_serial = mydata['serial_number']
    f_sitecertadd(g_siteid, v_serial)
    f_sitecertupdate(g_siteid, v_serial, "alive", 1)
    f_sitecertupdate(g_siteid, v_serial, "cn", mydata['subject']['rfc4514_string'])
    f_sitecertupdate(g_siteid, v_serial, "algoname", mydata['signature_algorithm_oid']['name'])
    f_sitecertupdate(g_siteid, v_serial, "hashname", mydata['signature_hash_algorithm']['name'])
    f_sitecertupdate(g_siteid, v_serial, "algo", mydata['public_key']['algorithm'])
    f_sitecertupdate(g_siteid, v_serial, "keysize", mydata['public_key']['key_size'])
    f_sitecertupdate(g_siteid, v_serial, "expiration", mydata['not_valid_after'])
    attributedata = mydata['issuer']['attributes']
    for myattributedata in attributedata:
        f_sitecertupdate(g_siteid, v_serial, myattributedata['oid']['name'], myattributedata['value'])


# Check cypher enum for each ssl suite
query = "SELECT sslsuite_name from sslsuite order by sslsuite_id "
g_cursor.execute(query)
ssllist = g_cursor.fetchall()
f_sitesslinit(g_siteid)
for ssl in ssllist:
    f_cypherenum(data['server_scan_results'][0]['scan_result'][ssl[0]]['result']['accepted_cipher_suites'], ssl[0], data['server_scan_results'][0]['scan_result'][ssl[0]]['result']['is_tls_version_supported'], 1)
    #f_cypherenum(data['server_scan_results'][0]['scan_result'][ssl[0]]['result']['rejected_cipher_suites'], ssl[0], data['server_scan_results'][0]['scan_result'][ssl[0]]['result']['is_tls_version_supported'], 0)
    

# Get DNS
f_sitednsinit(g_siteid)
try:
    dnslist = data['server_scan_results'][0]['scan_result']['certificate_info']['result']['certificate_deployments'][0]['path_validation_results'][0]['verified_certificate_chain'][0]['subject_alternative_name']['dns']
    for dns in dnslist:
        f_sitednsadd(g_siteid, dns)
except:
    print("No DNS entry")


# End of file
