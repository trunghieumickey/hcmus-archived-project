within Modelica_Custom.Math;

function asinh "Inverse of sinh (area hyperbolic sine)"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=asinh(u)";

algorithm
  y := Modelica.Math.log(u + sqrt(u*u + 1));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-56.7,-68.4},{-39.8,-56.8},{-26.9,-44.7},{-17.3,
              -32.4},{-9.25,-19},{9.25,19},{17.3,32.4},{26.9,44.7},{39.8,56.8},
              {56.7,68.4},{80,80}}),
        Text(
          extent={{-90,80},{-6,26}},
          textColor={192,192,192},
          textString="asinh")}),
    Documentation(info="<html>
<p>
The function returns the area hyperbolic sine of its
input argument u. This inverse of sinh(..) is unique
and there is no restriction on the input argument u of
asinh(u) (-&infin; &lt; u &lt; &infin;):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asinh.png\">
</p>
</html>"));
end asinh;
