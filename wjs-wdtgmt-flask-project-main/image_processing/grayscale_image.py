import cv2

def grayscale_image(image):
    return cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
