# MOD_CSRFPROTECTOR  - Apache 2.2.x module for mitigating CSRF vulnerabilities
#                        In web applications
# Required packages: httpd-devel gcc gcc-c++ make openssl-devel
clear
APACHE_VER=2.2.2
echo "Building for apache version $APACHE_VER"
echo "BUILD INIT...."
echo "Initiating MOD_CSRFPROTECTOR BUILD PROCESS"
sudo apxs -cia -n csrf_protector ./src/mod_csrfprotector.c ./src/sqlite/sqlite3.c -lssl -lcrypto
echo "BUILD FINISHED ...!"
echo "Restarting APACHE ...!"

echo "---------------------------------------------------"
echo "Appending default configurations to /etc/httpd/conf.d/csrf_protector.conf"
echo "" >> /etc/httpd/conf.d/csrf_protector.conf
echo "#Configuration for CSRFProtector" >> /etc/httpd/conf.d/csrf_protector.conf
echo "<IfModule mod_csrfprotector.c>" >> /etc/httpd/conf.d/csrf_protector.conf
echo "    csrfpEnable on" >> /etc/httpd/conf.d/csrf_protector.conf
echo "    csrfpAction forbidden" >> /etc/httpd/conf.d/csrf_protector.conf
#echo "    errorRedirectionUri \"\"" >> /etc/apache2/mods-enabled/csrf_protector.load
echo "    errorCustomMessage \"<h2>Access forbidden</h2>\"" >> /etc/httpd/conf.d/csrf_protector.conf
echo "    jsFilePath http://localhost/csrfp_js/csrfprotector.js" >> /etc/httpd/conf.d/csrf_protector.conf
echo "    tokenLength 20" >> /etc/httpd/conf.d/csrf_protector.conf
#echo "    disablesJsMessage \"\"" >> /etc/apache2/mods-enabled/csrf_protector.load
echo "    verifyGetFor .*:\/\/localhost\/csrfp_test/delete.*" >> /etc/httpd/conf.d/csrf_protector.conf
echo "    verifyGetFor .*:\/\/localhost\/csrfp_custom/.*" >> /etc/httpd/conf.d/csrf_protector.conf
echo "</IfModule>" >> /etc/httpd/conf.d/csrf_protector.conf

echo "Configuration write finished"
echo "---------------------------------------------------"

sudo service httpd restart
echo "mod_csrfprotector has been compiled, installed and activated"











