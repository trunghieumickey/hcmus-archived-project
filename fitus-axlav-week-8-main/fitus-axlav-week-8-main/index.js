// load face-api.js models
import * as faceapi from 'https://cdn.jsdelivr.net/npm/@vladmandic/face-api';

// get video element and canvas element
const modelLink = "https://raw.githubusercontent.com/justadudewhohacks/face-api.js/master/weights"
const video = document.getElementById('video')
const canvas = document.getElementById('canvas')

// load the face detection model
await faceapi.nets.tinyFaceDetector.loadFromUri(modelLink);

// start the video stream
navigator.mediaDevices.getUserMedia({ video: true })
  .then(stream => video.srcObject = stream)
  .catch(err => console.error(err));

// detect faces and draw bounding boxes every 100 ms
setInterval(async () => {
  // get the face detections from the video element
  const detections = await faceapi.detectAllFaces(video, new faceapi.TinyFaceDetectorOptions({ scoreThreshold: 0.05 }))

  // resize the canvas to match the video size
  const displaySize = { width: video.width, height: video.height };
  faceapi.matchDimensions(canvas, displaySize);

  // clear the previous canvas content
  canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);

  // draw the video frame on the canvas
  canvas.getContext('2d').drawImage(video, 0, 0, video.width, video.height);

  // draw the bounding boxes on the canvas
  const resizedDetections = faceapi.resizeResults(detections, displaySize);
  faceapi.draw.drawDetections(canvas, resizedDetections);
}, 100);