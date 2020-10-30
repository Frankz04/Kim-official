import numpy as np  #die notwendigen Bibliotheken werden geladen
import cv2
import os
from tensorflow.keras.utils import to_categorical

DATADIR = "version4.0/KIM_dataset_4" #eine Variable wird, mit dem Verzeichnis in dem die Bilder des Datensets sind, initialisiert
CATEGORIES = ["masked", "not_masked"]  #eine Liste mit den Strings "masked" und "not_masked wird erzeugt"
labels = [i for i in range(len(CATEGORIES))] #es werden zwei Label mit 0 und 1 erstellt

label_dict = dict(zip(CATEGORIES ,labels)) #es wird ein Verzeichnis mit 0 und "masked" oder 1 und "not_masked" erzeugt

IMG_SIZE = 80 #eine Variable mit der Seitenlänge der Bilder wird festgelegt

training_data = [] #eine Liste für die späteren Trainingsbilder wird erstellt   
training_labels = [] #eine Liste für die späteren Trainingslabel wird erstellt


for category in CATEGORIES: #für category in Liste CATEGORIES
    path = os.path.join(DATADIR, category) #Variable path = "version4.0/KIM_dataset_4/masked" oder "version4.0/KIM_dataset_4/not_masked"
    for name in os.listdir(path):   #für jeden Dateiname in path 
        img = cv2.imread(os.path.join(path, name), cv2.IMREAD_GRAYSCALE)  #Dateiname wird geöffnet und als Graustufenbild in Variable img gespeichert       
        resized_img = cv2.resize(img,(IMG_SIZE, IMG_SIZE)) #img (Graustufenbild) wird auf einheitliche Größe von 80x80 Pixeln geschrumpft oder gestreckt
        training_data.append(resized_img) #das fertige Bild wird der Trainingsbilderliste angefügt
        training_labels.append(label_dict[category]) #category wird in "masked" und 0 oder "not_masked" und 1 transferiert und dann der Trainingslabelliste angefügt 

training_data = np.array(training_data) / 255.0 #Trainingsbilderliste wird als numpy-array durch 255.0 geteilt
training_data = np.array(training_data).reshape(-1, IMG_SIZE, IMG_SIZE, 1)  #die Form der Trainingsbildliste wird für das Model vorbereitet

training_labels = np.array(training_labels) #Trainingslabelliste wird zu numpy-array 
training_labels = to_categorical(training_labels) #ändert zweidimensionalen Vector in binäre Matrix

np.save("version4.0/training_data", training_data) #speichert Trainingsbilder als np.array
np.save("version4.0/training_labels", training_labels) #speichert Trainingslabel als np.array
