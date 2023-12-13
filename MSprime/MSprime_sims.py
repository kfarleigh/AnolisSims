import msprime
import numpy as np 

###################### Anolis MD Reference Simulations #############################################################

# Set the inferred history from Moments
demography = msprime.Demography()
# Set all of our populations
demography.add_population(name="Pulchellus_Hybrids_Krugi", initial_size=200_001)
demography.add_population(name="Pulchellus_Hybrids", initial_size=32_540)
demography.add_population(name="Krugi", initial_size=133_621)
demography.add_population(name="Pulchellus", initial_size=27_400)
demography.add_population(name="Hybrids", initial_size=23_000)

# Convert divergence times into generations, its time/generation time. Estimated generation time for Anolis is 1 yr
T_PH_K = 1290598/1 #Time/generation time
T_P_H = 986341/1

# Add the splits 
demography.add_population_split(time=T_P_H, derived=["Pulchellus", "Hybrids"], ancestral="Pulchellus_Hybrids")
demography.add_population_split(time=T_PH_K, derived=["Pulchellus_Hybrids", "Krugi"], ancestral="Pulchellus_Hybrids_Krugi")

# Set migration rates
demography.set_migration_rate("Pulchellus", "Hybrids", 0.00003) # Hybrids moving into pulchellus
demography.set_migration_rate("Hybrids", "Pulchellus", 0.00007) # Pulchellus into hybrids 
demography.set_migration_rate("Hybrids", "Krugi", 0.0005) # Krugi into hybrids
demography.set_migration_rate("Krugi", "Hybrids", 0.000009) # Hybrids into krugi

# Check to make sure it looks correct
#demography.debug()
#print(demography.debug())

# Another check
#print(demography)

# Set the sampling scheme (how many individuals are sampled per population


n_loci =  500

ind_names = ["K" + str(i) for i in range(25)] + ["P" + str(i) for i in range(25)] + ["H" + str(i) for i in range(23)]

for i in range(n_loci):
    ts = msprime.sim_ancestry({"Krugi": 25, "Pulchellus": 25, "Hybrids": 23}, ploidy=2, demography=demography, sequence_length = 100, recombination_rate=1e-8) 
    
    tsm = msprime.sim_mutations(ts, rate=2.1e-10)
 
    with open("output" + str(i) + ".vcf", "w") as vcf_file:
        tsm.write_vcf(vcf_file, individual_names=ind_names)

