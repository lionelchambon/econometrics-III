* Monte Carlo Simulation

clear all
set obs 1000

* Define the program for the simulation
program define montecarlo_simulation, rclass
    * Generate a uniform random variable
    drop _all
    set obs 1000
    gen u = runiform(0,1)
    
    * Summarize the variable u to get the sum and max
    quietly summarize u, detail
    
    * Store sum and max values in scalars
    scalar mean_y = r(mean)
    scalar max_u = r(max)
    
    * Method of moments estimator
    return scalar theta_hat_mm = (mean_y * 2)
    
    * Maximum likelihood estimator
    return scalar theta_hat_ml = max_u
end

* Run the simulation with 1000 repetitions
simulate theta_hat_mm=r(theta_hat_mm) theta_hat_ml=r(theta_hat_ml), reps(1000): montecarlo_simulation

* Summarize the results
summarize theta_hat_mm theta_hat_ml


