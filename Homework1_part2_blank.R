
# Homework 1
# Part II. Solving surface energy balance 
# (Questions 1-3)

# install package to solve equation and load it 
install.packages('rootSolve')
library(rootSolve)

# Step 1. Define your variables here 

### Environmental Conditions 

# atm temp in Celsius 
T_a =
# stefan-boltzmann constant [W/m^2/K^4]
sigma = 
# incoming shortwave radiation [W/m^2]
K_inc = 
# Relative humidity of atmosphere, [0-1]
RH = 
# sensible heat conductivity [W/T/m2]
k_H = 
# latent heat conductivity [W/kPa/m2] 
k_E = 

### Surface Conditions
  
# Relative humidity of the surface 
RH_s = 
# albedo 
alpha = 
# emissivity 
eps = 

### Equations - 
### NOTE: THESE WILL CHANGE FOR EACH SURFACE; YOU WILL NEED TO RERUN 
  
# incoming longwave radiation [W/m^2]
# use the other variables and Eq.4
L_inc  = 

# available energy [W/m^2] 
# use the other variables and Eq.12
Q_av  = 



# Step 2. Run the function to solve for the surface temperature using Eq. 15
  ## NOTE: you will only need to run this once, and it should show up in your Global Environment pane under Functions 
  ## DO NOT EDIT INSIDE THE FUNCTION 

# temperature (in Celsius) is represented as x 
solve_temp <- function(x){ 
  # set up Latent energy 
  Q_e =  k_E*(RH_s*0.61078*exp((17.27*x)/(x+237.3)) - 
                RH*0.61078*exp((17.27*T_a)/(T_a+237.3)))
  LE = ifelse(Q_e > 0, Q_e, 0)
  
  # solve Eq. 15 
  solve = Q_av - 
    k_H*(x-T_a) - 
    LE -
    eps*sigma*(x+273.15)^4
  return(solve)

}

# solve function for temp, within the set range 
range = c(0,100) # range of reasonable temperatures 

# uniroot.all is a function that finds the root of an equation within an interval; to see more info, type ?uniroot.all into your console

# solve_temp is the function, and range is the interval to search through
temp_s = uniroot.all(solve_temp, range) 

# surface temperature - this is your answer! yay! 
temp_s


# READ THIS:
# Next, go back and redefine your variables (albedo, emissivity, surface relative humidity, etc.) depending on your surface and what the question is asking. Once you have redefined the variables, you should also rerun the equations in lines 38 and 42. Then rerun line 72 to solve for temp_s and line 75 to see how your temperature has changed. 


