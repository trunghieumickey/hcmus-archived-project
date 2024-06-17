import numpy as np
import face_recognition
import cv2

def check_face(unknown_image, auth_image):
    # # Convert PIL Images to RGB
    # unknown_image = unknown_image.convert('RGB')
    # auth_image = auth_image.convert('RGB')
    unknown_image = cv2.cvtColor(unknown_image, cv2.COLOR_BGR2RGB)
    auth_image = cv2.cvtColor(auth_image, cv2.COLOR_BGR2RGB)

    # Convert PIL Images to numpy arrays
    unknown_image = np.array(unknown_image)
    auth_image = np.array(auth_image)

    # Find the face encodings for the known image
    unknown_encoding = face_recognition.face_encodings(unknown_image)[0]
    auth_encoding = face_recognition.face_encodings(auth_image)[0]

    # Compare faces and return True / False
    results = face_recognition.compare_faces([unknown_encoding], auth_encoding, tolerance=0.9)
    return results

    