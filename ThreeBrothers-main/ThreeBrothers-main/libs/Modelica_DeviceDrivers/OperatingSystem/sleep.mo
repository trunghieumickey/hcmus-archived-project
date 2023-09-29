within Modelica_DeviceDrivers.OperatingSystem;
function sleep
  import Modelica;
  extends Modelica.Icons.Function;
 input Real sleepingTime
    "time (in seconds) during the simulation does nothing.";
external "C" MDD_OS_Sleep(sleepingTime)
 annotation(Include = "#include \"MDDOperatingSystem.h\"",
            __iti_dll = "ITI_MDD.dll",
            __iti_dllNoExport = true);
  annotation(__ModelicaAssociation_Impure=true);
end sleep;
