within Modelica_Custom.Media.Water;

package WaterIF97_ph "Water using the IF97 standard, explicit in p and h"
  extends WaterIF97_base(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=false,
    onePhase=false);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_ph;
