within Modelica_Custom.Math;

package Vectors "Library of functions operating on vectors"
  extends Modelica.Icons.Package;

  function toString "Convert a real vector in to a string representation"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Strings;

    input Real v[:] "Real vector";
    input String name="" "Independent variable name used for printing";
    input Integer significantDigits=6
      "Number of significant digits that are shown";
    output String s="";
  protected
    String blanks=Strings.repeat(significantDigits);
    String space=Strings.repeat(8);
    Integer r=size(v, 1);

  algorithm
    if r == 0 then
      s := if name == "" then "[]" else name + " = []";
    else
      s := if name == "" then "\n" else "\n" + name + " = \n";
      for i in 1:r loop
        s := s + space;

        if v[i] >= 0 then
          s := s + " ";
        end if;
        s := s + String(v[i], significantDigits=significantDigits) +
          Strings.repeat(significantDigits + 8 - Strings.length(String(abs(v[i]))));

        s := s + "\n";
      end for;

    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>toString</strong>(v);
Vectors.<strong>toString</strong>(v,name=\"\",significantDigits=6);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>toString</strong>(v)</code>\" returns the string representation of vector <strong>v</strong>.
With the optional arguments \"name\" and \"significantDigits\" a name and the number of the digits are defined.
The default values of \"name\" and \"significantDigits\" are \"\" and 6 respectively. If name==\"\" (empty string) then the prefix \"&lt;name&gt; =\" is left out at the output-string.
</p>
<h4>Example</h4>
<blockquote><pre>
v = {2.12, -4.34, -2.56, -1.67};
<strong>toString</strong>(v);
                       // = \"
                       //           2.12
                       //          -4.34
                       //          -2.56
                       //          -1.67\"
<strong>toString</strong>(v,\"vv\",1);
                       // = \"vv =
                       //           2
                       //          -4
                       //          -3
                       //          -2\"
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.toString\">Matrices.toString</a>,
</p>
</html>", revisions="<html>

</html>"));
  end toString;

  function isEqual "Determine if two Real vectors are numerically identical"
    extends Modelica.Icons.Function;
    input Real v1[:] "First vector";
    input Real v2[:] "Second vector (may have different length as v1)";
    input Real eps(min=0) = 0
      "Two elements e1 and e2 of the two vectors are identical if abs(e1-e2) <= eps";
    output Boolean result
      "= true, if vectors have the same length and the same elements";

  protected
    Integer n=size(v1, 1) "Dimension of vector v1";
    Integer i=1;
  algorithm
    result := false;
    if size(v2, 1) == n then
      result := true;
      while i <= n loop
        if abs(v1[i] - v2[i]) > eps then
          result := false;
          i := n;
        end if;
        i := i + 1;
      end while;
    end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>isEqual</strong>(v1, v2);
Vectors.<strong>isEqual</strong>(v1, v2, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.isEqual(v1, v2)</code>\" returns <strong>true</strong>,
if the two Real vectors v1 and v2 have the same dimensions and
the same elements. Otherwise the function
returns <strong>false</strong>. Two elements e1 and e2 of the two vectors
are checked on equality by the test \"abs(e1-e2) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real v1[3] = {1, 2, 3};
  Real v2[4] = {1, 2, 3, 4};
  Real v3[3] = {1, 2, 3.0001};
  Boolean result;
<strong>algorithm</strong>
  result := Vectors.isEqual(v1,v2);     // = <strong>false</strong>
  result := Vectors.isEqual(v1,v3);     // = <strong>false</strong>
  result := Vectors.isEqual(v1,v1);     // = <strong>true</strong>
  result := Vectors.isEqual(v1,v3,0.1); // = <strong>true</strong>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.find\">Vectors.find</a>,
<a href=\"modelica://Modelica.Math.Matrices.isEqual\">Matrices.isEqual</a>,
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">Strings.isEqual</a>
</p>
</html>"));
  end isEqual;

  function norm "Return the p-norm of a vector"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    input Real p(min=1) = 2
      "Type of p-norm (often used: 1, 2, or Modelica.Constants.inf)";
    output Real result=0.0 "p-norm of vector v";
  protected
    Real eps = 10*Modelica.Constants.eps;
  algorithm
   if size(v,1) > 0 then
    if p >= 2-eps and p <= 2+eps then
      result := sqrt(v*v);
    elseif p >= Modelica.Constants.inf then
      result := max(abs(v));
    elseif p >= 1-eps and p <= 1+eps then
      result := sum(abs(v));
    elseif p >= 1 then
      result := (sum(abs(v[i])^p for i in 1:size(v, 1)))^(1/p);
    else
      assert(false, "Optional argument \"p\" (= " + String(p) + ") of function \"norm\" >= 1 required");
    end if;
   end if;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>norm</strong>(v);
Vectors.<strong>norm</strong>(v,p=2);   // 1 &le; p &le; &#8734;
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>norm</strong>(v)</code>\" returns the
<strong>Euclidean norm</strong> \"<code>sqrt(v*v)</code>\" of vector v.
With the optional
second argument \"p\", any other p-norm can be computed:
</p>
<center>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/vectorNorm.png\" alt=\"function Vectors.norm\">
</center>
<p>
Besides the Euclidean norm (p=2), also the 1-norm and the
infinity-norm are sometimes used:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr><td><strong>1-norm</strong></td>
      <td>= sum(abs(v))</td>
      <td><strong>norm</strong>(v,1)</td>
  </tr>
  <tr><td><strong>2-norm</strong></td>
      <td>= sqrt(v*v)</td>
      <td><strong>norm</strong>(v) or <strong>norm</strong>(v,2)</td>
  </tr>
  <tr><td><strong>infinity-norm</strong></td>
      <td>= max(abs(v))</td>
      <td><strong>norm</strong>(v,Modelica.Constants.<strong>inf</strong>)</td>
  </tr>
</table>
<p>
Note, for any vector norm the following inequality holds:
</p>
<blockquote><pre>
<strong>norm</strong>(v1+v2,p) &le; <strong>norm</strong>(v1,p) + <strong>norm</strong>(v2,p)
</pre></blockquote>
<h4>Example</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>norm</strong>(v,1);    // = 9
<strong>norm</strong>(v,2);    // = 5
<strong>norm</strong>(v);      // = 5
<strong>norm</strong>(v,10.5); // = 4.00052597412635
<strong>norm</strong>(v,Modelica.Constants.inf);  // = 4
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.norm\">Matrices.norm</a>
</p>
</html>"));
  end norm;

  function length
    "Return length of a vector (better as norm(), if further symbolic processing is performed)"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    output Real result "Length of vector v";
  algorithm
    result := sqrt(v*v);
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>length</strong>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>length</strong>(v)</code>\" returns the
<strong>Euclidean length</strong> \"<code>sqrt(v*v)</code>\" of vector v.
The function call is equivalent to Vectors.norm(v). The advantage of
length(v) over norm(v) is that function length(..) is implemented
in one statement and therefore the function is usually automatically
inlined. Further symbolic processing is therefore possible, which is
not the case with function norm(..).
</p>
<h4>Example</h4>
<blockquote><pre>
v = {2, -4, -2, -1};
<strong>length</strong>(v);  // = 5
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.norm\">Vectors.norm</a>
</p>
</html>"));
  end length;

  function normalize
    "Return normalized vector such that length = 1 and prevent zero-division for zero vector"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    input Real eps(min=0.0)=100*Modelica.Constants.eps
      "if |v| < eps then result = v/eps";
    output Real result[size(v, 1)] "Input vector v normalized to length=1";

  algorithm
    /* This function has the inline annotation. If the function is inlined:
     - "smooth(..)" defines how often the expression can be differentiated
       (if symbolic processing is performed).
  */
    result := smooth(0, if length(v) >= eps then v/length(v) else v/eps);
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>normalize</strong>(v);
Vectors.<strong>normalize</strong>(v,eps=100*Modelica.Constants.eps);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>normalize</strong>(v)</code>\" returns the
<strong>unit vector</strong> \"<code>v/length(v)</code>\" of vector v.
If length(v) is close to zero (more precisely, if length(v) &lt; eps),
v/eps is returned in order to avoid
a division by zero. For many applications this is useful, because
often the unit vector <strong>e</strong> = <strong>v</strong>/length(<strong>v</strong>) is used to compute
a vector x*<strong>e</strong>, where the scalar x is in the order of length(<strong>v</strong>),
i.e., x*<strong>e</strong> is small, when length(<strong>v</strong>) is small and then
it is fine to replace <strong>e</strong> by <strong>v</strong> to avoid a division by zero.
</p>
<p>
Since the function has the \"Inline\" annotation, it
is usually inlined and symbolic processing is applied.
</p>
<h4>Example</h4>
<blockquote><pre>
<strong>normalize</strong>({1,2,3});  // = {0.267, 0.534, 0.802}
<strong>normalize</strong>({0,0,0});  // = {0,0,0}
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>,
<a href=\"modelica://Modelica.Math.Vectors.normalize\">Vectors.normalizeWithAssert</a>
</p>
</html>"));
  end normalize;

function normalizeWithAssert
    "Return normalized vector such that length = 1 (trigger an assert for zero vector)"
  import Modelica.Math.Vectors.length;
  extends Modelica.Icons.Function;
  input Real v[:] "Real vector";
  output Real result[size(v, 1)] "Input vector v normalized to length=1";

algorithm
  assert(length(v) > 0.0, "Vector v={0,0,0} shall be normalized (= v/sqrt(v*v)), but this results in a division by zero.\nProvide a non-zero vector!");
  result := v/length(v);
  annotation (
    Inline=true,
    Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>normalizeWithAssert</strong>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>normalizeWithAssert</strong>(v)</code>\" returns the
<strong>unit vector</strong> \"<code>v/sqrt(v*v)</code>\" of vector v.
If vector v is a zero vector, an assert is triggered.
</p>
<p>
Since the function has the \"Inline\" annotation, it
is usually inlined and symbolic processing is applied.
</p>
<h4>Example</h4>
<blockquote><pre>
<strong>normalizeWithAssert</strong>({1,2,3});  // = {0.267, 0.534, 0.802}
<strong>normalizeWithAssert</strong>({0,0,0});  // error (an assert is triggered)
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.length\">Vectors.length</a>,
<a href=\"modelica://Modelica.Math.Vectors.normalize\">Vectors.normalize</a>
</p>
</html>"));
end normalizeWithAssert;

  function reverse "Reverse vector elements (e.g., v[1] becomes last element)"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector";
    output Real result[size(v, 1)] "Elements of vector v in reversed order";

  algorithm
    result := {v[end - i + 1] for i in 1:size(v, 1)};
    annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>reverse</strong>(v);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.<strong>reverse</strong>(v)</code>\" returns the
vector elements in reverse order.
</p>
<h4>Example</h4>
<blockquote><pre>
<strong>reverse</strong>({1,2,3,4});  // = {4,3,2,1}
</pre></blockquote>
</html>"));
  end reverse;

  function sort "Sort elements of vector in ascending or descending order"
    extends Modelica.Icons.Function;
    input Real v[:] "Real vector to be sorted";
    input Boolean ascending=true
      "= true, if ascending order, otherwise descending order";
    output Real sorted_v[size(v, 1)]=v "Sorted vector";
    output Integer indices[size(v, 1)]=1:size(v, 1) "sorted_v = v[indices]";

    /* shellsort algorithm; should be improved later */
  protected
    Integer gap;
    Integer i;
    Integer j;
    Real wv;
    Integer wi;
    Integer nv=size(v, 1);
    Boolean swap;
  algorithm
    gap := div(nv, 2);

    while gap > 0 loop
      i := gap;
      while i < nv loop
        j := i - gap;
        if j >= 0 then
          if ascending then
            swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
          else
            swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
          end if;
        else
          swap := false;
        end if;

        while swap loop
          wv := sorted_v[j + 1];
          wi := indices[j + 1];
          sorted_v[j + 1] := sorted_v[j + gap + 1];
          sorted_v[j + gap + 1] := wv;
          indices[j + 1] := indices[j + gap + 1];
          indices[j + gap + 1] := wi;
          j := j - gap;
          if j >= 0 then
            if ascending then
              swap := sorted_v[j + 1] > sorted_v[j + gap + 1];
            else
              swap := sorted_v[j + 1] < sorted_v[j + gap + 1];
            end if;
          else
            swap := false;
          end if;
        end while;
        i := i + 1;
      end while;
      gap := div(gap, 2);
    end while;
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
           sorted_v = Vectors.<strong>sort</strong>(v);
(sorted_v, indices) = Vectors.<strong>sort</strong>(v, ascending=true);
</pre></blockquote>
<h4>Description</h4>
<p>
Function <strong>sort</strong>(..) sorts a Real vector v
in ascending order and returns the result in sorted_v.
If the optional argument \"ascending\" is <strong>false</strong>, the vector
is sorted in descending order. In the optional second
output argument the indices of the sorted vector with respect
to the original vector are given, such that sorted_v = v[indices].
</p>
<h4>Example</h4>
<blockquote><pre>
(v2, i2) := Vectors.sort({-1, 8, 3, 6, 2});
     -> v2 = {-1, 2, 3, 6, 8}
        i2 = {1, 5, 3, 4, 2}
</pre></blockquote>
</html>"));
  end sort;

  function find "Find element in a vector"
    extends Modelica.Icons.Function;
    input Real e "Search for e";
    input Real v[:] "Real vector";
    input Real eps(min=0) = 0
      "Element e is equal to a element v[i] of vector v if abs(e-v[i]) <= eps";
    output Integer result
      "v[result] = e (first occurrence of e); result=0, if not found";
  protected
    Integer i;
  algorithm
    result := 0;
    i := 1;
    while i <= size(v, 1) loop
      if abs(v[i] - e) <= eps then
        result := i;
        i := size(v, 1) + 1;
      else
        i := i + 1;
      end if;
    end while;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>find</strong>(e, v);
Vectors.<strong>find</strong>(e, v, eps=0);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.find(e, v)</code>\" returns the index of the first occurrence of input e in vector <strong>v</strong>.
The test of equality is performed by \"abs(e-v[i]) &le; eps\", where \"eps\"
can be provided as third argument of the function. Default is \"eps = 0\".
</p>
<h4>Example</h4>
<blockquote><pre>
  Real v[3] = {1, 2, 3};
  Real e1 = 2;
  Real e2 = 3.01;
  Boolean result;
<strong>algorithm</strong>
  result := Vectors.find(e1,v);          // = <strong>2</strong>
  result := Vectors.find(e2,v);          // = <strong>0</strong>
  result := Vectors.find(e2,v,eps=0.1);  // = <strong>3</strong>
</pre></blockquote>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Vectors.isEqual\">Vectors.isEqual</a>
</p>
</html>"));
  end find;

  function interpolate "Interpolate linearly in a vector"
    extends Modelica.Icons.Function;
    input Real x[:]
      "Abscissa table vector (strict monotonically increasing values required)";
    input Real y[size(x, 1)] "Ordinate table vector";
    input Real xi "Desired abscissa value";
    input Integer iLast=1 "Index used in last search";
    output Real yi "Ordinate value corresponding to xi";
    output Integer iNew=1 "xi is in the interval x[iNew] <= xi < x[iNew+1]";
  protected
    Integer i;
    Integer nx=size(x, 1);
    Real x1;
    Real x2;
    Real y1;
    Real y2;
  algorithm
    assert(nx > 0, "The table vectors must have at least 1 entry.");
    if nx == 1 then
      yi := y[1];
    else
      // Search interval
      i := min(max(iLast, 1), nx - 1);
      if xi >= x[i] then
        // search forward
        while i < nx and xi >= x[i] loop
          i := i + 1;
        end while;
        i := i - 1;
      else
        // search backward
        while i > 1 and xi < x[i] loop
          i := i - 1;
        end while;
      end if;

      // Get interpolation data
      x1 := x[i];
      x2 := x[i + 1];
      y1 := y[i];
      y2 := y[i + 1];

      assert(x2 > x1, "Abscissa table vector values must be increasing");
      // Interpolate
      yi := y1 + (y2 - y1)*(xi - x1)/(x2 - x1);
      iNew := i;
    end if;

    annotation (smoothOrder( normallyConstant=x, normallyConstant=y)=100,
      Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
// Real    x[:], y[:], xi, yi;
// Integer iLast, iNew;
        yi = Vectors.<strong>interpolate</strong>(x,y,xi);
(yi, iNew) = Vectors.<strong>interpolate</strong>(x,y,xi,iLast=1);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Vectors.interpolate(x,y,xi)</code>\" interpolates
<strong>linearly</strong> in vectors
(x,y) and returns the value yi that corresponds to xi. Vector x[:] must consist
of monotonically increasing values. If xi &lt; x[1] or &gt; x[end], then
extrapolation takes places through the first or last two x[:] values, respectively.
If the x and y vectors have length 1, then always y[1] is returned.
The search for the interval x[iNew] &le; xi &lt; x[iNew+1] starts at the optional
input argument \"iLast\". The index \"iNew\" is returned as output argument.
The usage of \"iLast\" and \"iNew\" is useful to increase the efficiency of the call,
if many interpolations take place.
If x has two or more identical values then interpolation utilizes the x-value
with the largest index.
</p>

<h4>Example</h4>

<blockquote><pre>
  Real x1[:] = { 0,  2,  4,  6,  8, 10};
  Real x2[:] = { 1,  2,  3,  3,  4,  5};
  Real y[:]  = {10, 20, 30, 40, 50, 60};
<strong>algorithm</strong>
  (yi, iNew) := Vectors.interpolate(x1,y,5);  // yi = 35, iNew=3
  (yi, iNew) := Vectors.interpolate(x2,y,4);  // yi = 50, iNew=5
  (yi, iNew) := Vectors.interpolate(x2,y,3);  // yi = 40, iNew=4
</pre></blockquote>
</html>"));
  end interpolate;

  function relNodePositions "Return vector of relative node positions (0..1)"
    extends Modelica.Icons.Function;
    input Integer nNodes
      "Number of nodes (including node at left and right position)";
    output Real xsi[nNodes] "Relative node positions";
  protected
    Real delta;
  algorithm
    if nNodes >= 1 then
      xsi[1] := 0;
    end if;

    if nNodes >= 2 then
      xsi[nNodes] := 1;
    end if;

    if nNodes == 3 then
      xsi[2] := 0.5;
    elseif nNodes > 3 then
      delta := 1/(nNodes - 2);
      for i in 2:nNodes - 1 loop
        xsi[i] := (i - 1.5)*delta;
      end for;
    end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Vectors.<strong>relNodePositions</strong>(nNodes);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>relNodePositions(nNodes)</code>\" returns a vector
with the relative positions of the nodes of a discretized pipe with nNodes nodes (including the node
at the left and at the right side of the pipe), see next figure:
</p>

<blockquote><p>
<img src=\"modelica://Modelica/Resources/Images/Math/Vectors/relNodePositions.png\">
</p></blockquote>

<h4>Example</h4>

<blockquote><pre>
  Real xsi[7];
<strong>algorithm</strong>
  xsi = relNodePositions(7);  // xsi = {0, 0.1, 0.3, 0.5, 0.7, 0.9, 1}
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.PipeWithScalarField\">MultiBody.Visualizers.PipeWithScalarField</a>
</p>
</html>"));
  end relNodePositions;
  annotation (preferredView="info", Documentation(info="<html>
<h4>Library content</h4>
<p>
This library provides functions operating on vectors:
</p>

<ul>
<li> <a href=\"modelica://Modelica.Math.Vectors.toString\">toString</a>(v)
     - returns the string representation of vector v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.isEqual\">isEqual</a>(v1, v2)
     - returns true if vectors v1 and v2 have the same size and the same elements.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.norm\">norm</a>(v,p)
     - returns the p-norm of vector v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.length\">length</a>(v)
     - returns the length of vector v (= norm(v,2), but inlined and therefore usable in
       symbolic manipulations)</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.normalize\">normalize</a>(v)
     - returns vector in direction of v with length = 1 and prevents
       zero-division for zero vector.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.reverse\">reverse</a>(v)
     - reverses the vector elements of v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.sort\">sort</a>(v)
     - sorts the elements of vector v in ascending or descending order.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.find\">find</a>(e, v)
     - returns the index of the first occurrence of scalar e in vector v.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.interpolate\">interpolate</a>(x, y, xi)
     - returns the interpolated value in (x,y) that corresponds to xi.</li>

<li> <a href=\"modelica://Modelica.Math.Vectors.relNodePositions\">relNodePositions</a>(nNodes)
     - returns a vector of relative node positions (0..1).</li>
</ul>

<h4>See also</h4>
<a href=\"modelica://Modelica.Math.Matrices\">Matrices</a>
</html>"),
    Icon(graphics={Rectangle(
          extent={{-16,66},{14,18}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-16,-14},{14,-62}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}));
end Vectors;
