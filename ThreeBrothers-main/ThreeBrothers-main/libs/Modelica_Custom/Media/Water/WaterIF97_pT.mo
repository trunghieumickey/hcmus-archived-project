within Modelica_Custom.Media.Water;

package WaterIF97_pT "Water using the IF97 standard, explicit in p and T"
  extends WaterIF97_base(
    ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pT,
    final ph_explicit=false,
    final dT_explicit=false,
    final pT_explicit=true,
    final smoothModel=true,
    final onePhase=true);
end WaterIF97_pT;
