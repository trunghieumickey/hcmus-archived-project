within Modelica_Custom.Electrical.Analog.Semiconductors;

function exlin2 "Exponential function linearly continued for x < MinExp and x > Maxexp"
  extends Modelica.Icons.Function;
  input Real x;
  input Real Minexp;
  input Real Maxexp;
  output Real z;
algorithm
  z := if x < Minexp then exp(Minexp)*(1 + x - Minexp) else exlin(x, Maxexp);
end exlin2;
