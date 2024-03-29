within Arduino.Internal;
class ModelicaFunctions
  extends ExternalObject;

  function constructor "Function that call the external constructor"
    output ModelicaFunctions functions;

    external "C" functions = ModelicaUtilityFunctions_getModelicaUtilityFunctions() annotation (
      Include = "#include \"ModelicaUtilityFunctions.c\"",
      IncludeDirectory="modelica://Arduino/Resources/Include");
  end constructor;

  function destructor
    input ModelicaFunctions functions;
  external "C" ModelicaUtilityFunctions_freeModelicaUtilityFunctions(functions) annotation (
      Include = "#include \"ModelicaUtilityFunctions.c\"",
      IncludeDirectory="modelica://Arduino/Resources/Include");
  end destructor;

  annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0)}));
end ModelicaFunctions;
