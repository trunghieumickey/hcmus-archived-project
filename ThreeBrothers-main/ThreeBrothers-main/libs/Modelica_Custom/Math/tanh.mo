within Modelica_Custom.Math;

function tanh "Hyperbolic tangent"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=tanh(u)";

external "builtin" y = tanh(u);
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
        Line(points={{-80,-80},{-47.8,-78.7},{-35.8,-75.7},{-27.7,-70.6},{-22.1,
              -64.2},{-17.3,-55.9},{-12.5,-44.3},{-7.64,-29.2},{-1.21,-4.82},{
              6.83,26.3},{11.7,42},{16.5,54.2},{21.3,63.1},{26.9,69.9},{34.2,75},
              {45.4,78.4},{72,79.9},{80,80}}),
        Text(
          extent={{-88,72},{-16,24}},
          textColor={192,192,192},
          textString="tanh")}),
    Documentation(info="<html>
<p>
This function returns y = tanh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tanh.png\">
</p>
</html>"));
end tanh;
