within Modelica_Custom.Electrical.Analog.Semiconductors;

function powlin "Power function (1 - x)^(-y) linearly continued for x > 0 (provided y = const.)"
  extends Modelica.Icons.Function;
  input Real x;
  input Real y;
  output Real z;
algorithm
  z := if x > 0 then 1 + y*x else pow(1 - x, -y);
end powlin;
