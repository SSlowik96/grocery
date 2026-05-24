# %%
import pandas as pd

# %%
df=pd.read_csv(r'C:\Users\Szymon\Desktop\projekty\grocery\csv\sales.csv')

# %%
df.head(5)  

# %%
df.info()

# %%
# Remove 'T' first, then convert to datetime
df['SalesDate'] = df['SalesDate'].str.replace('T', ' ')
df['SalesDate'] = pd.to_datetime(df['SalesDate'])

# %%
df.info()

# %%
df.describe()

# %%
df = df.drop('TotalPrice', axis=1) # Remove TotalPrice column beacause of NULL values

# %%
df.head()

# %%
df = df.drop_duplicates() # Remove duplicates

# %%
df.info()

# %%
df = df[df['Quantity'] >= 0] # Remove rows with negative Quantity

# %%
df.describe()

# %%
df = df.dropna(subset=['SalesID', 'SalesDate']) # Remove rows with NULL values in SalesID and SalesDate

# %%
df.info()

# %%
df.head()

# %%
df.to_csv('clean_sales.csv', index=False)


