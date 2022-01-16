import streamlit as st
import pandas as pd
from xgboost import XGBRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error
import pandas as pd
import streamlit as st
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_absolute_error
from sklearn.ensemble import GradientBoostingRegressor
df = pd.read_csv('/Users/Roman/Downloads/housing.csv')
if st.button('Отобразить первые пять строк'):
    st.write(df.head(5))
if st.button('Обучить модель'):
    X_train, X_test, y_train, y_test = train_test_split(df.drop('MEDV', axis=1),
                                                        df['MEDV'],
                                                        test_size=0.2,
                                                        random_state=2100)
    st.write('Разделили данные и передали в обучение')
    regr_model = XGBRegressor()
    regr_model.fit(X_train, y_train)
    pred = regr_model.predict(X_test)
    st.write('Обучили модель, MAE = ' + str(mean_absolute_error(y_test, pred)))

if st.selectbox(
     'Какой размер test выборки?',
     ('10', '15', '20', '25', '30', '35')):
     st.write(pd.DataFrame({
        'y_test',
        'pred'}))