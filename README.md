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

##RTPU
Rooftop packaged unit didn't change much of the gaz consumption. 2.04E+11 vs 2.10E+11 for model withou it.
Temperature were better controled during summer.
However, it consumed way much more electricity. 39283.33 kWh vs 4318.97 kWh. 8 times more.
RHwas between 30 and 70%. So no need to control humidity without plants loads.

##Plants loads
A xlsx file was created to Look for sensible and latent heat according to inside conditions based on Marie-Hélène's work.
First iteration for plant loads was made with 70% RH even tho RH max was 67% without plants.
Simulation will be run to see if with those latent loads, RH would rise to values around 70% (without humidity control)
Two .csv hourly schedule were created with the fractional value calculated within the .xlsx file.

The add interval measures fail when I try to run it with "uniteless" units.
I'll try to run units in watts and force it as a schedule...But I still got the same problem...
So the problem seems to be with encoding the data. It seems that becaus of the language of my system (french) I can't encode correctly in US.UTF-8.
One option is to modify system language in the command console. 
Another option that seems to work is to convert the .csv file generated from excel with NotePad++.

With working sensible and latent loads we can see an augmentation in cooling energy. 1.4142e+11 vs 2.26811e+11 now. Less than rwo times higher.
Heanting was also higher 2.0456e+11 vs 7.31179e+11. So more than 3 times higher
We can also see tha RH is almost always at 100% sinc we don't have any control on humidity.

##Humidity control
Next step is to try to control humidity with the RTPU, at the same time as controling temperature.
If everything works fine, I could redoo the plants load calculation for a 80% RH control.

Trying to run simply with humid and dehumid schedule.
No impact on humidity crontol. Seems I need sensor or control or something like that. 
Trying to add max humidity sensor at the output of the cooling coil.

I was able to control approximatly well the RH with a DX dehumidifier sized for nearly max capacity.
Now remains only to plot system different component consumption Electric (cooling and dehum) and gaz (heating)

Problem to investigate: why do I have so much heating during summer...

##Investigating Energy consumption
Zone Mechanical Ventilation Mass Flow Rate = 0 all year
Zone Ventilation Mass Flow Rate varies all year.Mainly closed, but otherwis between 0 and 2 kg/s It should be, according to E+ Doc the natural ventilation. 
Where can I found ventilation for the system with Dx Cooling coil?
There's not that much heating during summer. The problem is that I have heating functionning during the day...
Also, Temperature seems lower during summer than winter...maybe because of the control type on the cooling coil that sets duct temperatur at 14C
I can either change the control type to investigate or try scheduling no avaibility for heating during sumer to see the impact.
I'll try first to change the setpoint temperature for the cooling coil to the setpoint of the greenhouse and see the effect.
When modifying cooling temperature setpoint to a higher valu (GH vs 14) the cooling coil works a lot less but natural ventilation and heating are higher.
Outside temperature for summmer are kind of low. Max value is 26C. If sensible cooling by plant is high and ther is a lot of nat vent that could explain the need for heating.
I Thnik that plants sensible loads are si high (or low because in the negative) during summer that we need heating. 
I'll try modifying the heating avaibility schedule to see the effect.

So Even with heating off during summer, inside temperature, nat vent and cooling power doesn't change much.
Seems that the control might be a little be aggressive on the Heater Unit. I could try looking into it or just keep it that way with scheduled avaibility.
I could try adding april and septembre to the non avaibility.
I really think systems are working against each other during summer because of their control type.
 I'm not sure control by aticipated load of the heater unit takes into account sensible heating by DX dehumidifier and/or other equipment.
 Temperature are negligibly lower when turning off heating, but heating consumption is way under...where does all this heat go then?

 Temperature doesn't change with no heating avaibility from april to september. Only Nat vent seems to be a little higher...
