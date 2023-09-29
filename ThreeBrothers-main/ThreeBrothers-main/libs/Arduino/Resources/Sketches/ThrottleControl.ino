// ================= Setup Parameters =================

// 1. Pins
const int valvePin = 9;                 // Throttle Valve connects to Pin 9
const int reportPin = 2;                // Report pin turn true when valve is stuck
const int intakePin = A0;               // desired intake mass value
const int sensorPin = A1;               // input pin for the potentiometer


void setup()
{
    // setup pins
    pinMode(valvePin, OUTPUT);
    pinMode(reportPin, OUTPUT);
    pinMode(intakePin, INPUT);
    pinMode(sensorPin, INPUT);

    //set report pin to low
    digitalWrite(reportPin, LOW);
}

void loop(){
    if (analogRead(intakePin) > analogRead(sensorPin)) digitalWrite(valvePin, HIGH);
    else digitalWrite(valvePin, LOW);
}
