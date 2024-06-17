// Import Three.js from CDN
import * as THREE from 'three';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader';
import { Octree } from 'three/addons/math/Octree.js';
import { createPlayer, teleportPlayerIfOob, updatePlayer } from './player.js';
import { control, controls, keyStates } from './control.js';
import { updateNetworkPlayers } from './network.js';
import { createUI } from './UI.js';
import { clone } from 'three/addons/utils/SkeletonUtils.js';

const STEPS_PER_FRAME = 5;
const worldOctree = new Octree();
const clock = new THREE.Clock();
const scene = new THREE.Scene();

//create overview camera (top down, flat)
const overviewCamera = new THREE.OrthographicCamera(-50, 50, 50, -50, 1, 1000);
overviewCamera.position.set(0, 100, 0);
overviewCamera.lookAt(scene.position);

//increse camera exposure
const overviewRenderer = new THREE.WebGLRenderer();
overviewRenderer.setSize(200, 200);
overviewRenderer.domElement.style.position = 'absolute';
overviewRenderer.domElement.style.left = '20px';
overviewRenderer.domElement.style.bottom = '20px';
overviewRenderer.domElement.style.borderRadius = '50%';
overviewRenderer.domElement.style.border = '5px solid #ffffff';
document.body.appendChild(overviewRenderer.domElement);

// Create a camera
const camera = new THREE.PerspectiveCamera(90, window.innerWidth / window.innerHeight, 0.1, 1000);
camera.rotation.order = 'YXZ';
camera.castShadow = true;
camera.lookAt(scene.position);
scene.add(camera);

// Create a renderer
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor(0x87ceeb, 1);
renderer.shadowMap.enabled = true;
document.body.appendChild(renderer.domElement);

// Create an audio listener
const listener = new THREE.AudioListener();
camera.add(listener);

function createPointLight(x, y, z) {
  const light = new THREE.PointLight(0xffffff, 1, 100);
  light.position.set(x, y, z);
  light.shadowCameraVisible = true;
  light.shadow.mapSize.width = 2048;
  light.shadow.mapSize.height = 2048;
  light.shadow.camera.near = 20;
  light.shadow.camera.far = 100;
  light.shadow.bias = 0.0001;
  scene.add(light);
}

let lighting = true;
if (lighting) {
  //create directional light
  const directionalLight = new THREE.DirectionalLight(0xffffff, 2);
  directionalLight.position.set(-100, 40, -4);
  directionalLight.castShadow = true;

  directionalLight.shadow.mapSize.width = 2048;
  directionalLight.shadow.mapSize.height = 2048;
  directionalLight.shadow.camera.near = 20;
  directionalLight.shadow.camera.far = 100;
  directionalLight.shadow.bias = 0.0001;
  scene.add(directionalLight);

  //Light in Dust II
  createPointLight(79.57287971308995, -5.643300100652871, -58.85797348022461);
  createPointLight(21.990610489906908, -0.7, -25.158002472422947);
  createPointLight(44.555808320115744, -0.7, -23.060394986331307);
  createPointLight(48.18740035517612, -4.729054642021601, -34.036189584549135);
  createPointLight(103.95813903808593, -6.2782811685022695, 0.44196676611882085);
  createPointLight(84.7581573486328, -2.2301502346108763, -8.761638723017235);

  //Light in Dust
  createPointLight(-32.75806480446137, 2.4190443787500431, 5.982365635741966);
  createPointLight(-49.57342507887512, 2.4190443787500431, 10.058011428892936);
  createPointLight(-51.65818634033203, 2.4190443787500431, -6.457965745712291);
  createPointLight(-61.55688484052788, 2.4190443787500431, 5.351541658445149);
  createPointLight(-71.63927840690515, -3.35095413870466, -12.015009383198596);
  createPointLight(-71.55816040039062, -3.35095413870466, -5.610903723619264);

  //Ambient Light
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.2);
  scene.add(ambientLight);
}
else {
  const ambientLight = new THREE.AmbientLight(0xffffff, 1);
  scene.add(ambientLight);
}

//import model
const gltfLoader = new GLTFLoader();
var mapModel;

gltfLoader.load('./model/dust.glb', (gltf) => {
  mapModel = gltf.scene;

  // Traverse through all the meshes in the model
  mapModel.traverse(function (node) {
    if (node instanceof THREE.Mesh) {
      // Enable shadows for this mesh
      node.castShadow = true;
      node.receiveShadow = true;

      node.material = new THREE.MeshStandardMaterial({ map: node.material.map });
    }
  });

  scene.add(mapModel);

  // Create a bounding box
  const box = new THREE.Box3().setFromObject(mapModel);

  // Calculate the offset between the bounding box's center and the scene's center
  const offset = box.getCenter(new THREE.Vector3()).negate();

  // Apply the offset to the model's position
  mapModel.position.add(offset);

  worldOctree.fromGraphNode(mapModel);
  // Now the center of the bounding box should be at the scene's center
  animate();
  createUI();
},
  (error) => {
    console.warn('Unknown mesh map model:', error);
  }
);

window.addEventListener('resize', onWindowResize);

function onWindowResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

  renderer.setSize(window.innerWidth, window.innerHeight);

}

// ====================== Player ======================

// Add gun to player
export function addGunToPlayer(player, rifleModel) {
  gun = clone(rifleModel);
  player.add(gun);
  gun.position.set(-0.15, 1.4, 0.5);
  gun.scale.set(0.002, 0.002, 0.002);
  gun.rotation.set(0, -Math.PI / 2 + 0.1, 0);
}

// Create a player
var mixer, player, characterModel;
var actions, walkingAction, dyingAction;
let characterFrame = new THREE.Clock();
gltfLoader.load('./model/player.glb', (gltf) => {
  characterModel = gltf.scene;

  player = createPlayer(characterModel);
  scene.add(player);

  // Add gun to player
  if (rifleModel) {
    addGunToPlayer(player, rifleModel);
  }
  // Player animations
  mixer = new THREE.AnimationMixer(player);
  walkingAction = mixer.clipAction(gltf.animations[0]);
  dyingAction = mixer.clipAction(gltf.animations[1]);
  dyingAction.clampWhenFinished = true;
  dyingAction.loop = THREE.LoopOnce;

  actions = [walkingAction, dyingAction]
  actions.forEach((action) => {
    action.play();
  });

  playWalkingAnimation();

},
  (error) => {
    console.warn('Unknown mesh character model:', error);
  }
);

export function playDyingAnimation() {
  walkingAction.enabled = false;
  dyingAction.enabled = true;
  gun.position.y = 0;
}

export function playWalkingAnimation() {
  dyingAction.enabled = false;
  walkingAction.enabled = true;
}

let gun, rifleModel;
gltfLoader.load('./model/ak47.glb', (gltf) => {
  rifleModel = gltf.scene;
  gun = clone(rifleModel);
  if (player) {
    addGunToPlayer(player, rifleModel);
  }
},
  (error) => {
    console.warn('Unknown mesh ak47 model:', error);
  }
);

control();

export { worldOctree, player, characterModel, gun, rifleModel, camera, scene, listener };

function updateOverviewCamera() {
  overviewCamera.position.x = camera.position.x;
  overviewCamera.position.z = camera.position.z;
  overviewCamera.rotation.z = camera.rotation.y;
  //if holding Q zoom out
  if (keyStates['KeyQ']) {
    overviewCamera.zoom = 0.5;
  }
  else {
    overviewCamera.zoom = 1;
  }
  overviewCamera.updateProjectionMatrix();
  overviewRenderer.render(scene, overviewCamera);
}

// Create a DOM element to display the camera position
const cameraPositionElement = document.createElement('div');
cameraPositionElement.style.position = 'absolute';
cameraPositionElement.style.top = '10px';
cameraPositionElement.style.left = '10px';
cameraPositionElement.style.color = 'white';
document.body.appendChild(cameraPositionElement);

function animate() {
  // Update the camera position element
  // cameraPositionElement.textContent = `Camera position: ${camera.position.x.toFixed(2)}, ${camera.position.y.toFixed(2)}, ${camera.position.z.toFixed(2)}`;
  cameraPositionElement.textContent = `HCMUS-CS ALPHA FPS v0.75`;
  const deltaTime = Math.min(0.05, clock.getDelta()) / STEPS_PER_FRAME;

  // we look for collisions in substeps to mitigate the risk of
  // an object traversing another too quickly for detection.

  for (let i = 0; i < STEPS_PER_FRAME; i++) {
    if (player) {
      controls(deltaTime, characterFrame, mixer);
      updatePlayer(deltaTime);
      teleportPlayerIfOob();
      updateNetworkPlayers(deltaTime);
    }
  }
  updateOverviewCamera()
  renderer.render(scene, camera);
  requestAnimationFrame(animate);
}