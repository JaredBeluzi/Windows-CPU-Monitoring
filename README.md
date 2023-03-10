--------------------------------
------------- Goal -------------
--------------------------------

Fill logging.csv with data about CPU usage for a shared Server.
The data includes
- logging date
- logging time
- CPU usage in percent

This data can then be used to create any dashboard you like.

--------------------------------
--------- How to use? ----------
--------------------------------

- copy whole folder to machine, where you want to monitor the RAM usage
- install python on that machine
- install pandas package in Python (e.g. in cmd: "py -m pip install pandas")
- add a task in task scheduler on Windows that starts the START.bat in the downloaded folder at the morning, e.g. at 06:00
- let the Server do its thing and wait at least 2 days. Then there should be a logging_hist.csv in this folder, that you can use however you want


--------------------------------
------ How does it work? -------
--------------------------------

1. START.bat

Started via Task Scheduler (Aufgabenplanung) every day in the morning at 06:00.
Starts logging.bat.

2. logging.bat

Retrieves CPU usage every 5 seconds and writes it into logging.csv.
Runs until 20:00. After that process stops and data_transformation.py starts.

3. data_transformation.py

Loads logging.csv in python, corrects some mistakes in the data and aggregates them to save disk space.
Aggregated data is added to logging_hist.csv.

--------------------------------
--- How does the data look? ----
--------------------------------

If you want to take a look at what the data looks like, take a look at the jupyter notebook files, that I included.
To use them I recommend installing Jupyter Notebooks beforehand. You can also look at it by installing some jupyter extension in you IDE of choice.
