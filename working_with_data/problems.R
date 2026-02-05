################################################################################
# AGRICULTURAL DATA ANALYSIS WORKSHOP
# PRACTICE PROBLEMS
# Working with Data in R
################################################################################
# SETUP: Load necessary packages and data
library(agridat)
library(dplyr)

# Load the Yates Oats dataset
oats <- yates.oats
# Look at our data
View(oats)  # Open in viewer
head(oats)  # First 6 rows
str(oats)   # Structure of the data
summary(oats)  # Summary statistics


################################################################################
# PROBLEM 1: ACCESSING COLUMNS AND CALCULATING STATISTICS
################################################################################
# YOUR TURN - 1:
# What is the average nitrogen applied?
mean_nitrogen <- 

# Check your work:
mean_nitrogen
# Should be 0.3

# YOUR TURN - 2:
# Calculate the minimum and maximum yield values
# Hint: you may need to google functions we didn't go over
max_yield <- 
min_yield <-

# YOUR TURN - 3:
# How many observations are there?
num_obs <- 
  
################################################################################
# PROBLEM 2: FILTERING DATA
################################################################################
  # Important operators:
  # ==  equals
  # !=  not equals
  # >   greater than
  # <   less than
  # >=  greater than or equal to
  # <=  less than or equal to
  # &   and (both conditions must be true)
  # |   or (at least one condition must be true)

## YOUR TURN - Part A:
# Filter the oats data to include ONLY observations where nitrogen is above average
oats_medium_n <- 

# YOUR TURN - Part B:
# Filter the oats data to include ONLY the "Marvellous" variety
# Save as "oats_marvellous"
oats_marvellous <- 
  
# YOUR TURN - Part C (Challenge):
# Filter to show ONLY observations where EITHER straw is above average OR 
# grain is above average
high_straw_or_grain_plots <-
  
# YOUR TURN - Part D (Challenge):
# What is the average yield of the "Victory" variety when nitrogen is ABOVE average?
# What is the average yield of the "Victory" variety when nitrogen is BELOW average?
  
  
################################################################################
# PROBLEM 3: CREATING NEW VARIABLES
################################################################################
# YOUR TURN - Part A:
# Create a grain_to_straw_ratio column
oats <- mutate(oats,
               grain_to_straw_ratio = 
)

# YOUR TURN - Part B:
# Create a column called percent_diff_from_avg_yield that calculates the 
# % difference from the median yield
# hint: (observation yield - median yield) / median yield
# bonus: handle case when average median is 0
oats <- mutate(oats,
               percent_diff_from_avg_yield = 
)

# YOUR TURN - Part C:
# Create a new variable called "high_yield" that is:
# 'Yes' if yield >= average yield
#- 'No' if yield < average yield
# hint: use case_when()
oats <- mutate(oats,
               high_yield = case_when(
                 
               )
)


################################################################################
# PROBLEM 4: MERGING DATA
################################################################################
# YOUR TURN - Part A:
# Create a dataframe based on the blocks that designate the position in the field
# Based on where the block is, create these columns:
# - left_or_right: specify if its on the left or right side of the field (vertical)
# - top_mid_bottom: specify if its in the top, middle, or bottom of the field (horizontal)
field_position <- data.frame(
  block = c('B1', 'B2', 'B3', 'B4', 'B5', 'B6'),
  left_or_right = ,
  top_mid_bottom = 
)

# Merge the position columns onto the oats dataframe based on the block
oats <- 

# YOUR TURN - Part B (challenge):
# Do the above, but with mutate() instead
  
  
################################################################################
# PROBLEM 5: SUMMARIZING DATA BY GROUPS
################################################################################
# YOUR TURN - Part A:
# Summarize the avg yield by block
block_summary <-
  
# YOUR TURN - Part B:
# For control oats only, what are the avg min and max avg yield for each variety?
# Filter to control yields
control_yields_by_variety <- 

# Summarize
control_min_max_variety <-

################################################################################
# BONUS CHALLENGE
################################################################################
# Question 1:
# Which nitrogen treatment yielded the highest averages for each 
# individual variety?
  
  
# Question 2:
# Does yield seem to be independent of field positioning, or is there bias?
  
  
# Question 3:
# Your turn! Come up with a research question, answer it and share it !

################################################################################
# CONGRATULATIONS! 
# You've completed Part 1 - Working with Data in R <3
################################################################################