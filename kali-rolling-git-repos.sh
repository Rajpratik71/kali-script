## Repositories

## Install prerequisite for GIT tools
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}prerequisite${RESET} for all tools"
apt -y -qq install git windows-binaries nmap unicornscan php-cli gcc ruby-dev libpcap-dev openvpn freerdp-x11 vncviewer \
  || echo -e ' '${RED}'[!] Issue with apt install'${RESET} 1>&2


##### Install UACScript
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}UACScript${RESET} ~ UAC Bypass for Windows 7"
git clone -q -b master https://github.com/Vozzie/uacscript.git /opt/uacscript-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/uacscript-git/ >/dev/null
git pull -q
popd >/dev/null
ln -sf /usr/share/windows-binaries/uac-win7 /opt/uacscript-git/


##### Install MiniReverse_Shell_With_Parameters
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}MiniReverse_Shell_With_Parameters${RESET} ~ Generate shellcode for a reverse shell"
git clone -q -b master https://github.com/xillwillx/MiniReverse_Shell_With_Parameters.git /opt/minireverse-shell-with-parameters-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/minireverse-shell-with-parameters-git/ >/dev/null
git pull -q
popd >/dev/null
ln -sf /usr/share/windows-binaries/MiniReverse /opt/minireverse-shell-with-parameters-git/


##### Install onetwopunch
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}onetwopunch${RESET} ~ unicornscan & nmap wrapper"
git clone -q -b master https://github.com/superkojiman/onetwopunch.git /opt/onetwopunch-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/onetwopunch-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/onetwopunch-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/onetwopunch-git/ && bash onetwopunch.sh "\$@"
EOF
chmod +x "${file}"


##### Install Gnmap-Parser (fork)
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}Gnmap-Parser (fork)${RESET} ~ Parse Nmap exports into various plain-text formats"
git clone -q -b master https://github.com/nullmode/gnmap-parser.git /opt/gnmap-parser-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/gnmap-parser-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
chmod +x /opt/gnmap-parser-git/gnmap-parser.sh
mkdir -p /usr/local/bin/
ln -sf /opt/gnmap-parser-git/gnmap-parser.sh /usr/local/bin/gnmap-parser-git


##### Install azazel
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}azazel${RESET} ~ Linux userland rootkit"
git clone -q -b master https://github.com/chokepoint/azazel.git /opt/azazel-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/azazel-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install Babadook
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}Babadook${RESET} ~ connection-less powershell backdoor"
git clone -q -b master https://github.com/jseidl/Babadook.git /opt/babadook-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/babadook-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install pupy
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}pupy${RESET} ~ Remote Administration Tool"
git clone -q -b master https://github.com/n1nj4sec/pupy.git /opt/pupy-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/pupy-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install reGeorg
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}reGeorg${RESET} ~ pivot via web shells"
git clone -q -b master https://github.com/sensepost/reGeorg.git /opt/regeorg-git \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/regeorg-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Link to others
apt -y -qq install webshells \
  || echo -e ' '${RED}'[!] Issue with apt install'${RESET} 1>&2
ln -sf /opt/reGeorg-git /usr/share/webshells/reGeorg


##### Install b374k (https://bugs.kali.org/view.php?id=1097)
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}b374k${RESET} ~ (PHP) web shell"
git clone -q -b master https://github.com/b374k/b374k.git /opt/b374k-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/b374k-git/ >/dev/null
git pull -q
php index.php -o b374k.php -s
popd >/dev/null
#--- Link to others
apt -y -qq install webshells \
  || echo -e ' '${RED}'[!] Issue with apt install'${RESET} 1>&2
ln -sf /opt/b374k-git /usr/share/webshells/php/b374k


##### Install adminer
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}adminer${RESET} ~ Database management in a single PHP file"
git clone -q -b master https://github.com/vrana/adminer.git /opt/adminer-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/adminer-git/ >/dev/null
git pull -q
php compile.php 2>/dev/null
popd >/dev/null
#--- Link to others
apt -y -qq install webshells \
  || echo -e ' '${RED}'[!] Issue with apt install'${RESET} 1>&2
file=$(find /opt/adminer-git/ -name adminer-*.php -type f -print -quit)
ln -sf "${file}" /usr/share/webshells/php/adminer.php


##### Install cmdsql
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}cmdsql${RESET} ~ (ASPX) web shell"
git clone -q -b master https://github.com/NetSPI/cmdsql.git /opt/cmdsql-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/cmdsql-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Link to others
apt -y -qq install webshells \
  || echo -e ' '${RED}'[!] Issue with apt install'${RESET} 1>&2
ln -sf /opt/cmdsql-git /usr/share/webshells/aspx/cmdsql


##### Install python-pty-shells
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}python-pty-shells${RESET} ~ PTY shells"
git clone -q -b master https://github.com/infodox/python-pty-shells.git /opt/python-pty-shells-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/python-pty-shells-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install WPA2-HalfHandshake-Crack
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}WPA2-HalfHandshake-Crack${RESET} ~ Rogue AP for handshakes without a AP"
git clone -q -b master https://github.com/dxa4481/WPA2-HalfHandshake-Crack.git /opt/wpa2-halfhandshake-crack-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/wpa2-halfhandshake-crack-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install HT-WPS-Breaker
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}HT-WPS-Breaker${RESET} ~ Auto WPS tool"
git clone -q -b master https://github.com/SilentGhostX/HT-WPS-Breaker.git /opt/ht-wps-breaker-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/ht-wps-breaker-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install dot11decrypt
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}dot11decrypt${RESET} ~ On-the-fly WEP/WPA2 decrypter"
git clone -q -b master https://github.com/mfontanini/dot11decrypt.git /opt/dot11decrypt-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/dot11decrypt-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install wifiphisher
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}wifiphisher${RESET} ~ Automated Wi-Fi phishing"
git clone -q -b master https://github.com/sophron/wifiphisher.git /opt/wifiphisher-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/wifiphisher-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/wifiphisher-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/wifiphisher-git/ && python wifiphisher.py "\$@"
EOF
chmod +x "${file}"


##### Install hostapd-wpe-extended
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}hostapd-wpe-extended${RESET} ~ Rogue AP for WPA-Enterprise"
git clone -q -b master https://github.com/NerdyProjects/hostapd-wpe-extended.git /opt/hostapd-wpe-extended-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/hostapd-wpe-extended-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install proxychains-ng (https://bugs.kali.org/view.php?id=2037)
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}proxychains-ng${RESET} ~ Proxifier"
git clone -q -b master https://github.com/rofl0r/proxychains-ng.git /opt/proxychains-ng-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/proxychains-ng-git/ >/dev/null
git pull -q
make -s clean
./configure --prefix=/usr --sysconfdir=/etc >/dev/null
make -s 2>/dev/null && make -s install   # bad, but it gives errors which might be confusing (still builds)
popd >/dev/null
#--- Add to path (with a 'better' name)
mkdir -p /usr/local/bin/
ln -sf /usr/bin/proxychains4 /usr/local/bin/proxychains-ng


##### Install pfi
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}pfi${RESET} ~ Port Forwarding Interceptor"
git clone -q -b master https://github.com/s7ephen/pfi.git /opt/pfi-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/pfi-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install icmpsh
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}icmpsh${RESET} ~ Reverse ICMP shell"
git clone -q -b master https://github.com/inquisb/icmpsh.git /opt/icmpsh-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/icmpsh-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install dnsftp
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}dnsftp${RESET} ~ Transfer files over DNS"
git clone -q -b master https://github.com/breenmachine/dnsftp.git /opt/dnsftp-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/dnsftp-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install BetterCap
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}BetterCap${RESET} ~ MITM framework"
git clone -q -b master https://github.com/evilsocket/bettercap.git /opt/bettercap-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/bettercap-git/ >/dev/null
git pull -q
gem build bettercap.gemspec
gem install bettercap*.gem
popd >/dev/null


##### Install Babel scripts
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}Babel scripts${RESET} ~ post exploitation scripts"
git clone -q -b master https://github.com/attackdebris/babel-sf.git /opt/babel-sf-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/babel-sf-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install shellconv
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}shellconv${RESET} ~ shellcode disassembler"
git clone -q -b master https://github.com/hasherezade/shellconv.git /opt/shellconv-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/shellconv-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/shellconv-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/shellconv-git/ && python shellconv.py "\$@"
EOF
chmod +x "${file}"


##### Install smbspider
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}smbspider${RESET} ~ search network shares"
git clone -q -b master https://github.com/T-S-A/smbspider.git /opt/smbspider-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/smbspider-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install CrackMapExec
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}CrackMapExec${RESET} ~ Swiss army knife for Windows environments"
git clone --recursive -q -b master https://github.com/byt3bl33d3r/CrackMapExec.git /opt/crackmapexec-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/crackmapexec-git/ >/dev/null
git pull -q
python -W ignore setup.py install >/dev/null
popd >/dev/null


##### Install credcrack
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}credcrack${RESET} ~ credential harvester via Samba"
git clone -q -b master https://github.com/gojhonny/CredCrack.git /opt/credcrack-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/credcrack-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install Empire
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}Empire${RESET} ~ PowerShell post-exploitation"
git clone -q -b master https://github.com/PowerShellEmpire/Empire.git /opt/empire-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/empire-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install wig (https://bugs.kali.org/view.php?id=1932)
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}wig${RESET} ~ web application detection"
git clone -q -b master https://github.com/jekyc/wig.git /opt/wig-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/wig-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/wig-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/wig-git/ && python wig.py "\$@"
EOF
chmod +x "${file}"


##### Install droopescan
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}DroopeScan${RESET} ~ Drupal vulnerability scanner"
git clone -q -b master https://github.com/droope/droopescan.git /opt/droopescan-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/droopescan-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/droopescan-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/droopescan-git/ && python droopescan "\$@"
EOF
chmod +x "${file}"


##### Install patator (GIT)
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}patator${RESET} (GIT) ~ brute force"
git clone -q -b master https://github.com/lanjelot/patator.git /opt/patator-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/patator-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/patator-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/patator-git/ && python patator.py "\$@"
EOF
chmod +x "${file}"


##### Install crowbar
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}crowbar${RESET} ~ brute force"
git clone -q -b master https://github.com/galkan/crowbar.git /opt/crowbar-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/crowbar-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/crowbar-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/crowbar-git/ && python crowbar.py "\$@"
EOF
chmod +x "${file}"


##### Install ashttp
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}ashttp${RESET} ~ terminal via the web"
git clone -q -b master https://github.com/JulienPalard/ashttp.git /opt/ashttp-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/ashttp-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install gotty
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}gotty${RESET} ~ terminal via the web"
git clone -q -b master https://github.com/yudai/gotty.git /opt/gotty-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/gotty-git/ >/dev/null
git pull -q
popd >/dev/null


##### Install CMSmap
(( STAGE++ )); echo -e "\n\n ${GREEN}[+]${RESET} (${STAGE}/${TOTAL}) Installing ${GREEN}CMSmap${RESET} ~ CMS detection"
git clone -q -b master https://github.com/Dionach/CMSmap.git /opt/cmsmap-git/ \
  || echo -e ' '${RED}'[!] Issue when git cloning'${RESET} 1>&2
pushd /opt/cmsmap-git/ >/dev/null
git pull -q
popd >/dev/null
#--- Add to path
mkdir -p /usr/local/bin/
file=/usr/local/bin/cmsmap-git
cat <<EOF > "${file}" \
  || echo -e ' '${RED}'[!] Issue with writing file'${RESET} 1>&2
#!/bin/bash

cd /opt/cmsmap-git/ && python cmsmap.py "\$@"
EOF
chmod +x "${file}"