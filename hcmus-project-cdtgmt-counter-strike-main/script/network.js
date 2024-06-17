import mqtt from "mqtt";
import { player, scene } from "./index.js";
import * as THREE from "three";
import { takeDamage, showDeadScreen, health} from "./UI.js";


const client = mqtt.connect('wss://test.mosquitto.org:8081');
const topic = 'hcmus-cs';
const playerID = Math.floor(Math.random() * 0x100000000).toString(16).padStart(8, '0');
const targetPositions = [];

export function sendMessage(message) {
    client.publish(topic, message);
}

var player_shot, enemyID;
export function doDamage(targetPlayerID) {
    enemyID = targetPlayerID;
    player_shot = true;
}

export function updateNetworkPlayers(deltaTime) {
    const speed = 5.0; // Adjust the speed as needed
    const step = speed * deltaTime;

    for (const playerID in targetPositions) {
        const targetPosition = targetPositions[playerID];
        const player = scene.getObjectByName(playerID);
        // remove the player is idling for 30s
        if (player && performance.now() - player.lastTimeStamp > 30000) {
            scene.remove(player);
            delete targetPositions[playerID];
            console.log("Remove player: ", playerID);
        }
        if (player) {
            const distanceX = targetPosition.x - player.position.x;
            const distanceY = targetPosition.y - player.position.y;
            const distanceZ = targetPosition.z - player.position.z;
            const distanceR = targetPosition.r - player.rotation.y;
            const stepX = distanceX * step;
            const stepY = distanceY * step;
            const stepZ = distanceZ * step;
            const stepR = distanceR * step;
            player.position.x += stepX;
            player.position.y += stepY;
            player.position.z += stepZ;
            player.rotation.y += stepR;
        }
    }
}

function messageHandler(message) {
    switch (message.action) {
        case 'move':
            if (message.playerID !== playerID) {
                let player = scene.getObjectByName(message.playerID);
                if (!player) {
                    player = new THREE.Mesh(
                        new THREE.CylinderGeometry(0.3, 0.3, 1.6, 32),
                        new THREE.MeshStandardMaterial({ color: 0xffffff })
                    );
                    player.name = message.playerID;
                    player.lastTimeStamp = performance.now();
                    console.log("Add new player: ", player.name);
                    scene.add(player);
                }
                // player.position.set(message.position.x, message.position.y, message.position.z);

                targetPositions[message.playerID] = message.position;
                player.rotation.y = message.position.r;
            }
            break;
        case 'damage':
            if (message.targetPlayerID === playerID) {
                takeDamage(message.amount);
            }
            break;
        case 'died':
            if (message.playerID !== playerID) {
                null;
                //add a logic here to handle
                //your model will be removed
                const player = scene.getObjectByName(message.playerID);
                if (player) scene.remove(player);
            }
            break;
        default:
            break;
    }
}

let lastSentMessage = null;

client.on('connect', () => {
    console.log('Connected to MQTT broker');
    client.subscribe(topic);
    //for every 500ms, send a message to the server
    setInterval(() => {
        const currentMessage = JSON.stringify({
            playerID: playerID,
            action: 'move',
            position: {
                x: player.position.x.toFixed(2),
                y: player.position.y.toFixed(2),
                z: player.position.z.toFixed(2),
                r: player.rotation.y.toFixed(2),
            },
        });

        if (currentMessage !== lastSentMessage) {
            sendMessage(currentMessage);
            lastSentMessage = currentMessage;
        }

        if (player_shot) {
            const message = JSON.stringify({
                playerID: playerID,
                action: 'damage',
                targetPlayerID: enemyID,
                amount: 25,
            });
            sendMessage(message);
            player_shot = false;
        }
        if (health <= 0) {
            const message = JSON.stringify({
                playerID: playerID,
                action: 'died',
            });
            sendMessage(message);
            showDeadScreen();
        }
    }, 50);
});

client.on('message', (topic, message) => {
    message = JSON.parse(message);
    messageHandler(message);
});