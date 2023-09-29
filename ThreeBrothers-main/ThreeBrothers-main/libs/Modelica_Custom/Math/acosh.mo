within Modelica_Custom.Math;

function acosh "Inverse of cosh (area hyperbolic cosine)"
  extends Modelica.Math.Icons.AxisLeft;
  input Real u "Independent variable";
  output Real y "Dependent variable y=acosh(u)";

algorithm
  assert(u >= 1.0, "Input argument u (= " + String(u) +
    ") of acosh(u) must be >= 1.0");
  y := Modelica.Math.log(u + sqrt(u*u - 1));
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
        Line(points={{-66,-80},{-65.2,-66},{-64.4,-60.3},{-62.8,-52.2},{-60.4,-43.4},
              {-56.4,-32.4},{-49.9,-19.3},{-41.1,-5.65},{-29,8.8},{-12.9,23.8},
              {7.97,39.2},{35.3,55},{69.9,70.8},{94,80}}),
        Text(
          extent={{-14,2},{76,-54}},
          textColor={192,192,192},
          textString="arcosh")}),
    Documentation(info="<html>
<p>
This function returns the area hyperbolic cosine of its
input argument u. The valid range of u is
</p>
<blockquote><pre>
+1 &le; u &lt; +&infin;
</pre></blockquote>
<p>
If the function is called with u &lt; 1, an error occurs.
The function cosh(u) has two inverse functions (the curve
looks similar to a sqrt(..) function). acosh(..) returns
the inverse that is positive. At u=1, the derivative dy/du is infinite.
Therefore, this function should not be used in a model, if u
can become close to 1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/acosh.png\">
</p>
</html>"));
end acosh;
