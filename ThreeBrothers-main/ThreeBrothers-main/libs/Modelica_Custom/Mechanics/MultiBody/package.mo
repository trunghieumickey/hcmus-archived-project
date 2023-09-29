within Modelica_Custom.Mechanics;

package MultiBody "Library to model 3-dimensional mechanical systems"
  extends Modelica.Icons.Package;
  import Cv = Modelica.Units.Conversions;
  import C = Modelica.Constants;
  annotation(
    Documentation(info = "<html>
<p>
Library <strong>MultiBody</strong> is a <strong>free</strong> Modelica package providing
3-dimensional mechanical components to model in a convenient way
<strong>mechanical systems</strong>, such as robots, mechanisms, vehicles.
Typical animations generated with this library are shown
in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/MultiBody.png\">
</p>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide\">MultiBody.UsersGuide</a>
     discusses the most important aspects how to use this library.</li>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples\">MultiBody.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(points = {{-58, 76}, {6, 76}, {-26, 50}, {-58, 76}}, lineColor = {95, 95, 95}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Line(points = {{-26, 50}, {28, -50}}), Ellipse(extent = {{-4, -14}, {60, -78}}, lineColor = {135, 135, 135}, fillPattern = FillPattern.Sphere, fillColor = {255, 255, 255})}));
end MultiBody;
