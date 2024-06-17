// Import Three.js from CDN
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader';

// Create a scene
const scene = new THREE.Scene();

// Create a camera
const camera_1 = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const camera_2 = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)

camera_1.position.set(-9, 1, -6);
camera_1.lookAt(scene.position);

camera_2.position.set(-9, 1, -6);
camera_2.lookAt(scene.position);

var currentCamera = camera_1;

// Create a renderer
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.shadowMap.enabled = true;
document.body.appendChild(renderer.domElement);

// Create control
const controls = new OrbitControls(camera_1, renderer.domElement);

//texture loader
const textureLoader = new THREE.TextureLoader();

//gltf loader
const gltfLoader = new GLTFLoader();

const scale = 0.00001; // Adjust this value as needed
var planeModel;
gltfLoader.load('./model/plane.glb', (gltf) => {
  gltf.scene.traverse(function (node) {
    if (node.isMesh) {
      // Enable shadow casting
      node.castShadow = true;

      // Swap the material
      node.material = new THREE.MeshPhongMaterial({ map: node.material.map });

    }
  });
  gltf.scene.scale.set(scale, scale, scale);
  planeModel = gltf.scene;
  // create another camera that on bottom of the plane
  scene.add(planeModel);
}
);

// Create a ground
const groundGeometry = new THREE.BoxGeometry(20, 0.01, 20);
const sandTexture = textureLoader.load('./texture/desertsand.jpg');
sandTexture.wrapS = THREE.RepeatWrapping;
sandTexture.wrapT = THREE.RepeatWrapping;
sandTexture.repeat.set(20, 20);
const groundMaterial = new THREE.MeshPhongMaterial({ map: sandTexture });
const ground = new THREE.Mesh(groundGeometry, groundMaterial);
//duplicate the ground texture

ground.receiveShadow = true;
scene.add(ground);

// Create sunlight as a directional light
function createLight(color) {
  const sunlight = new THREE.DirectionalLight(color, 1);
  sunlight.castShadow = true;
  sunlight.shadow.mapSize.width = 1024; // default is 512
  sunlight.shadow.mapSize.height = 1024;
  sunlight.shadow.camera.left = -20; // default is -5
  sunlight.shadow.camera.right = 20; // default is 5
  sunlight.shadow.camera.top = 20; // default is 5
  sunlight.shadow.camera.bottom = -20; // default is -5
  sunlight.shadow.camera.updateProjectionMatrix();
  scene.add(sunlight);
  return sunlight;
}
const sunlight = createLight(0xffffff);
const moonlight = createLight(0xb0c4de);

//create a speare representing the sun
const sunGeometry = new THREE.SphereGeometry(1, 32, 32);
const sunMaterial = new THREE.MeshBasicMaterial({ color: 0xffff00 });
const sun = new THREE.Mesh(sunGeometry, sunMaterial);
scene.add(sun);

//create a speare representing the moon
const moonGeometry = new THREE.SphereGeometry(1, 32, 32);
const moonMaterial = new THREE.MeshBasicMaterial({ color: 0x808080 });
const moon = new THREE.Mesh(moonGeometry, moonMaterial);
scene.add(moon);

//create ambient
const ambientLight = new THREE.AmbientLight(0xffffff, 0.1)
scene.add(ambientLight);


// Create skybox
const skyboxGeometry = new THREE.BoxGeometry(1000, 1000, 1000);
const skyboxMaterial = new THREE.MeshBasicMaterial({ color: 0x87ceeb, side: THREE.BackSide });
const skybox = new THREE.Mesh(skyboxGeometry, skyboxMaterial);
scene.add(skybox);

// Create pyramid
const pyramidTexture = textureLoader.load('./texture/sandstone.jpg');
const pyramidMaterial = new THREE.MeshPhongMaterial({ map: pyramidTexture });
function createPyramid(side, height, west, south) {
  const pyramidGeometry = new THREE.ConeGeometry(side / 2, height, 4);
  const pyramid = new THREE.Mesh(pyramidGeometry, pyramidMaterial);
  pyramid.position.set(west - 5, height / 2, south - 5);
  pyramid.castShadow = true;
  pyramid.receiveShadow = true;
  pyramid.rotation.y = Math.PI / 4;

  scene.add(pyramid);
  return pyramid;
}

const Khufu = createPyramid(2.304, 1.466, 0, 0); // Khufu pyramid
const Khafre = createPyramid(2.155, 1.435, 2.15, 4.48); // Khafre pyramid
const Menkaure = createPyramid(1.085, 0.665, 5.44, 10.96); // Menkaure pyramid

// plane path configuration
const length = 10;
const flightHeight = 2;
const direction = new THREE.Vector3().subVectors(Menkaure.position, Khufu.position).normalize();
const extendedKhufuPosition = new THREE.Vector3().addVectors(Khufu.position, direction.clone().multiplyScalar(-length));
const extendedMenkaurePosition = new THREE.Vector3().addVectors(Menkaure.position, direction.clone().multiplyScalar(length));
const lookAtPosition = new THREE.Vector3(extendedKhufuPosition.x, flightHeight, extendedKhufuPosition.z);

// Create an object to hold the state of key presses
let keyState = {};

// Add event listeners for keydown and keyup events
window.addEventListener('keydown', function(e) {
  keyState[e.key.toUpperCase()] = true;
});

window.addEventListener('keyup', function(e) {
  keyState[e.key.toUpperCase()] = false;
});

// Render the scene
function animate() {

  // Get current time
  const time = Date.now() * 0.00001 * 24; // Scale time by a day

  // Calculate the position of the sunlight based on time
  const angle = (time) % (Math.PI * 2);
  const radius = 50;
  const x = Math.cos(angle) * radius;
  const y = Math.sin(angle) * radius;
  const lerpFactor = time * 0.1 % 1;

  if (planeModel) {
    planeModel.position.lerpVectors(extendedKhufuPosition, extendedMenkaurePosition, lerpFactor);
    planeModel.position.y = flightHeight //not crusing altitude but just to make it visible
    planeModel.lookAt(lookAtPosition);
    planeModel.rotation.y += Math.PI / 2;
    
    camera_2.position.copy(planeModel.position);
    camera_2.position.y -= 0.1;
    camera_2.lookAt(camera_2.position.x, 0, camera_2.position.z);
    camera_2.rotation.z = planeModel.rotation.z;
  }

  // change the sunlight intensity
  sunlight.intensity = Math.max(0, Math.sin(angle));

  // Update the position of the sunlight
  sunlight.position.set(x, y, 1);
  sun.position.set(x, y, 1);

  //change the moonlight intensity
  moonlight.intensity = (1 - sunlight.intensity) * 0.3;

  // Update the position of the moonlight
  moonlight.position.set(-x, -y, 1);
  moon.position.set(-x, -y, 1);

  //adjust the skybox color
  skybox.material.color.setHSL(0.6, 1, 0.5 * (0.01 + sunlight.intensity));

  // Request the next animation frame
  requestAnimationFrame(animate);

  // Render the scene with camera 2 if "Q" is held down
  if (keyState["Q"]) {
    renderer.render(scene, camera_2);
  } else {
    renderer.render(scene, camera_1);
  }

}
animate();


