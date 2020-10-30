import numpy as np                          #die notwendigen Bibliotheken werden geladen
import tensorflow as tf
from keras.models import Sequential
from keras.layers import Dense,Activation,Flatten,Dropout
from keras.layers import Conv2D,MaxPooling2D
from sklearn.model_selection import train_test_split

training_data = np.load("version4.0/training_data.npy") #die Trainingsbilder werden geladen
training_labels = np.load("version4.0/training_labels.npy") #die Trainingslabel werden geladen

model=Sequential() #erstellt Model für Schichten mit einem Input und einem Output-Tensor

model.add(Conv2D(200, (3,3), input_shape = training_data.shape[1:], activation = "relu")) #erste "convolutional" Schicht des Netzes mit Activierungsfunktion "relu"
model.add(MaxPooling2D(pool_size = (2,2)))

model.add(Conv2D(100, (3,3), activation = "relu")) #zweite "convolutional" Schicht des Netzes mit Activierungsfunktion "relu"
model.add(MaxPooling2D(pool_size = (2,2)))

model.add(Flatten()) #macht aus 2D-Netz ein 1D-Netz

model.add(Dropout(0.5)) #vermeidet "overfitting"

model.add(Dense(50, activation = "relu")) #dichte Schicht aus 50 Neuronen mit Aktivierungsfunktion "relu"

model.add(Dense(2, activation = "softmax")) #letzte Schicht mit zwei Ausgabeneuronen für "masked" und "not_masked" und Aktivierungsfunktion "softmax"

model.compile(loss = "categorical_crossentropy" , optimizer= "adam", metrics=["accuracy"]) #Parameter für das Trainieren des Netzes werden festgelegt

training_data, test_data, training_labels , test_labels = train_test_split(training_data, training_labels, test_size = 0.1) #von Trainingsdaten werden 10% Testdaten abgespalten 

model.fit(training_data, training_labels, epochs = 10, validation_split = 0.15, batch_size = 35) #Model trainiert mit Trainingsdaten in 10 Epochen und wird durch "validation_split" evaluiert

model.save("version4.0/KIM_4.model") #trainiertes Model wird gespeichert

print(model.evaluate(test_data, test_labels)) #Model wird mit Testdaten evaluiert

#val-accuracy 0.9847
