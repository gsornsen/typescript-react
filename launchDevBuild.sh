#! /bin/bash

####################################
# Launch the development build
####################################

# Check to see if we have the npm and chromium-browser dependencies.
# If not, we'll install them.

# npm dependency
if ! which npm > /dev/null; then
    echo "npm not found, installing..."
    sudo apt install npm -y
else
    echo "npm package found!"
fi

# chromium browser dependency
if ! which chromium-browser > /dev/null; then
    echo "chromium-browser not found, installing..."
    sudo apt install chromium-browser -y
else
    echo "chromium-browser package found!"
fi

# Make sure the proper node modules for the project are installed.
# If not, we'll install them.
cd $PWD/app
if [ -d "node_modules" ]; then
    echo "node modules found! starting..."
    BROWSER=none npm start &
else
    echo "no modules not found, installing and starting!"
    npm install && BROWSER=none npm start &
fi

# Launch chromium-browser in kiosk mode
chromium-browser http://localhost:3000 --kiosk --disable-infobars \
--no-first-run --fast-start --fast --disable-features=TranslateUI
