% Adds new vehicle and manufaturer to the knowledge base.
newVehicle(Manufacturer, vehicle(Brand, Model, Style, Cylinder, Autonomy)):-
    asserta(vehicle(Brand, Model, Style, Cylinder, Autonomy)),
    assertz(manufacturer(Manufacturer, vehicle(Brand, Model, Style, Cylinder, Autonomy))).

% Relates two models.
relate(Manufacturer, Model1, Model2):-
    assertz(related(Manufacturer, Model1, Model2)).

% Cheks if a vehicle is eco-friendly.
isEco(Manufacturer, Model):-
    manufacturer(Manufacturer, vehicle(_, Model, sedan, Cylinder, Autonomy)),
    Cylinder < 2000,
    Autonomy > 500.
isEco(Manufacturer, Model):-
    manufacturer(Manufacturer, vehicle(_, Model, cross, Cylinder, Autonomy)),
    Cylinder < 2500,
    Autonomy > 450.
isEco(Manufacturer, Model):-
    manufacturer(Manufacturer, vehicle(_, Model, pickup, Cylinder, Autonomy)),
    Cylinder < 3000,
    Autonomy > 650.

% Checks if a model is base.
isBase(Manufacturer, Model):-
    not(related(Manufacturer, _, Model)).

% Checks if a model is the last.
isFinal(Manufacturer, Model):-
    not(related(Manufacturer, Model, _)).

% Checks if a model is intermediate.
isIntermediate(Manufacturer, Model):-
    not(isBase(Manufacturer, Model)),
    not(isFinal(Manufacturer, Model)).

% Get amount of models per manufaturer.
totalProduction(Manufacturer, Total):-
    findall(manufacturer(_,_), manufacturer(Manufacturer, _), List),
    length(List, Total).

% Gets a list of brands per manufacturer.
getBrands(Manufacturer, Brand):-
    manufacturer(Manufacturer, vehicle(Brand, _, _, _,_)).

%Checks if a manufacuturer is a conglomerate.
isConglomerate(Manufacturer):-
    findall(getBrands(_,_), getBrands(Manufacturer, _), List),
    sort(List, Sorted),
    length(Sorted, Length), Length >= 2.

% Show vehicle information.
showVehicle(Manufacturer, Model):-
    manufacturer(Manufacturer, vehicle(Brand, Model, Style, Cylinder, Autonomy)),
    write('Marca: ' ), write(Brand), nl,
    write('Modelo: ' ), write(Model), nl,
    write('Estilo: ' ), write(Style), nl,
    write('Cilindraje: '), write(Cylinder), nl,
    write('Autonomia: '), write(Autonomy), false; true.