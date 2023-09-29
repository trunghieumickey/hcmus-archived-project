from OMPython import OMCSessionZMQ
import pytest
import numpy as np

# Reference document
# https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/ompython.html#

# Create new OpenModelica Session
omc = OMCSessionZMQ()
# Send command line.
# Path to Arduino Library folder
assert omc.sendExpression(f'cd("./CodeRace/Round3/Library/Arduino")')
# Send command line
# Load Arduino Library
assert omc.sendExpression(f'loadFile("package.mo")')
# Send command line
# Build Arduino Sketch
assert omc.sendExpression(f'Arduino.Internal.buildSketchOM("Round3.ino")')
# Send command line
# Simulate
info = omc.sendExpression(f'simulate(Arduino.CodeRace.Round3)')

# Format : val (name, time)
# Get value of variable named "rAct" at time = 2 seconds
rAct = omc.sendExpression("val(rAct , 2)")
# Get value of variable named "rDesVal" at time = 2 seconds
rDesVal = omc.sendExpression("val(rDesVal , 2)")
# If Maximum Deviation <= 3, then PASS, else FAILED
assert abs(rDesVal - rAct) <= 3, "Time 2 seconds" + " : rDesVal = " + str(rDesVal) + ", rAct = " + str(rAct)
