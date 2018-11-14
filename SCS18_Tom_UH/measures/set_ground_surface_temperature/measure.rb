# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/reference/measure_writing_guide/

# start the measure
class SetGroudSurfaceTemperature < OpenStudio::Ruleset::ModelUserScript

  # human readable name
  def name
    return "Set ground surface temperature"
  end

  # human readable description
  def description
    return "This measure sets the groundsurfacetemperature to a value defined by the user
"
  end

  # human readable description of modeling approach
  def modeler_description
    return ""
  end

  # define the arguments that the user will input
  def arguments(model)
    args = OpenStudio::Ruleset::OSArgumentVector.new
	
	#make arguments for ground temperatures
	jgt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('jgt',true)
	jgt.setDisplayName('January ground temperature (C)')
	jgt.setDefaultValue(13.0)
	args << jgt
	
	fgt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('fgt',true)
	fgt.setDisplayName('February ground temperature (C)')
	fgt.setDefaultValue(13.0)	
	args << fgt
	
	margt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('margt',true)
	margt.setDisplayName('March ground temperature (C)')
	margt.setDefaultValue(13.0)	
	args << margt
	
	apgt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('apgt',true)
	apgt.setDisplayName('April ground temperature (C)')
	apgt.setDefaultValue(13.0)	
	args << apgt
	
	magt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('magt',true)
	magt.setDisplayName('May ground temperature (C)')
	magt.setDefaultValue(13.0)	
	args << magt
	
	jungt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('jungt',true)
	jungt.setDisplayName('June ground temperature (C)')
	jungt.setDefaultValue(13.0)	
	args << jungt

	julgt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('julgt',true)
	julgt.setDisplayName('July ground temperature (C)')
	julgt.setDefaultValue(13.0)	
	args << julgt
	
	aggt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('aggt',true)
	aggt.setDisplayName('August ground temperature (C)')
	aggt.setDefaultValue(13.0)	
	args << aggt
   
	sgt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('sgt',true)
	sgt.setDisplayName('September ground temperature (C)')
	sgt.setDefaultValue(13.0)	
	args << sgt
	
	ogt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('ogt',true)
	ogt.setDisplayName('October ground temperature (C)')
	ogt.setDefaultValue(13.0)	
	args << ogt
	
	ngt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('ngt',true)
	ngt.setDisplayName('November ground temperature (C)')
	ngt.setDefaultValue(13.0)	
	args << ngt
	
	dgt = OpenStudio::Ruleset::OSArgument::makeDoubleArgument('dgt',true)
	dgt.setDisplayName('December ground temperature (C)')
	dgt.setDefaultValue(13.0)	
	args << dgt
   
   
    return args
  end

  # define what happens when the measure is run
  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end

    # assign the user inputs to variables
    jgt = runner.getDoubleArgumentValue('jgt', user_arguments)
	fgt = runner.getDoubleArgumentValue('fgt', user_arguments)
	margt = runner.getDoubleArgumentValue('margt', user_arguments)
	apgt = runner.getDoubleArgumentValue('apgt', user_arguments)
	magt = runner.getDoubleArgumentValue('magt', user_arguments)
	jungt = runner.getDoubleArgumentValue('jungt', user_arguments)
	julgt = runner.getDoubleArgumentValue('julgt', user_arguments)
	aggt = runner.getDoubleArgumentValue('aggt', user_arguments)
	sgt = runner.getDoubleArgumentValue('sgt', user_arguments)
	ogt = runner.getDoubleArgumentValue('ogt', user_arguments)
	ngt = runner.getDoubleArgumentValue('ngt', user_arguments)
	dgt = runner.getDoubleArgumentValue('dgt', user_arguments)
	
	

    # check the gt for reasonableness
    if jgt < -50 or jgt > 50 #error on impossible values
      runner.registerError("ground temperature must be greater than -50 et less than 50")
      return false
    end
	
	# get ground temperature object    
	ground_temps = model.getSiteGroundTemperatureBuildingSurface
	#set monthly temperature
	temps_array = [jgt,fgt,margt,apgt,magt,jungt,julgt,aggt,sgt,ogt,ngt,dgt]	
	temps_array.each_with_index do |temp,index|
		ground_temps.setTemperatureByMonth(index+1,temp)
	end
	

    # report initial condition of model
    #runner.registerInitialCondition("The building started with #{model.getSpaces.size} spaces.")
	
    # add a new space to the model
    #new_space = OpenStudio::Model::Space.new(model)
    #new_space.setName(space_name)


    # echo the new space's name back to the user
    #runner.registerInfo("Space #{new_space.name} was added.")

    # report final condition of model
    #runner.registerFinalCondition("The building finished with #{model.getSpaces.size} spaces.")

    return true

  end
  
end

# register the measure to be used by the application
SetGroudSurfaceTemperature.new.registerWithApplication
