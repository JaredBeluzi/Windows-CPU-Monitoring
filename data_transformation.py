import pandas as pd


# 1. Import data
# load logging.csv into a pandas dataframe with Microsoft cmd encoding and no header
df = pd.read_csv('logging.csv', encoding='cp852', header=None)
# name columns
df.columns = ['logging_date',
              'logging_time',
              'CPU_usage_percent']

# 2. Data transformation
# remove last 2 characters from date
df['logging_date'] = df['logging_date'].str[:-2]
# remove rows where CPU usage is " " (empty)
df = df[df['CPU_usage_percent'] != ' ']
# cast CPU usage to integer
df['CPU_usage_percent'] = df['CPU_usage_percent'].astype(int)

# 3 grouping data
# group by process and user
df_grouped = df.groupby(['logging_date',
                         'logging_time']).mean()

# 4. Export data
# check if file exists
try:
    # if file exists, append data to existing csv file with ansi encoding
    df_grouped.to_csv('logging_hist.csv', mode='a', encoding='utf-8', header=False)
except FileNotFoundError:
    # if file does not exist, create file and write data to it
    df_grouped.to_csv('logging_hist.csv', mode='w', encoding='utf-8', header=True)

