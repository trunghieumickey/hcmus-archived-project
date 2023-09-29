within Modelica_Custom;

package Fluid "Library of 1-dim. thermo-fluid flow models using the Modelica.Media media description"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Cv = Modelica.Units.Conversions;
  annotation(
    Icon(graphics = {Polygon(points = {{-70, 26}, {68, -44}, {68, 26}, {2, -10}, {-70, -42}, {-70, 26}}), Line(points = {{2, 42}, {2, -10}}), Rectangle(extent = {{-18, 50}, {22, 42}}, fillPattern = FillPattern.Solid)}),
    preferredView = "info",
    Documentation(info = "<html>
<p>
Library <strong>Modelica.Fluid</strong> is a <strong>free</strong> Modelica package providing components for
<strong>1-dimensional thermo-fluid flow</strong> in networks of vessels, pipes, fluid machines, valves and fittings.
A unique feature is that the component equations and the media models
as well as pressure loss and heat transfer correlations are decoupled from each other.
All components are implemented such that they can be used for
media from the Modelica.Media library. This means especially that an
incompressible or compressible medium, a single or a multiple
substance medium with one or more phases might be used.
</p>

<p>
In the next figure, several features of the library are demonstrated with
a simple heating system with a closed flow cycle. By just changing one configuration parameter in the system object the equations are changed between steady-state and dynamic simulation with fixed or steady-state initial conditions.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/HeatingSystem.png\" border=\"1\"
     alt=\"HeatingSystem.png\">
</p>

<p>
With respect to previous versions, the design
of the connectors has been changed in a non-backward compatible way,
using the recently developed concept
of stream connectors that results in much more reliable simulations
(see also <a href=\"modelica://Modelica/Resources/Documentation/Fluid/Stream-Connectors-Overview-Rationale.pdf\">Stream-Connectors-Overview-Rationale.pdf</a>).
This extension was included in Modelica 3.1.
</p>

<p>
The following parts are useful, when newly starting with this library:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Fluid.UsersGuide\">Modelica.Fluid.UsersGuide</a>.</li>
<li> <a href=\"modelica://Modelica.Fluid.UsersGuide.ReleaseNotes\">Modelica.Fluid.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"modelica://Modelica.Fluid.Examples\">Modelica.Fluid.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
Copyright &copy; 2002-2020, Modelica Association and contributors
</p>
</html>"));
end Fluid;
