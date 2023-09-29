within Arduino.CodeRace;

model Round3 "Control Throttle Valve using Arduino "
  extends Modelica.Icons.Example;
  parameter Modelica.Fluid.Types.ModelStructure pipeModelStructure = Modelica.Fluid.Types.ModelStructure.av_vb "Model structure in distributed pipe model";
  replaceable package Medium = Modelica.Media.Incompressible.Examples.Glycol47 constrainedby Modelica.Media.Interfaces.PartialMedium;
  import Modelica.Fluid.Types.Dynamics;
  parameter Dynamics systemMassDynamics = if Medium.singleState then Dynamics.SteadyState else Dynamics.SteadyStateInitial "Formulation of mass balances";
  inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = systemMassDynamics, use_eps_Re = true) annotation(
    Placement(visible = true, transformation(origin = {38, 252}, extent = {{90, -92}, {110, -72}}, rotation = 0)));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(enableNoise = true) annotation(
    Placement(visible = true, transformation(origin = {22, 100}, extent = {{60, 60}, {80, 80}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput rAct annotation(
    Placement(visible = true, transformation(origin = {310, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {202, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput rDesVal annotation(
    Placement(visible = true, transformation(origin = {310, -198}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {202, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput rPs annotation(
    Placement(visible = true, transformation(origin = {310, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {202, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Arduino.Components.ArduinoUno arduinoUno(sketch = "ThrottleControl.ino") annotation(
    Placement(visible = true, transformation(origin = {-181, -116.75}, extent = {{-47, -58.75}, {47, 58.75}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM signalPWM(f = 1000, useConstantDutyCycle = false) annotation(
    Placement(visible = true, transformation(origin = {-44, -8}, extent = {{-60, -70}, {-40, -50}}, rotation = 0)));
  Modelica_Custom.Blocks.Sources.BooleanConstant booleanConstant(k = false) annotation(
    Placement(visible = true, transformation(origin = {-150, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
    Placement(visible = true, transformation(origin = {-44, 6}, extent = {{-90, -40}, {-70, -20}}, rotation = 0)));
  Modelica.Electrical.PowerConverters.DCDC.HBridge hbridge(useHeatPort = false) annotation(
    Placement(visible = true, transformation(origin = {-44, 6}, extent = {{-60, -10}, {-40, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage Battery(V = 12) annotation(
    Placement(visible = true, transformation(origin = {-124, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Sources.BooleanPulse JamStimiulation(period = 40, startTime = 15, width = 40) annotation(
    Placement(visible = true, transformation(origin = {-16, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput JamValve annotation(
    Placement(visible = true, transformation(origin = {310, -160}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {202, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(
    Placement(visible = true, transformation(origin = {-80, -94}, extent = {{-8, -8}, {8, 8}}, rotation = 90)));
  Modelica.Blocks.Math.Gain Conversion(k = 1/5) annotation(
    Placement(visible = true, transformation(origin = {-50, -94}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R(displayUnit = "kOhm") = 10000) annotation(
    Placement(visible = true, transformation(origin = {-116, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C(displayUnit = "uF") = 1.000000000000001e-05) annotation(
    Placement(visible = true, transformation(origin = {-100, -128}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(
    Placement(visible = true, transformation(origin = {-102, -182}, extent = {{-90, -40}, {-70, -20}}, rotation = 0)));
  Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet dcpm(IaNominal = 0.8, Jr(start = 7.80) = 5.55e-7, Js = 4.5, La(displayUnit = "mH") = 0.0007000000000000001, Ra = 0.4, VaNominal = 12.4, phiMechanical(displayUnit = "rad"), wMechanical(displayUnit = "rad/s"), wNominal(displayUnit = "rpm") = 104.7197551196598) annotation(
    Placement(visible = true, transformation(origin = {-53, -41}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Modelica_Custom.Blocks.Math.Gain gain1(k(displayUnit = "%") = 1/100) annotation(
    Placement(visible = true, transformation(origin = {78, -136}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  Modelica_Custom.Blocks.Continuous.Integrator integrator annotation(
    Placement(visible = true, transformation(origin = {56, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_Custom.Mechanics.Translational.Components.MassWithStopAndFriction mass(F_Coulomb = 1.2, F_Stribeck = 2, F_prop = 0.8, fexp = 2, m = 0.1, smax = 1.59, smin = 0) annotation(
    Placement(visible = true, transformation(origin = {22, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.IdealGearR2T idealGearR2T1(ratio = 40) annotation(
    Placement(visible = true, transformation(origin = {10, -40}, extent = {{-32, -10}, {-12, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Spring spring(c = 40) annotation(
    Placement(visible = true, transformation(origin = {54, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_Custom.Blocks.Math.Gain Rad2Deg(k(displayUnit = "deg") = 57.2957795131) annotation(
    Placement(visible = true, transformation(origin = {90, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = 100) annotation(
    Placement(visible = true, transformation(origin = {146, -60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica_Custom.Blocks.Math.Gain Deg2Per(k(displayUnit = "%") = (1/90)*100) annotation(
    Placement(visible = true, transformation(origin = {122, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed(phi0 = 0) annotation(
    Placement(visible = true, transformation(origin = {60, 18}, extent = {{10, -70}, {30, -50}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(
    Placement(visible = true, transformation(origin = {36, -76}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.TimeTable timeTable(table = [0, 0; 1, 50; 1.5, 50; 2.5, 50; 3, 50; 4, 80; 5, 85; 6, 80; 7, 30; 9, 30; 10, 11; 12, 11; 13, 88; 14, 88; 14.5, 88; 15, 100; 20, 100; 25, 100; 27, 100; 35, 100; 40, 100; 40.5, 10; 41, 80; 41.5, 100; 42, 0; 43.5, 70; 44, 0; 44.5, 50; 45, 0; 46, 95; 46.5, 10; 47, 95; 48, 33; 49, 79; 49.5, 0; 50, 100]) annotation(
    Placement(visible = true, transformation(origin = {-236, 2}, extent = {{-100, -70}, {-80, -50}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/100) annotation(
    Placement(visible = true, transformation(origin = {-284, -58}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Potentiometer Setpoint(rConstant = 0.01, useRinput = true) annotation(
    Placement(visible = true, transformation(origin = {-278, -98}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V = 5) annotation(
    Placement(visible = true, transformation(origin = {-244, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1 annotation(
    Placement(visible = true, transformation(origin = {-256, -186}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica_Custom.Blocks.Math.Gain gain2(k(displayUnit = "1") = 20) annotation(
    Placement(visible = true, transformation(origin = {158, -198}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_Custom.Blocks.Math.Gain gain4(k(displayUnit = "1") = 1/5) annotation(
    Placement(visible = true, transformation(origin = {214, -160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor2 annotation(
    Placement(visible = true, transformation(origin = {-62, -160}, extent = {{8, -8}, {-8, 8}}, rotation = 90)));
  Modelica.Electrical.Analog.Basic.Potentiometer OpeningPercentage(rConstant = 0.01, useRinput = true) annotation(
    Placement(visible = true, transformation(origin = {-320, -116}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
equation
  connect(booleanConstant.y, hbridge.fire_n) annotation(
    Line(points = {{-139, -46}, {-89, -46}, {-89, -6}}, color = {255, 0, 255}));
  connect(signalPWM.fire, hbridge.fire_p) annotation(
    Line(points = {{-100, -57}, {-100, -7}}, color = {255, 0, 255}));
  connect(Battery.n, hbridge.dc_n1) annotation(
    Line(points = {{-124, -6}, {-110, -6}, {-110, 0}, {-104, 0}}, color = {0, 0, 255}));
  connect(Battery.n, ground.p) annotation(
    Line(points = {{-124, -6}, {-124, -14}}, color = {0, 0, 255}));
  connect(Battery.p, hbridge.dc_p1) annotation(
    Line(points = {{-124, 14}, {-124, 24}, {-110, 24}, {-110, 12}, {-104, 12}}, color = {0, 0, 255}));
  connect(voltageSensor.p, resistor.n) annotation(
    Line(points = {{-80, -102}, {-106, -102}}, color = {0, 0, 255}));
  connect(voltageSensor.v, Conversion.u) annotation(
    Line(points = {{-71, -94}, {-57, -94}}, color = {0, 0, 127}));
  connect(arduinoUno.D9, resistor.p) annotation(
    Line(points = {{-134, -102}, {-126, -102}}, color = {0, 0, 255}));
  connect(arduinoUno.GND, ground1.p) annotation(
    Line(points = {{-180, -176}, {-182, -176}, {-182, -202}}, color = {0, 0, 255}));
  connect(capacitor.n, ground1.p) annotation(
    Line(points = {{-100, -138}, {-100, -202}, {-182, -202}}, color = {0, 0, 255}));
  connect(capacitor.p, resistor.n) annotation(
    Line(points = {{-100, -118}, {-100, -102}, {-106, -102}}, color = {0, 0, 255}));
  connect(voltageSensor.n, capacitor.n) annotation(
    Line(points = {{-80, -86}, {-80, -80}, {-66, -80}, {-66, -138}, {-100, -138}}, color = {0, 0, 255}));
  connect(hbridge.dc_n2, dcpm.pin_an) annotation(
    Line(points = {{-84, 0}, {-60, 0}, {-60, -28}}, color = {0, 0, 255}));
  connect(hbridge.dc_p2, dcpm.pin_ap) annotation(
    Line(points = {{-84, 12}, {-46, 12}, {-46, -28}}, color = {0, 0, 255}));
  connect(Rad2Deg.y, Deg2Per.u) annotation(
    Line(points = {{101, -102}, {110, -102}}, color = {0, 0, 127}));
  connect(integrator.y, Rad2Deg.u) annotation(
    Line(points = {{67, -102}, {78, -102}}, color = {0, 0, 127}));
  connect(idealGearR2T1.flangeT, mass.flange_a) annotation(
    Line(points = {{-2, -40}, {12, -40}}, color = {0, 127, 0}));
  connect(dcpm.flange, idealGearR2T1.flangeR) annotation(
    Line(points = {{-40, -40}, {-22, -40}}));
  connect(mass.flange_b, spring.flange_a) annotation(
    Line(points = {{32, -40}, {44, -40}}, color = {0, 127, 0}));
  connect(spring.flange_b, fixed.flange) annotation(
    Line(points = {{64, -40}, {80, -40}, {80, -42}}, color = {0, 127, 0}));
  connect(spring.flange_a, speedSensor.flange) annotation(
    Line(points = {{44, -40}, {36, -40}, {36, -66}}, color = {0, 127, 0}));
  connect(speedSensor.w, integrator.u) annotation(
    Line(points = {{36, -86}, {36, -102}, {44, -102}}, color = {0, 0, 127}));
  connect(rAct, Deg2Per.y) annotation(
    Line(points = {{310, -102}, {134, -102}}, color = {0, 0, 127}));
  connect(rAct, gain1.u) annotation(
    Line(points = {{310, -102}, {144, -102}, {144, -136}, {90, -136}}, color = {0, 0, 127}));
  connect(gain3.y, rPs) annotation(
    Line(points = {{152, -60}, {310, -60}}, color = {0, 0, 127}));
  connect(Conversion.y, gain3.u) annotation(
    Line(points = {{-44, -94}, {-20, -94}, {-20, -60}, {138, -60}}, color = {0, 0, 127}));
  connect(timeTable.y, gain.u) annotation(
    Line(points = {{-315, -58}, {-291, -58}}, color = {0, 0, 127}));
  connect(gain.y, Setpoint.r) annotation(
    Line(points = {{-277, -58}, {-254, -58}, {-254, -88}, {-266, -88}}, color = {0, 0, 127}));
  connect(constantVoltage1.p, arduinoUno.Vin) annotation(
    Line(points = {{-244, -94}, {-244, -52}, {-180, -52}, {-180, -58}}, color = {0, 0, 255}));
  connect(constantVoltage1.n, ground1.p) annotation(
    Line(points = {{-244, -114}, {-244, -202}, {-182, -202}}, color = {0, 0, 255}));
  connect(Setpoint.contact, arduinoUno.A0) annotation(
    Line(points = {{-268, -108}, {-268, -120}, {-228, -120}}, color = {0, 0, 255}));
  connect(Setpoint.pin_p, constantVoltage1.p) annotation(
    Line(points = {{-278, -88}, {-278, -80}, {-244, -80}, {-244, -94}}, color = {0, 0, 255}));
  connect(Setpoint.pin_n, ground1.p) annotation(
    Line(points = {{-278, -108}, {-278, -132}, {-244, -132}, {-244, -202}, {-182, -202}}, color = {0, 0, 255}));
  connect(Setpoint.contact, voltageSensor1.p) annotation(
    Line(points = {{-268, -108}, {-268, -186}, {-264, -186}}, color = {0, 0, 255}));
  connect(voltageSensor1.n, ground1.p) annotation(
    Line(points = {{-248, -186}, {-182, -186}, {-182, -202}}, color = {0, 0, 255}));
  connect(voltageSensor1.v, gain2.u) annotation(
    Line(points = {{-256, -194}, {-256, -198}, {146, -198}}, color = {0, 0, 127}));
  connect(gain2.y, rDesVal) annotation(
    Line(points = {{170, -198}, {310, -198}}, color = {0, 0, 127}));
  connect(JamStimiulation.y, mass.JamTrig) annotation(
    Line(points = {{-4, 2}, {8, 2}, {8, -30}, {20, -30}}, color = {255, 0, 255}));
  connect(gain4.y, JamValve) annotation(
    Line(points = {{226, -160}, {310, -160}}, color = {0, 0, 127}));
  connect(voltageSensor2.v, gain4.u) annotation(
    Line(points = {{-53, -160}, {202, -160}}, color = {0, 0, 127}));
  connect(arduinoUno.D2, voltageSensor2.p) annotation(
    Line(points = {{-134, -144}, {-62, -144}, {-62, -152}}, color = {0, 0, 255}));
  connect(voltageSensor2.n, ground1.p) annotation(
    Line(points = {{-62, -168}, {-62, -202}, {-182, -202}}, color = {0, 0, 255}));
  connect(OpeningPercentage.contact, arduinoUno.A1) annotation(
    Line(points = {{-310, -126}, {-228, -126}}, color = {0, 0, 255}));
  connect(OpeningPercentage.r, gain1.y) annotation(
    Line(points = {{-308, -106}, {-294, -106}, {-294, -172}, {38, -172}, {38, -136}, {68, -136}}, color = {0, 0, 127}));
  connect(OpeningPercentage.pin_n, ground1.p) annotation(
    Line(points = {{-320, -126}, {-320, -202}, {-182, -202}}, color = {0, 0, 255}));
  connect(OpeningPercentage.pin_p, constantVoltage1.p) annotation(
    Line(points = {{-320, -106}, {-322, -106}, {-322, -80}, {-244, -80}, {-244, -94}}, color = {0, 0, 255}));
  connect(signalPWM.dutyCycle, Conversion.y) annotation(
    Line(points = {{-106, -68}, {-120, -68}, {-120, -82}, {-36, -82}, {-36, -94}, {-44, -94}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>

</html>"),
    experiment(StopTime = 50, StartTime = 0, Tolerance = 1e-06, Interval = 0.001),
    __Dymola_Commands(file = "modelica://Modelica/Resources/Scripts/Dymola/Fluid/IncompressibleFluidNetwork/plotResults.mos" "plotResults"),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-300, -200}, {300, 200}})),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", single = "()"));
end Round3;
