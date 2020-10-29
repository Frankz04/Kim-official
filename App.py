try:
    import os,shutil,threading,cv2,atexit, sys, time
    import numpy as np
    from PySide2.QtCore import QObject, Signal, Slot
    from PySide2.QtGui import QGuiApplication, QIcon
    from PySide2.QtQml import QQmlApplicationEngine
    from PySide2.QtWidgets import QWidget
    import keras

    stopT = False
    os.chdir(os.path.dirname(os.path.realpath(__file__))) #damit faceCascade und Model geladen werden können, wird das working directory auf den Speicherort der .py-Datei festgelegt 
    faceCascade = cv2.CascadeClassifier("haarcascade_frontalface_default.xml") #Gesichtserkennungstool wird initialisiert
    model = keras.models.load_model("KIM_4.model") #vortrainiertes Model wird geladen

    class Person(QObject):
        sendBox = Signal(str) 
        sendBox2 = Signal(str)
        update = Signal()  #diese Signale können an das Frontend (QML) gesendet werden, damit Rechtecke gezeichnet werden
        
        
        def __init__(self):
            QObject.__init__(self)    
            t = threading.Thread(target=self.capture)
            t.daemon = True
            t.start() #Im Hintergrund wird durch den Thread das Video aufgezeichnet, ohne dass der Vordergrund hängt
            
        @Slot()
        def capture(self):
            video_capture = cv2.VideoCapture(0+ cv2.CAP_DSHOW) #Python organisiert sich die Kamera
            prev = 0
            global stopT
            while not stopT: #StopT bleibt False solange Fenster nicht geschlossen wurde
                try: 
                    time_elapsed = time.time() - prev
                    if time_elapsed > 1./15: #Durch das abwarten werden die FPS des Videos auf ca. 15 gesetzt
                        prev = time.time()
                        ret, frame = video_capture.read() #Kamerabild wird ausgelesen
                        
                        try:
                            def t2():
                                try:
                                    cv2.imwrite("frame.jpg",frame) #Das Bild wird abgespeichert, damit QML darauf zugreifen kann
                                    self.update.emit() #Signal wird zu QML geschickt, damit das angezeigt Bild aktualisiert wird, durch 15 Aktualisierungen pro Sek. wirkt es flüssig
                                except: 
                                    pass
                            t1 = threading.Thread(target=t2)
                            t1.daemon = True
                            t1.start() #Der Schnelligkeit halber wird t2() nebenbei ausgeführt
                        except:
                            pass
                        self.detect(frame) #self.detect checkt das Bild (frame) nach Gesichter und dann nach Masken ab
                except:
                    pass

        @Slot(list)
        def detect(self,frame):
            width = 640
            height = 480
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY) #Die Farben des Bildes werden konvertiert
            faces = faceCascade.detectMultiScale(gray,scaleFactor=1.2,minNeighbors=5, minSize=(30, 30)) #Es wird nach Gesichtern gescannt 
            boxes = {"masked": [], "notmasked": []} 
            if len(faces) != 0:
                for (x, y, w, h) in faces: #Die Koordinaten der erkannten Gesichter werden gelesen
                    face =gray[y:y + h, x:x + w] #Das Bild wird auf das Gesicht beschränkt
                    face = [cv2.resize(face,(80,80))] #Der Bildauschnitt wird auf eine einheitliche Größe gebracht
                    face = np.array(face).reshape(-1,80,80,1)/255.0 #Wird in numpy Array umgewandelt und durch 255 geteilt, um die Wahrscheinlichkeit für die Predictions zu bekommen
                    prediction = model.predict(face) #Die KI schaut, ob das Gesicht maskiert/nichtmaskiert ist
                    if prediction[0][0]<0.9:
                        boxes["notmasked"].append([x/width,y/height,w/width,h/height])
                    else:
                        boxes["masked"].append([x/width,y/height,w/width,h/height])
                        
            self.sendBox.emit(str(boxes["notmasked"])) 
            self.sendBox2.emit(str(boxes["masked"]))
            #Die Gesichtskoordinaten werden jeweils für masked und für notmasked gesendet


    def stop(): 
        global stopT
        stopT = True

    atexit.register(stop) #Wenn der das Fenster geschlossen wird, wird durch stopT == True die while-Schleife beendet
    person = Person() 

    app = QGuiApplication(sys.argv)
    app.setApplicationDisplayName("KIM")

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("person", person)
    app.setWindowIcon(QIcon("mask.ico"))

    engine.load("main.qml")

    #Das in der main.qml abgespeicherte Fenster wird geladen und dargestellt, dabei wird auch die Klasse Person übergeben
    sys.exit(app.exec_())
except Exception as e:
    with open("error.log","w") as file:
        file.writelines("[" + str(time.time()) + "] Kim crashed with following error: " + str(e))

