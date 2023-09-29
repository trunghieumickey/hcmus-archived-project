within Modelica_Custom.Electrical.Analog;

package Semiconductors "Semiconductor devices such as diode, MOS and bipolar transistor"
  extends Modelica.Icons.Package;
  import Modelica.Constants.k "Boltzmann's constant, [J/K]";
  import Modelica.Constants.q "Electron charge, [As]";
protected
public
  annotation(
    Documentation(info = "<html>
<p>This package contains semiconductor devices:</p>
<ul>
<li>diode</li>
<li>MOS transistors</li>
<li>bipolar transistors</li>
<li>thyristor</li>
<li>triac</li>
</ul>
<p>Most of the semiconductor devices contain a conditional heat port, which is not active by default. If it is active the loss power is calculated to be used in a thermal net. The heating variants of the semiconductor devices are provided to use the thermal port temperature in the electric calculation. That means that for a true thermal electric interaction the heating device models have to be used.</p>
</html>", revisions = "<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
</dl>
</html>"),
    Icon(graphics = {Line(points = {{-20, 0}, {-90, 0}}), Line(points = {{-20, 60}, {-20, -60}}), Line(points = {{20, 68}, {-20, 28}}), Line(points = {{80, 68}, {20, 68}}), Line(points = {{-20, -30}, {20, -70}}), Line(points = {{20, -70}, {80, -70}})}));
end Semiconductors;
