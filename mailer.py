#------------------------------------------------------------------------------------------
# Mass mailer
# JL Dupont
#------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------
# Imports
#------------------------------------------------------------------------------------------
import json
import sys
import os
import smtplib
from email.mime.base        import MIMEBase
from email                  import encoders
from email.mime.multipart   import MIMEMultipart
from datetime               import date
from db_common              import f_connectdb
from email.mime.text        import MIMEText
from email.mime.base        import MIMEBase


#------------------------------------------------------------------------------------------
# Constant
#------------------------------------------------------------------------------------------
C_DISPLAY               = "Cert-Checker"
C_USER                  = 'XXX'
C_PWD                   = "XXX"
C_SMTPSERVER            = "XXX"
C_SMTPPORT              = 465


#------------------------------------------------------------------------------------------
# functions
#------------------------------------------------------------------------------------------
def f_readfile(filename):
    htmlfile = open(filename, "r")
    return htmlfile.read()
    
def f_email(useraddress, mailtitle):

    print("Email to: " + useraddress)
     
    
    #-- MIME format email + add pictures
    msg                 = MIMEMultipart('related')
    msg['Subject']      = mailtitle 
    msg['From']         = C_DISPLAY + " <" + C_USER + ">"
    msg['To']           = useraddress
    part2               = MIMEText(g_mailcontent, 'html')
    msg.attach(part2)
    
    #--  Send email
    try:
        server          = smtplib.SMTP_SSL(C_SMTPSERVER, C_SMTPPORT)
        server.ehlo()
        server.login(C_USER, C_PWD)
        server.sendmail(C_USER, useraddress, msg.as_string())
        server.close()    
        print('  Sent.')    
    except Exception as e:
        print('  [E] Cannot send email.')
        print("  " + e)    


def f_addsection(title, mylist):
    if len(mylist) == 0:
        return ""
    html = "<table>"
    html += "<tr><th>&nbsp;" + title + "&nbsp;</th></tr>\n"
    for item in mylist:
        html += "<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + item[0] + "</td></tr>\n"
    html += "</table><br>\n"
    return html

def f_summary(title, value):
    tcolor = "#179537" if value == 0 else "DC3545"
    return "<font color=\"" + tcolor + "\">" + str(value) + " " + title + "</font> "


#------------------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------------------

print ("-- " + os.path.basename(__file__) + " --")


#-- DB init
g_mydb = f_connectdb()
g_cursor = g_mydb.cursor(buffered=True)

# Big SQL query
query = "SELECT site_id, daterisk, address, sslrisk, cypherrisk, failcount FROM site order by site.site_id"
g_cursor.execute(query)
itemlist        = g_cursor.fetchall()
g_nbfail            = 0
g_arrayfail         = []
g_nbexpired         = 0
g_arrayexpired      = []
g_nbabout           = 0
g_arrayabout        = []
g_nbsslrisk         = 0
g_arraysslrisk      = []
g_nbcypherrisk      = 0
g_arraycypherrisk   = []
for item in itemlist:
    if item[1] < 0:
        g_nbexpired += 1
        g_arrayexpired.append([item[2],item[1]])
    elif item[1] < 31:
        g_nbabout += 1            
        g_arrayabout.append([item[2],item[1]])
    if item[3] != 0:
        g_nbsslrisk += 1
        g_arraysslrisk.append([item[2],item[3]])
    if item[4] != 0:
        g_nbcypherrisk += 1
        g_arraycypherrisk.append([item[2],item[4]])
    if item[5] != 0:
        g_nbfail += 1
        g_arrayfail.append([item[2],item[5]])

# Create mail content    
g_mailcontent = f_readfile("mheader.html")
g_mailcontent += f_summary("failed", g_nbfail) + "/ "
g_mailcontent += f_summary("expired", g_nbexpired) + "/ "
g_mailcontent += f_summary("expiring soon", g_nbabout) + "/ "
g_mailcontent += f_summary("weak SSL", g_nbsslrisk) + "/ "
g_mailcontent += f_summary("weak encryption", g_nbcypherrisk) + "<br><br>"
g_mailcontent += f_addsection("Failed connections", g_arrayfail)
g_mailcontent += f_addsection("Expired certificates", g_arrayexpired)
g_mailcontent += f_addsection("Certificates expiring soon", g_arrayabout)
g_mailcontent += f_addsection("Certificates with weak SSL protocols", g_arraysslrisk)
g_mailcontent += f_addsection("Certificates with weak encryption", g_arraycypherrisk)
g_mailcontent += "<br><br>"
g_mailcontent += f_readfile("mfooter.html")
g_mailtitle = date.today().strftime("%Y-%m-%d") + " " + str(g_nbfail) + "/" + str(g_nbexpired) + "/" + str(g_nbabout) + "/" + str(g_nbsslrisk) + "/" + str(g_nbcypherrisk)


# Send email
query = "select address from recipient"
g_cursor.execute(query)
mylist = g_cursor.fetchall()
for myitem in mylist:
    f_email(myitem[0], g_mailtitle)

#------------------------------------------------------------------------------------------
# End
#------------------------------------------------------------------------------------------
