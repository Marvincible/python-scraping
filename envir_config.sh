#!/bin/bash
#A python virtual environment can be created for a purpose of this project.
#For python >= 3.3 use venv command to create isolated from your file system environmet:
python3 -m venv /path/to/new/virtual/environment 

#If you have installed multiple versions of python on your system you can state precisly which one you want to install
#in a venw, for exampe: 

python3.4 -m venv /path/to/new/virtual/environment 

#Activate the venv

source /path/to/new/virtual/environment/bin/activate

#Before lounching python interpreter, install project-required packages using pip3 program
#(pip3 will install packages from the Python Package Index).

pip3 install requests # a requests library is an interface beetwen python interpreter and web servers
pip3 install beautifulsoup4 # a beautifulsoup4 library is used for a structured data parsing

#Now lounch a python within your activated venv:
python
