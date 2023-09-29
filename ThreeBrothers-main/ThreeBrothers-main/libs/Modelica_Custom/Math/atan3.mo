within Modelica_Custom.Math;

function atan3
  "Four quadrant inverse tangent (select solution that is closest to given angle y0)"
  import Modelica.Constants.pi;
  extends Modelica.Math.Icons.AxisCenter;
  input Real u1 "First independent variable";
  input Real u2 "Second independent variable";
  input Modelica.Units.SI.Angle y0=0 "y shall be in the range: -pi < y-y0 <= pi";
  output Modelica.Units.SI.Angle y "Dependent variable y=atan3(u1, u2, y0)=atan(u1/u2)";

protected
  constant Real pi2=2*pi;
  Real w;
algorithm
  w := Math.atan2(u1, u2);
  if y0 == 0 then
    // For the default (y0 = 0), exactly the same result as with atan2(..) is returned
    y := w;
  else
    /* -pi < y - y0 <= pi
       -pi < w + 2*pi*N - y0 <= pi
       (-pi+y0-w)/(2*pi) < N <= (pi+y0-w)/(2*pi)
       -> N := integer( (pi+y0-w)/(2*pi) )
    */
    y := w + pi2*integer((pi+y0-w)/pi2);
  end if;
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
          textString="atan3")}),
    Documentation(info="<html>
<p>
This function returns y = <strong>atan3</strong>(u1,u2,y0) such that
<strong>tan</strong>(y) = u1/u2 and
y is in the range: -pi &lt; y-y0 &le; pi.<br>
u2 may be zero, provided u1 is not zero. The difference to
Modelica.Math.atan2(..) is the optional third argument y0 that
allows to specify which of the infinite many solutions
shall be returned:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan3.png\">
</p>

<p>
Note, for the default case (y0=0), exactly the same result as with atan2(..)
is returned.
</p>
</html>"));
end atan3;
