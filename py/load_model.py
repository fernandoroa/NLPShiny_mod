#import pandas as pd

# python3 load_model.py clf_NBC.pkl count_vect.pkl my_ser.csv outfile

import sys
import os
import pickle
import pandas as pd
import numpy as np

# print(model)
# print(os.getcwd())

model = sys.argv[1]
count = sys.argv[2]
series = sys.argv[3]
out_file = sys.argv[4]

# model="clf_NBC.pkl"
# count="couint_vect.pkl"
# series="my_ser.csv"
# series="X_test_NBC.csv"

def read_pickle_file(file):
  pickled_model = pickle.load(open(file, 'rb'))
  return pickled_model

clf_model  = read_pickle_file(model)
count_vect = read_pickle_file(count)
# clf_model = read_pickle_file("clf_NBC.pkl")
# count_vect = read_pickle_file("count_vect.pkl")

series = pd.read_csv(series, index_col = 0, squeeze = True)#header = None,
# series = pd.read_csv('my_ser.csv', index_col = 0, squeeze = True)#header = None,

def predict():
    return clf_model.predict(count_vect.transform(series)) 

array = predict()

# np.savetxt("foo.csv", array, delimiter=",")
with open(out_file, "w") as txt_file:
    for line in array:
        txt_file.write("".join(line) + "\n") 

# import pandas as pd
# 
# def read_pickle_file(file):
#     pickle_data = pd.read_pickle(file)
#     return pickle_data
# And then my R file looked like:
# 
# require("reticulate")
# 
# source_python("pickle_reader.py")
# pickle_data <- read_pickle_file("C:/tsa/dataset.pickle")
