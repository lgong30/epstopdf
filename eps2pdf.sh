#!/bin/bash

# EPS2PDF script for Ubuntu (and Mac)
# This script automatically convert all eps in the current directory (including its children)
# into PDF. If dependent software was not installed, it will automatically download and install
# them.
# Long Gong (gonglong.gatech@gmail.com)

set -e 
# Get directory containing source code
CURRENT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"
SUBFIX="eps-converted-to.pdf"
# Search all eps files
EPS_FILES=$( find $CURRENT_DIR -name "*.eps")

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    INSTALL='sudo apt-get install -y'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    INSTALL='brew install'
else
    echo "Your OS is not supported"
    exit
fi

# Check whether epstopdf is installed
if which epstopdf >/dev/null; then
    EPSTOPDF='epstopdf'
else 
    echo "Cannot find epstopdf, trying to grab it from Internet"
    wget http://mirrors.ctan.org/support/epstopdf/epstopdf.pl
    if ! which perl >/dev/null; then
        echo "Cannot find perl on your Mac, trying to install it"
        $INSTALL perl
    fi
    EPSTOPDF='./epstopdf.pl'
fi

for eps_file in $EPS_FILES
do
    file_path=`dirname $eps_file`
    file_name=`basename $eps_file`
    name=`echo $file_name | sed -e 's/\.[^.]*$//'`    
    new_name=`echo "$file_path/$name-$SUBFIX"`
    echo "Converting $eps_file to $new_name"
    $EPSTOPDF --outfile $new_name $eps_file
done