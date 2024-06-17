import { camera, player, scene, listener, gun, playDyingAnimation } from './index.js';
import { playerOnFloor, playerAlive } from './player.js';
import { createGunBullet } from './gun_bullet.js';
import { bullets, takeBullets, reloadBullets, health } from './UI.js';
import { doDamage } from './network.js';
import * as THREE from 'three';
export const keyStates = {};
let mouseTime = 0;

//// add keydown and keyup events to the document
export function control() {
    document.addEventListener('keydown', (event) => {
        keyStates[event.code] = true;
    });

    document.addEventListener('keyup', (event) => {
        keyStates[event.code] = false;
    });

    document.addEventListener('mousedown', () => {
        document.body.requestPointerLock();
        let mos = mouseTime;
        mos = performance.now();
    });

    document.addEventListener('mouseup', () => {
        if (document.pointerLockElement !== null && bullets > 0 && health > 0) {
            shoot();
            takeBullets(1);
        };
    });

    document.body.addEventListener('mousemove', (event) => {
        if (document.pointerLockElement === document.body) {
            camera.rotation.y -= event.movementX / 500;
            camera.rotation.x -= event.movementY / 500;

            // Limit the vertical rotation of the camera
            camera.rotation.x = Math.max(-Math.PI / 2, Math.min(Math.PI / 2, camera.rotation.x));

            if (player) { player.rotation.y = camera.rotation.y + Math.PI; }
        }
    });
}

////controls
function getForwardVector() {
    camera.getWorldDirection(player.playerDirection);
    player.playerDirection.y = 0;
    player.playerDirection.normalize();
    return player.playerDirection;
}

function getSideVector() {
    camera.getWorldDirection(player.playerDirection);
    player.playerDirection.y = 0;
    player.playerDirection.normalize();
    player.playerDirection.cross(camera.up);
    return player.playerDirection;
}

function getBulletVector() {
    let bulletVector = new THREE.Vector3();
    camera.getWorldDirection(bulletVector);
    return bulletVector;
}

export function controls(deltaTime, characterFrame, mixer) {
    let characterDelta = characterFrame.getDelta();
    // gives a bit of air control
    if (player) {
        const speedDelta = deltaTime * (playerOnFloor ? 25 : 8);
        if (keyStates['KeyW']) {
            player.playerVelocity.add(getForwardVector().multiplyScalar(speedDelta));
            mixer.update(characterDelta);
        }

        if (keyStates['KeyS']) {
            player.playerVelocity.add(getForwardVector().multiplyScalar(- speedDelta));
            mixer.update(characterDelta);
        }

        if (keyStates['KeyA']) {
            player.playerVelocity.add(getSideVector().multiplyScalar(- speedDelta));
            mixer.update(characterDelta);
        }

        if (keyStates['KeyD']) {
            player.playerVelocity.add(getSideVector().multiplyScalar(speedDelta));
            mixer.update(characterDelta);
        }

        if (playerOnFloor) {
            if (keyStates['Space']) {
                player.playerVelocity.y = 10;
            }
        }

        if (!playerAlive) {
            playDyingAnimation(mixer);
            mixer.update(characterDelta);
        }
        //Reload bullets
        if (keyStates['KeyR']) {
            reloadBullets();
        }

        if (bullets === 0) {
            reloadBullets();
        }
    }
}

// Load the sound
let gunSound;
const audioLoader = new THREE.AudioLoader();
audioLoader.load('sound/AK-47.mp3', function (buffer) {
    gunSound = new THREE.Audio(listener);
    gunSound.setVolume(0.1);
    gunSound.setBuffer(buffer);
});

var enemyID;
function shoot() {
    // Create a raycaster
    const raycaster = new THREE.Raycaster();
    raycaster.set(camera.position, getBulletVector());
    raycaster.camera = camera; // Set the Raycaster.camera property to the camera object

    // Perform the raycast
    const intersects = raycaster.intersectObjects(scene.children, true);

    // Create a line to visualize the bullet trajectory
    const lineMaterial = new THREE.LineBasicMaterial({ color: 0xff0000 });
    const points = [];
    points.push(new THREE.Vector3().copy(new THREE.Box3().setFromObject(gun).getCenter(new THREE.Vector3())));


    // const ak47Range = intersects.length > 0 ? intersects[0].distance : 1000;
    var ak47Range = 100;
    if (intersects.length > 0) {
        for (let i = 0; i < intersects.length; i++) {
            if (intersects[i].object.type != "Line") {
                var ak47Range = intersects[i].distance;
                break;
            }
        }
    }


    points.push(new THREE.Vector3().copy(camera.position).add(getBulletVector().multiplyScalar(ak47Range)));
    const lineGeometry = new THREE.BufferGeometry().setFromPoints(points);
    const line = new THREE.Line(lineGeometry, lineMaterial);
    scene.add(line);

    if (gunSound.isPlaying) {
        gunSound.stop();
        gunSound.play();
    }
    else {
        gunSound.play();
    }

    // Check if line touches a target player, that player will take damage
    if (intersects.length > 0) {
        // let target = intersects[0].object; // Change const to let
        // console.log("target: ", target);
        // //target name is hash code
        // if (target.name != player.name) {
        //     if (target.name != "Object_4" && target.name != "") {
        //         enemyID = target.name;
        //         console.log("enemyID: ", enemyID);
        //         doDamage(enemyID);
        //     }
        // }
        for (let i = 0; i < intersects.length; i++) {
            let target = intersects[i].object;
            if (target.name != player.name && target.name != "Object_4" && target.name != "") {
                enemyID = target.name;
                console.log("enemyID: ", enemyID);
                doDamage(enemyID);
                break;

            }
        }
    }

    // Remove the bullet and line after 1 second
    setTimeout(() => {
        scene.remove(line);
    }, 1000);
}