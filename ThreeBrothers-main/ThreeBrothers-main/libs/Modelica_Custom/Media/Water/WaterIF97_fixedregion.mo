within Modelica_Custom.Media.Water;

partial package WaterIF97_fixedregion
  "Water: Steam properties as defined by IAPWS/IF97 standard, fixed region"
  extends WaterIF97_base(Region(min=1)=1);
end WaterIF97_fixedregion;