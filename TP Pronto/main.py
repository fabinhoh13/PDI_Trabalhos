# Haar cascade frontal face XML can be found at
# https://github.com/opencv/opencv/tree/master/data/haarcascades

from deepface import DeepFace
import cv2
import matplotlib.pyplot as plt
import os
import sys

path = 'DB'
help = """
Syntax: python main.py <Face Detector> <Webcam> <Save> <Verbose>
    * Face Detector - String - [REQUIRED]
    * Webcam - Integer - [REQUIRED]
    * Save - Flag '-s' - [OPTIONAL]
    * Verbose - Flag '-v' - [OPTIONAL]
"""

def main():
    """
        Course: BCC326 - Image Processing

        Students:
        * Carlos Eduardo Romaniello - 19.1.4003
        * Fabio Henrique Alves Fernandes - 19.1.4128
        * Vinicius Gabriel Verona - 19.1.4005

        Syntax: 
        * `python main.py <Face Detector> <Webcam> <Save> <Verbose>`
        * `Face Detector` - String - [REQUIRED]
        * `Webcam` - Integer - [REQUIRED]
        * `Save` - Flag `-s` - [OPTIONAL]
        * `Verbose` - Flag `-v` - [OPTIONAL]

        Steps:
        * [OK] Get frame from a given webcam with openCV
        * [OK] Flip the image
        * [OK] Call [DeepFace](https://github.com/serengil/deepface) analyzer with a given detector
        * [OK] Identify face region in the frame
        * [OK] Collect the prediction
        * [OK] Display the result in the frame

        Webcam:
        * `0`: Computer's default webcam
        * `i <Integer>`: Open camera `i` to capture frames

        Available detectors:
        * `ssd` - Single-Shot Detector - [DEFAULT]
        * `opencv` - Haar-Cascade algorithm
    """

    if len(sys.argv) == 1 or ((not sys.argv[1].__eq__('ssd')) and (not sys.argv[1].__eq__('opencv'))) or "-h" in sys.argv:
        print(help)
        return

    webcamImage = cv2.VideoCapture(int(sys.argv[2])) # Open Webcam to capture video
    counter = 0

    while True:
        _, frame = webcamImage.read() # Read a frame from the webcam
        frame = cv2.flip(frame,1) # Mirror image (just to display image as it usually is)

        try:
            # Uses Deepface analyzer to detect emotion using deepface pretrained models.
            # The prediction are given in percentage [0,1] and the greater one can be found in dominant_emotion attribute
            analysis = DeepFace.analyze(frame, actions=['emotion'], detector_backend=sys.argv[1])
            emotion = analysis["dominant_emotion"]

            x = analysis["region"]["x"]
            y = analysis["region"]["y"]
            w = analysis["region"]["w"]
            h = analysis["region"]["h"]
            cv2.rectangle(frame, (x,y),(x + w, y + h), (52, 64, 235), 5) # Draw a rectangle in the face

            cv2.putText(frame, str(emotion.capitalize()+": "+str(round(analysis["emotion"][emotion], 2))), (x, y-5), cv2.FONT_HERSHEY_SIMPLEX, 2, (102, 0, 255), 5) # Display prediction result in the screen
            
            if '-v' in sys.argv:
                print("Dominant Emotion  : " + emotion.capitalize())
                print("Emotion percentage: " + str(analysis["emotion"][emotion]) + "\n")
    
            # Save frame to DB
            if '-s' in sys.argv:
                if not os.path.exists(path + "/" + sys.argv[1] + "/" + emotion.capitalize() + "/"):
                    os.makedirs(path + "/" +  sys.argv[1] + "/" + emotion.capitalize() + "/")

                counter += 1
                spath = path + "/" + sys.argv[1] + "/" + emotion.capitalize() + "/"
                # cv2.imwrite(f"{path}/{sys.argv[1]}/{emotion.capitalize()}/Frame-{counter}.png", frame)
                cv2.imwrite(os.path.join(spath, f"Frame-{counter}.png"), frame)
    
        except:
            if '-v' in sys.argv: 
                print("No faces could be found.")

        # Display the output
        cv2.imshow('Webcam Video', frame)
        
        # Exit when pressed 'q'
        key = cv2.waitKey(1) 
        if key == ord('q') or key == 27: # Second is esq
            print("Exiting...")
            break

    webcamImage.release()

main()