#!/usr/bin/env python
# coding: utf-8

# ## Nubank AE Case - Parse JSON investment file
# 
# **This notebook aims to:**
# 
# * Iterate file rows to parse JSON columns;
# * Generate the CSV file to write the table [dbo].[raw_investments] in Azure SQL database.

# ### Imports

# In[1]:


import pandas as pd
import json


# ### Paths and Files name

# In[2]:


file_path = "D:/MyFolder/Nubank/Case/Tables/investments/"

file_name_read = "investments_json.txt"
file_path_read = file_path+file_name_read

file_name_write = "investments.csv"
file_path_write = file_path+file_name_write


# ### Parse JSON file

# In[3]:


# Opening JSON file

f = open(file_path_read)
 
# returns JSON object as
# a dictionary
data = json.load(f)
 
##Closing file
f.close()

d = []

for i in data:
    for j in i['transactions']:
        d.append({
            'account_id':i['account_id'],
            'transaction_id':j['transaction_id'],
            'status':j['status'],
            'amount':j['amount'],
            'investment_requested_at':j['investment_requested_at'],
            'investment_completed_at':j['investment_completed_at'],
            'investment_completed_at_timestamp':j['investment_completed_at_timestamp'],
            'type':j['type'] 
        })

df = pd.DataFrame(d)


# ### Preview

# In[4]:


df.head()


# ### Write CSV file

# In[5]:


df.to_csv(file_path_write, index=False)

