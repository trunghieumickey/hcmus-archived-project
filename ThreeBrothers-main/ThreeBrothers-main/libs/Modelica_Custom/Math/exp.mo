within Modelica_Custom.Math;

function exp "Exponential, base e"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u "Independent variable";
  output Real y "Dependent variable y=exp(u)";

external "builtin" y = exp(u);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,-80.3976},{68,-80.3976}}, color={192,192,192}),
        Polygon(
          points={{90,-80.3976},{68,-72.3976},{68,-88.3976},{90,-80.3976}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-31,-77.9},{-6.03,-74},{10.9,-68.4},{23.7,-61},
              {34.2,-51.6},{43,-40.3},{50.3,-27.8},{56.7,-13.5},{62.3,2.23},{
              67.1,18.6},{72,38.2},{76,57.6},{80,80}}),
        Text(
          extent={{-86,50},{-14,2}},
          textColor={192,192,192},
          textString="exp")}),
    Documentation(info="<html>
<p>
This function returns y = exp(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/exp.png\">
</p>
</html>"));
end exp;
