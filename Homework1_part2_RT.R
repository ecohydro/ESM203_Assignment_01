
# Homework 1
# Part II. Solving surface energy balance (questions 1-3)

# install package to solve equation and load it 
install.packages('rootSolve')
library(rootSolve)

# Step 1. Define your variables here 

### Environmental Conditions 
# ambient temp in Celsius 
T_a = 28
# stefan-boltzmann constant [W/m^2/K^4]
sigma = 5.67*10^-8
# incoming shortwave radiation [W/m^2]
K_inc = 800
# Relative humidity of atmosphere, [0-1]
RH = 0.4
# sensible heat conductivity [W/T/m2]
k_H = 21
# latent heat conductivity [W/kPa/m2] 
k_E = 100

### Surface Conditions
# Relative humidity of the surface 
RH_s = 1
# albedo 
alpha = 0.75 
# emissivity 
eps = 0.93

### Equations - note that these will change for each surface 
# incoming longwave radiation [W/m^2]
# use the other variables and Eq.4
L_inc  = 0.9*sigma*(T_a+273.15)^4

# available energy [W/m^2] 
# use the other variables and Eq.12
Q_av  = 0.9*((1-alpha)*K_inc + L_inc)



# Step 2. Run the function to solve for the surface temperature 
# Eq.15 
# temperature (in Celsius) is represented as x 
solve_temp <- function(x){ 
  Q_e =  k_E*(RH_s*0.61078*exp((17.27*x)/(x+237.3)) - 
                RH*0.61078*exp((17.27*T_a)/(T_a+237.3)))
  LE = ifelse(Q_e > 0, Q_e, 0)
  solve = -Q_av + 
    eps*sigma*(x+273.15)^4 +
    LE + 
    k_H*(x-T_a)
  return(solve)

}

# solve function for temp, within the set range 
range = c(0,100) # range of reasonable temperatures 

# uniroot.all is a function that finds the root of an equation within an interval; to see more info, type ?uniroot.all into your console
# solve_temp is the function, and range is the interval to search through
temp_s = uniroot.all(solve_temp, range) 
# surface temperature
temp_s



# Next, go back and redefine your variables (albedo, emissivity, surface relative humidity, etc.) depending on your surface and what the question is asking. Then rerun the function to see how the surface temperature changes. 

Q_e =  k_E*(RH_s*0.61078*exp((17.27*T_s)/(T_s+237.3)) - 
              RH*0.61078*exp((17.27*T_a)/(T_a+237.3)))
