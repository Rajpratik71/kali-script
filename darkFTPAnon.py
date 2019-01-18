#!/usr/bin/python
# This was written for educational purpose and pentest only. Use it at your own risk.
# Author will be not responsible for any damage!
# !!! Special greetz for my friend sinner_01 !!!
# Toolname        : darkFTPAnon.py
# Coder           : baltazar a.k.a b4ltazar < b4ltazar@gmail.com>
# Version         : 0.1
# greetz for all members of ex darkc0de.com, ljuska.org 

import sys, subprocess, socket, random
from ftplib import FTP

timeout = 0.5
socket.setdefaulttimeout(timeout)
PORT = int(21)

def logo():
  print "\n|---------------------------------------------------------------|"
  print "| b4ltazar[@]gmail[dot]com                                      |"
  print "|   12/2012     darkFTPAnon.py    v.0.1                         |"
  print "|    b4ltazar.us                                                |"
  print "|                                                               |"
  print "|---------------------------------------------------------------|\n"
  
if sys.platform == 'linux' or sys.platform == 'linux2':
    subprocess.call("clear", shell=True)
    logo()
else:
    subprocess.call("cls", shell=True)
    logo()
    
if len(sys.argv) not in [3,4]:
    print "[!] Usage: python darkFTPAnon.py -random NUM"
    print "[!] Example: python darkFTPAnon.py -random 10000"
    print "[!] Usage: python darkFTPAnon.py -iprange RANGE"
    print "[!] Example: python darkFTPAnon.py -iprange 192.168.1.1-255"
    print "[!] Please visit b4ltazar.us"
    print "[!] Thx for using this script, now exiting!"
    sys.exit(1)
    
def randomIP():
    ran1 = random.randrange(255) + 1
    ran2 = random.randrange(255) + 1
    ran3 = random.randrange(255) + 1
    ran4 = random.randrange(255) + 1
    randIP = "%d.%d.%d.%d" % (ran1, ran2, ran3, ran4)
    return randIP

def getrange(iprange): 
    lst = [] 
    iplist = [] 
    iprange = iprange.rsplit(".",2) 
    if len(iprange[1].split("-",1)) ==2: 
            for i in range(int(iprange[1].split("-",1)[0]),int(iprange[1].split("-",1)[1])+1,1): 
                    lst.append(iprange[0]+"."+str(i)+".") 
            for ip in lst: 
                    for i in range(int(iprange[2].split("-",1)[0]),int(iprange[2].split("-",1)[1])+1,1): 
                            iplist.append(ip+str(i)) 
            return iplist 
    if len(iprange[1].split("-",1)) ==1: 
            for i in range(int(iprange[2].split("-",1)[0]),int(iprange[2].split("-",1)[1])+1,1): 
                    iplist.append(iprange[0]+"."+str(iprange[1].split("-",1)[0])+"."+str(i)) 
            return iplist
        
def srvscan(ip):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((ip, PORT))
        s.close()
        if PORT == 21:
            print "\n[+] FTP open port found", ip
            print "[+] Checking for Anonymous!"
            ftpanon(ip)
    except(KeyboardInterrupt, SystemExit):
        sys.exit(1)
    
    except:
        pass
    
def ftpanon(ip):
    try:
        ftp = FTP(ip)
        login = ftp.login()
        if login:
            print "[!] Anonymous login successfuly on %s" % ip

    except(KeyboardInterrupt, SystemExit):
        sys.exit(1)
    except:
        pass
    
for arg in sys.argv[1:]:
    if arg.lower() == "-iprange":
        iprange = sys.argv[int(sys.argv[1:].index(arg))+2]
    if arg.lower() == "-random":
        number = sys.argv[int(sys.argv[1:].index(arg))+2]
        
try:
    if iprange:
        iplist = getrange(iprange)
        print "[!] Range Loaded:", iprange
except(NameError):
    iprange = 0
    pass
except(IndexError):
    print "[-] Misconfigured IPRANGE"
    sys.exit(1)
    
try:
    if number:
        print "[!] There is %s random IP for scan" % number
        number = int(number)
except(NameError):
    number = 0
    pass

if __name__ == "__main__":
    print "[!] Port for checking: %s" % str(PORT)
    print "[!] Let's start ..."
    
    if iprange != 0:
        for ip in iplist:
            srvscan(ip)
    if random != 0:
        while number >= 0:
            srvscan(randomIP())
            number -= 1
            
    print "\n[!] Scanning finished!"
    print "[!] Please visi b4ltazar.us"
    sys.exit(1)



