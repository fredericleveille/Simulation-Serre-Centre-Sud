##Simulation Serre Centre-Sud
##First file origins
This folder traces the steps et versions of the simulation of the Greenhouse in South-Center borrough in Montreal. First version is set from the modified version 18 of the model. 
The modified version (by Maxime) corrected the problem of multi surfaces that weren't used (problem with surface matching extension). 
The model was then modified with a on/off gaz heater (instead of a furnace).

##Next steps
Now the objetive is to model a cooling system that can control temperature and humidification. 
The first commits will be to run the model without crashing. There will be usefull to select wich files will be tracked for the rests of the modeling (outputs and .som files)
Then a new branch with only cooling system could be tested before tryin to "merge" colling and Vnat to reduce energy consumption.
A branch could be made to investigate the plants loads as well.
Ideally there would be a python program to visualise outputs after each simulation, but I probably won't have enough time to look this up.

