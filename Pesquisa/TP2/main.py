from deepface import DeepFace
import cv2
import matplotlib.pyplot as plt

haarFaceClassifier = cv2.CascadeClassifier("./haarcascade_frontalface_default.xml") # Haar Face classifier 
webcamImage = cv2.VideoCapture(0)

while True:
    _, frame = webcamImage.read() # Read a frame from the webcam
    frame = cv2.flip(frame,1) # Mirror image (just to display image as it usually is)
    grayImg = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY) # Transform image from BGR to gray scale
    facesRec = haarFaceClassifier.detectMultiScale(grayImg,1.1, 10) # Detect face

    for (x,y,w,h) in facesRec: # Faces Coordinates returned by haarFaceClassifier
        cv2.rectangle(frame, (x,y),(x + w, y + h), (52, 64, 235), 5) # Draw a rectangle in the face

    try:
        # Uses Deepface analyzer to detect emotion using deepface pretrained models.
        # The prediction are given in percentage [0,1] and the greater one can be found in dominant_emotion attribute
        analysis = DeepFace.analyze(frame, actions=['emotion'])
        # print(analysis)
        # exit()
        emotion = analysis["dominant_emotion"]
        print("Emotion detected  : " + emotion.capitalize())
        cv2.putText(frame, str(emotion.capitalize()+": "+str(round(analysis["emotion"][emotion], 2))), (x, y-5), cv2.FONT_HERSHEY_SIMPLEX, 2, (102, 0, 255), 5) # Display prediction result in the screen
        print("Emotion percentage: " + str(analysis["emotion"][emotion]))

    except:
        print("No faces could be found.")

    # Display the output
    cv2.imshow('Webcam Video', frame)
    
    # Exit when pressed 'q'
    key = cv2.waitKey(1) 
    if key == ord('q'):
        break

webcamImage.release()