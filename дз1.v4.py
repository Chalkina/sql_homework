import pandas as pd
vacancy=pd.read_csv('/Users/Roman/Desktop/vacancy.csv')
vacancy.vactitle.str.lower().str.contains('аналитик данных')
vacancy.groupby('vacdate')['vacid'].count()
vacancy[vacancy.vactitle.str.contains('python'))

vacancy.vactitle.value_count('аналитик')
vacancy.vacdescription.str.lower().str.contains('Python')
vacancy[vacancy['vactitle'].str.contains(r"Дизайнер")]
vacancy[vacancy['vactitle'].str.contains(r"Старший специалист")]
vacancy[vacancy['vactitle'].str.contains(r'Python')

