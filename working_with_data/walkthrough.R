################################################################################
# AGRICULTURAL DATA ANALYSIS WORKSHOP
# WALKTHROUGH
# Working with Data in R
################################################################################

# ==============================================================================
# SECTION A: INTRODUCTION TO R AND RSTUDIO
# ==============================================================================
# This section is mostly slides + demo of RStudio interface
# TODO: Run code in the console and in a script

# ==============================================================================
# SECTION B: WORKSHOP SETUP
# ==============================================================================
# TODO: Create a Project + open an R file

# TODO: Follow along reading in data:
# 1. Load Required Package
library("agridat")
library("dplyr")

# Explore the agridat documentation
?agridat

### pause ###

# 2. Read in our data from agridat
oats <- yates.oats
# Look at our data
View(oats)  # Open in viewer
head(oats)  # First 6 rows
str(oats)   # Structure of the data
glimpse(oats) 
summary(oats)  # Summary statistics

# ==============================================================================
# SECTION C: WORKING WITH DATA BASICS
# ==============================================================================
#  ACCESSING COLUMNS #
# How to access a column: use the dollar sign $
oats$yield      
oats$nitro
# TODO: show typing it out (helpful auto-fill)

## BASIC STAT FUNCTIONS ##
# mean(oats$yield)
# median(oats$yield)
# min(oats$yield)
# sum(oats$yield)
# length(oats$yield) #counts total values

# -->> STUDENT PROBLEM 1 

## FILTERING ##
# Select only the "Golden Rain" variety
#golden_rain <- filter(oats, gen == "GoldenRain")


# Select only observations with high nitrogen (0.6)
high_nitrogen <- filter(oats, nitro == 0.6)

# Multiple conditions - Golden Rain AND high nitrogen
# golden_high_n <- filter(oats, 
#                         gen == "GoldenRain" & nitro == 0.6)

# How many rows? Should be much fewer!
nrow(oats)
nrow(golden_high_n)


# Important operators:
# ==  equals
# !=  not equals
# >   greater than
# <   less than
# >=  greater than or equal to
# <=  less than or equal to
# &   and (both conditions must be true)
# |   or (at least one condition must be true)

# -->> STUDENT PROBLEM 2 


## CREATING NEW COLUMNS WITH MUTATE ##
# Create a new variable for yield in total lbs, not in 1/4lbs
# Original yield is in 1/4lbs (i.e. he multiplied the original weight by 4)
# oats <- mutate(oats, 
#                yield_total_lbs = yield / 4)

# Categorize Nitrogen as Above or Below Average 
oats <- mutate(oats, 
               nitrogen_category = case_when(
                 nitro >= 0.3  ~"Above Avg", 
                  T ~"Below Avg")
                )

# Create a column that calculates the difference from the average yield
oats <- mutate(oats,
               avg_nitro = mean(oats$nitro),
               diff_from_avg_nitro = nitro - avg_nitro
               )

# -->> STUDENT PROBLEM 3

### MERGING DATA ###
treatment_info <- data.frame(
  nitro = c(0, 0.2, 0.4, 0.6),
  treatment = c("Control", "Low", "Medium", "High"),
  n_kg_per_ha = c(0, 25, 50, 75)
)

treatment_info

oats <- merge(oats, treatment_info, by = "nitro")
oats

# ==============================================================================
# SECTION D: SUMMARIZING DATA
# ==============================================================================
## SIMPLE SUMMARY ##
# summarize(oats,
#           mean_yield = mean(yield),
#           max_yield = max(yield),
#           min_yield = min(yield)
#           )

## SUMMARY + GROUPING ##
# group_by(oats, gen)
# 
# summarize(group_by(oats, gen),
#           mean_yield = mean(yield),
#           max_yield = max(yield),
#           min_yield = min(yield)
# )

summarize(group_by(oats, gen, nitro),
          mean_yield = mean(yield),
          max_yield = max(yield),
          min_yield = min(yield)
)

################################################################################
# END OF INSTRUCTOR WALKTHROUGH - PART 1
################################################################################

