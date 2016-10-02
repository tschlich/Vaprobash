#!/usr/bin/env bash

# Download TYPO3 Source and unpack it
echo ">>> downloading typo3 sources"
cd /opt/
wget get.typo3.org/7 --content-disposition
tar -xzf typo3_src-7.6.*

# php.ini config for TYPO3 7
echo ">>> modifying php.ini"
always_populate_raw_post_data=-1
xdebug.max_nesting_level=400
max_input_vars=1500
max_execution_time=240
upload_max_filesize=10M
post_max_size=10M
for key in always_populate_raw_post_data xdebug.max_nesting_level max_input_vars max_execution_time upload_max_filesize post_max_size 
do
  sudo sed -i "s/^\($key\).*/\1 $(eval echo = \${$key})/" /etc/php5/apache2/php.ini
done

# restarting apache
echo ">>> restarting apache"
apache2ctl restart

echo "+------------------------------------------------------------------------------+"
echo "| Sources downloaded and unpacked - go to your webroot and set the symlinks    |"
echo "+------------------------------------------------------------------------------+"
echo "| $ cd /vagrant/www/htdocs/                                                    |"
echo "| $ ln -s /opt/typo3_src-7.6.x typo3_src                                       |"
echo "| $ ln -s typo3_src/index.php                                                  |"
echo "| $ ln -s typo3_src/typo3                                                      |"
echo "| # In case you use Apache, copy the .htaccess to your Document Root:          |"
echo "| $ cp typo3_src/_.htaccess .htaccess                                          |"
echo "+------------------------------------------------------------------------------+"
