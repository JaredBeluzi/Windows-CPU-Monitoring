<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#what-does-it-do">What does it do?</a></li>
    <li><a href="#how-to-use">How to use</a></li>
    <li><a href="#how-does-it-work">How does it work?</a></li>
      <ul>
        <li><a href="#STARTbat">START.bat</a></li>
        <li><a href="#loggingbat">logging.bat</a></li>
        <li><a href="#data_transformationpy">data_transformation.py</a></li>
      </ul>
    <li><a href="#how-can-i-test-the-program">How can I test the program?</a></li>
      <ul>
        <li><a href="#testing-the-batch-files">Testing the batch files</a></li>
        <li><a href="#testing-the-python-file">Testing the python file</a></li>
      </ul>
  </ol>
</details>  

# What does it do?

**Example result:**

![alt text](https://github.com/JaredBeluzi/Windows-CPU-Monitoring/blob/main/logging_hist.png?raw=true)

The program creates a logging_hist.csv as above with data about the CPU usage of a Windows PC.
The data shown in the picture above shows from left to right:
- logging date (German Format)
- logging time
- CPU usage in percent

This data can then be used to create any dashboard you like.

# How to use

1. Copy the whole folder to the machine, where you want to monitor the CPU usage.
2. Install python on that machine (I used python 3.11.1)
3. Install the pandas package in Python (in cmd you can type:
```batch
python -m pip install pandas
```
4. Add a task in the task scheduler on Windows that starts the START.bat in the downloaded folder each day in the morning, e.g. at 06:00 
(please check the box in the task scheduler that starts the script even if you are not logged in on that machine!)
5. Let the Server do its thing and wait at least 2 days. Then there should be a logging_hist.csv in this folder like the one in the picture above.


# How does it work?

### START.bat

- should be started via Task Scheduler every day in the morning, e.g. at 06:00.
- starts logging.bat

### logging.bat

- retrieves CPU usage in percent every 5 seconds
- runs until 20:00
- process stops and data_transformation.py starts

### data_transformation.py

- loads logging.csv into a pandas dataframe
- corrects some mistakes in the data
- aggregates CPU usage of every minute as mean (This saves space)
- aggregated data is added to a logging_hist.csv

# How can I test the program?

### Testing the batch files

1. Copy the whole folder to the machine, where you want to monitor the RAM usage.
2. Double click the START.bat
This should open a cmd and create a logging.csv in the folder.
You can click inside the cmd and stop the program:
- click `CTRL + c`
- This shows a message like "Stop the process (Y/N)"
- Here you can type `y` and click enter
- Then close the cmd window
If you open the logging.csv, you should see something similar this:

![alt text](https://github.com/JaredBeluzi/Windows-CPU-Monitoring/blob/main/logging.png?raw=true)

### Testing the python file

1. First test the batch files (you need to create a logging.csv to test the python script)
2. Run data_transformation.py
To do this you can run the file in your IDE of choice or you can open a cmd and type
```batch
python data_transformation.py
```
Wait until the script finishes. If everything went well, there should be a logging_hist.csv in the folder that looks like this:
![alt text](https://github.com/JaredBeluzi/Windows-CPU-Monitoring/blob/main/logging_hist.png?raw=true)

If it did not work or the logging_hist.csv looks wrong, you can go through the python code step by step by going through the Jupyter file "data_transformation_test.ipynb" I included. I recommend you install Jupyter Notebooks before doing this and open the notebook (data_transformation_test.ipynb) in Jupyter. Here you can execute and debug each cell of code by clicking `Shift + Enter`.
