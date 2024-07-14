% Definindo probabilidades marginais
0.95::street_condition(dry).
0.2::street_condition(wet).
0.01::street_condition(snow_covered).

0.4::flywheel_worn_out.

0.98::light_bulb_ok.

0.85::cable_ok.

% Definindo probabilidades condicionais
0.03::dynamo_sliding :- street_condition(dry), flywheel_worn_out.
0.01::dynamo_sliding :- street_condition(dry), \+flywheel_worn_out.
0.4::dynamo_sliding :- street_condition(wet), flywheel_worn_out.
0.06::dynamo_sliding :- street_condition(wet), \+flywheel_worn_out.
0.98::dynamo_sliding :- street_condition(snow_covered), flywheel_worn_out.
0.5::dynamo_sliding :- street_condition(snow_covered), \+flywheel_worn_out.

0.8::dynamo_shows_voltage :- dynamo_sliding.
0.2::dynamo_shows_voltage :- \+dynamo_sliding.

% Consultando a probabilidade
query(dynamo_shows_voltage).
evidence(street_condition(snow_covered)).