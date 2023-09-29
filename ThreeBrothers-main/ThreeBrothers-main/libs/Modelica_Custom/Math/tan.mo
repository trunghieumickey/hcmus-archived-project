within Modelica_Custom.Math;

function tan "Tangent (u shall not be -pi/2, pi/2, 3*pi/2, ...)"
  extends Modelica.Math.Icons.AxisCenter;
  input Modelica.Units.SI.Angle u "Independent variable";
  output Real y "Dependent variable y=tan(u)";

external "builtin" y = tan(u);
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
        Line(points={{-80,-80},{-78.4,-68.4},{-76.8,-59.7},{-74.4,-50},{-71.2,-40.9},
              {-67.1,-33},{-60.7,-24.8},{-51.1,-17.2},{-35.8,-9.98},{-4.42,-1.07},
              {33.4,9.12},{49.4,16.2},{59.1,23.2},{65.5,30.6},{70.4,39.1},{73.6,
              47.4},{76,56.1},{77.6,63.8},{80,80}}),
        Text(
          extent={{-90,72},{-18,24}},
          textColor={192,192,192},
          textString="tan")}),
    Documentation(info="<html>
<p>
This function returns y = tan(u), with -&infin; &lt; u &lt; &infin;
(if u is a multiple of (2n-1)*pi/2, y = tan(u) is +/- infinity).
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/tan.png\">
</p>
</html>"));
end tan;
