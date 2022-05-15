#!/usr/bin/env python
# coding: utf-8

# ## Nubank AE Case - Investment daily return calc
# 
# **This notebook aims to:**
# 
# * Create variables with accumulated balance added to the interest and daily return;
# * Generate the CSV file to write the table [dbo].[raw_investments_daily_returns] in Azure SQL database.
# 
# The calculation is performed with the view [dbo].[curated_fact_investments_fill_daily_gaps_2020] previously created in the database.

# ### Imports

# In[1]:


from datetime import datetime
import pandas as pd
from sqlalchemy import create_engine


# ### Set database connection

# In[2]:


server = 'tcp:myserver-marcelogrande.database.windows.net'
database = 'MyDatabase'
username = 'marcelogrande'
password = 'admin_1234'
str_con = 'Driver={SQL Server};Server='+server+',1433;Database='+database+';Uid='+username+';Pwd='+password
str_con_az = 'mssql+pyodbc:///?odbc_connect={}'.format(str_con)
engine_azure = create_engine(str_con_az, echo=True)


# ### Read table

# In[3]:


query = 'select * from dbo.curated_fact_investments_fill_daily_gaps_2020'
df = pd.read_sql(query, con=engine_azure)


# ### Acumulating daily balance with income  and return daily amount

# In[4]:


previous_value = 0

for i, row in df.iterrows():
    if row['rownumber_account'] == 1 and row['investment_balance_amount'] < 0 :
        df.at[i,'run_total_investment_with_return'] = row['investment_balance_amount']
        df.at[i,'daily_return'] = 0
        previous_value = row['investment_balance_amount']
        
    elif  row['rownumber_account'] == 1 and row['investment_balance_amount'] >= 0 :
        df.at[i,'run_total_investment_with_return'] = row['investment_balance_amount']*(1+row['daily_rate'])
        df.at[i,'daily_return'] = row['investment_balance_amount']*row['daily_rate']
        previous_value = row['investment_balance_amount']*(1+row['daily_rate'])
        
    elif row['rownumber_account'] > 1 and (row['investment_balance_amount'] + previous_value) < 0 :
        df.at[i,'run_total_investment_with_return'] = row['investment_balance_amount'] + previous_value
        df.at[i,'daily_return'] = 0
        previous_value = (row['investment_balance_amount'] + previous_value)
        
    else :
        df.at[i,'run_total_investment_with_return'] = (previous_value + row['investment_balance_amount'])*(1+row['daily_rate'])
        df.at[i,'daily_return'] = ((previous_value + row['investment_balance_amount'])*row['daily_rate'])
        previous_value = ((previous_value + row['investment_balance_amount'])*(1+row['daily_rate']))
        
df['run_total_investment_with_return'] = df['run_total_investment_with_return'].round(8)
df['daily_return'] = df['daily_return'].round(8)  


# ### Create unique key with account_id and action_date

# In[5]:


df['key'] = df['account_id']+'-'+df['action_date']


# ### Preview

# In[6]:


df.head()


# ### Write csv file

# In[7]:


file_path = "D:/MyFolder/Nubank/Case/Tables/investments/"
file_name_write = "investments_returns.csv"
file_path_write = file_path+file_name_write

df.to_csv(file_path_write, index=False)

