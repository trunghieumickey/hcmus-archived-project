import cv2
import numpy as np
import io
import base64

def read_image(image_data):
    if image_data is None:
        raise ValueError("image_data cannot be None")
    # Remove the 'data:image/webp;base64,' part from the image_data
    image_data = image_data.split(',')[1]

    # Decode the base64 image data
    image_data = base64.b64decode(image_data)

    # Convert the image data to a numpy array
    nparr = np.frombuffer(image_data, np.uint8)

    # Convert the numpy array to a cv2 image
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    return image