within Modelica_Custom.Math;

function sinh "Hyperbolic sine"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=sinh(u)";

external "builtin" y = sinh(u);
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
        Line(points={{-80,-80},{-76,-65.4},{-71.2,-51.4},{-65.5,-38.8},{-59.1,-28.1},
              {-51.1,-18.7},{-41.4,-11.4},{-27.7,-5.5},{-4.42,-0.653},{24.5,
              4.57},{39,10.1},{49.4,17.2},{57.5,25.9},{63.9,35.8},{69.5,47.4},{
              74.4,60.4},{78.4,73.8},{80,80}}),
        Text(
          extent={{-88,80},{-16,32}},
          textColor={192,192,192},
          textString="sinh")}),
    Documentation(info="<html>
<p>
This function returns y = sinh(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/sinh.png\">
</p>
</html>"));
end sinh;
