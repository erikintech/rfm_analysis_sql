from sqlalchemy import create_engine
import pandas as pd

print('--DATABASE CREDENTIALS--')
username = input('Enter your postgresql username: ')
password = input('Enter database password: ')
host = input('Enter the database host: ')
port = input('Enter the database port: ')
database = input('Enter database name: ')

engine = create_engine( 'postgresql+psycopg2://'+username+':'+password+'@'+host+':'+port+'/'+database)

filename = input('Enter the CSV filename (e.g. data_sample): ')

# read csv file
file = pd.read_csv('./'+filename+'.csv')
file.to_sql(filename, engine, if_exists='replace', index=False)
engine.dispose()