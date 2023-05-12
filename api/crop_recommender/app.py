import numpy as np
from fastapi import FastAPI , Request
from pydantic import BaseModel 
import uvicorn
from fastapi.responses import JSONResponse
from tensorflow import keras
import pandas as pd
from sklearn.preprocessing import LabelEncoder 


app = FastAPI()

data = pd.read_csv('dataset/Crop_recommendation.csv')

le = LabelEncoder()
le.fit(data.label)
data['label'] = le.transform(data.label)

label_mapping = dict(zip(le.classes_, le.transform(le.classes_)))
model = keras.models.load_model('Crop_Model.h5')


def get_crop_name(val):
  for key, value in label_mapping.items():
    if value == val:
      return key
    
def prediction(x):
  y_pred = model.predict(x)
  predicted = np.argmax(y_pred)
  print(get_crop_name(predicted))
  return get_crop_name(predicted)


class ListItems(BaseModel):
    nitrogen: float
    phosphorus: float
    potassium: float
    temperature: float
    humidity: float
    ph: float
    rainfall: float

    

@app.get('/')
def index():
    return ("Hello World")

@app.post('/predict')
def predict(data1: ListItems): 
    data = dict(data1)
    nitrogen = data['nitrogen']
    print(nitrogen)
    phosphorus = data['phosphorus']
    potassium = data['potassium']
    temperature = data['temperature']
    humidity  = data['humidity']
    ph = data['ph']
    rainfall = data['rainfall']
    predict_arr = np.array([
        [nitrogen,phosphorus,potassium,temperature,humidity,ph,rainfall]
    ])
    predRes = prediction(predict_arr)
    print(predRes)
    return {'prediction': predRes}

@app.exception_handler(ValueError)
async def value_error_exception_handler(request: Request, exc: ValueError):
    return JSONResponse(
        status_code=400,
        content={"message": str(exc)},
    )

if __name__ == "__main__":
    uvicorn.run(app)
