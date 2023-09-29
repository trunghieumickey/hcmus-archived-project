within Modelica_Custom.Media.Water;

package WaterIF97_R5ph "Region 5 water according to IF97 standard"
  extends WaterIF97_fixedregion(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
    final Region=5,
    final ph_explicit=true,
    final dT_explicit=false,
    final pT_explicit=false,
    smoothModel=true,
    onePhase=true);
  annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R5ph;
