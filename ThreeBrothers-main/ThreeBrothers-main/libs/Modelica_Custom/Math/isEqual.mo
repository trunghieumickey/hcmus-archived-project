within Modelica_Custom.Math;

function isEqual "Determine if two Real scalars are numerically identical"
  extends Modelica.Icons.Function;
  input Real s1 "First scalar";
  input Real s2 "Second scalar";
  input Real eps(min=0) = 0
    "The two scalars are identical if abs(s1-s2) <= eps";
  output Boolean result "= true, if scalars are identical";
algorithm
  result := abs(s1 - s2) <= eps;
  annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Math.<strong>isEqual</strong>(s1, s2);
Math.<strong>isEqual</strong>(s1, s2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Math.isEqual(s1, s2)</code>\" returns <strong>true</strong>,
if the two Real scalars s1 and s2 are identical. Otherwise the function
returns <strong>false</strong>. The equality check is performed by
\"abs(s1-s2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real s1 = 2.0;
  Real s2 = 2.0;
  Real s3 = 2.000001;
  Boolean result;
<strong>algorithm</strong>
  result := Math.isEqual(s1,s2);     // = <strong>true</strong>
  result := Math.isEqual(s1,s3);     // = <strong>false</strong>
  result := Math.isEqual(s1,s3,0.1); // = <strong>true</strong>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>,
<a href=\"modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</p>
</html>"));
end isEqual;
