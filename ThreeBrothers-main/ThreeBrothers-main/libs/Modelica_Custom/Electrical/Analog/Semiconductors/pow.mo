within Modelica_Custom.Electrical.Analog.Semiconductors;

function pow "Just a helper function for x^y in order that a symbolic engine can apply some transformations more easily"
  extends Modelica.Icons.Function;
  input Real x;
  input Real y;
  output Real z;
algorithm
  z := x^y;
end pow;
