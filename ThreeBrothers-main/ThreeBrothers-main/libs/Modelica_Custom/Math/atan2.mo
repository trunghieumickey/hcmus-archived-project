within Modelica_Custom.Math;

function atan2 "Four quadrant inverse tangent"
  extends Modelica.Math.Icons.AxisCenter;
  input Real u1 "First independent variable";
  input Real u2 "Second independent variable";
  output Modelica.Units.SI.Angle y "Dependent variable y=atan2(u1, u2)=atan(u1/u2)";

external "builtin" y = atan2(u1, u2);
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
        Line(points={{0,-80},{8.93,-67.2},{17.1,-59.3},{27.3,-53.6},{42.1,-49.4},
              {69.9,-45.8},{80,-45.1}}),
        Line(points={{-80,-34.9},{-46.1,-31.4},{-29.4,-27.1},{-18.3,-21.5},{-10.3,
              -14.5},{-2.03,-3.17},{7.97,11.6},{15.5,19.4},{24.3,25},{39,30},{
              62.1,33.5},{80,34.9}}),
        Line(points={{-80,45.1},{-45.9,48.7},{-29.1,52.9},{-18.1,58.6},{-10.2,
              65.8},{-1.82,77.2},{0,80}}),
        Text(
          extent={{-90,-46},{-18,-94}},
          textColor={192,192,192},
          textString="atan2")}),
    Documentation(info="<html>
<p>
This function returns y = atan2(u1,u2) such that tan(y) = u1/u2 and
y is in the range -pi &lt; y &le; pi. u2 may be zero, provided
u1 is not zero. Usually u1, u2 is provided in such a form that
u1 = sin(y) and u2 = cos(y):
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan2.png\">
</p>

</html>"));
end atan2;
