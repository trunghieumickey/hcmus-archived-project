import * as THREE from 'three';
import { Capsule } from 'three/addons/math/Capsule.js';

export function createGunBullet() {
    const geometry = new THREE.SphereGeometry(0.1, 32, 32);
    const material = new THREE.MeshBasicMaterial({ color: 0xff0000 });
    const bullet = new THREE.Mesh(geometry, material);
    bullet.bulletDirection = new THREE.Vector3();
    bullet.bulletCollider = new Capsule(new THREE.Vector3(), new THREE.Vector3(), 0.1);
    bullet.bulletVelocity = new THREE.Vector3();
    return bullet;
}

export function updateGunBullet(deltaTime, gunBullet, gunBulletVelocity) {
    gunBullet.position.addScaledVector(gunBulletVelocity, deltaTime);
}

export function gunBulletCollisions(gunBullet, worldOctree) {
    const result = worldOctree.intersectRay(gunBullet.position, gunBulletVelocity.clone().normalize());
    if (result) {
        gunBullet.position.copy(result.position);
        return true;
    }
    return false;
}

export function removeGunBullet(gunBullet) {
    gunBullet.position.set(0, -100, 0);
}