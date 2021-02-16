# FLATCAM

## Installation

Use Linux. Otherwise it's too manual: 

```
# clone project and use beta branch
git clone https://bitbucket.org/jpcgt/flatcam.git
cd flatcam
git checkout Beta
# install dependencies and create/enter virtualenv
sudo apt-get install libgdal-dev
virtualenv -p /usr/bin/python3.6 venv
source venv/bin/activate
# install GDAL dependency (a messy one)
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
gdal-config --version # get version of ddal
pyp3 install GDAL=2.2.3 # the version should match the above one
# install all the rest of the dependencies
pip3 install -r requirements.txt
# launch flatcam
python3 FlatCam.py
# deactivate the virtualenv
deactivate
```
