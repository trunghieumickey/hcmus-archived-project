within Modelica_Custom.Math;

function acos "Inverse cosine (-1 <= u <= 1)"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Modelica.Units.SI.Angle y "Dependent variable y=acos(u)";

external "builtin" y = acos(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-80},{68,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,80},{-79.2,72.8},{-77.6,67.5},{-73.6,59.4},{-66.3,
              49.8},{-53.5,37.3},{-30.2,19.7},{37.4,-24.8},{57.5,-40.8},{68.7,-52.7},
              {75.2,-62.2},{77.6,-67.5},{80,-80}}),
        Text(
          extent={{-86,-14},{-14,-62}},
          textColor={192,192,192},
          textString="acos")}),
    Documentation(info="<html>
<p>
This function returns y = acos(u), with -1 &le; u &le; +1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acos.png\">
</p>
</html>"));
end acos;
