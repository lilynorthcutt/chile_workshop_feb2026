################################################################################
# AGRICULTURAL DATA ANALYSIS WORKSHOP
# PRACTICE PROBLEMS
# Exploring & Visualizing Data in R (75 minutes)
################################################################################

# SETUP: Load necessary packages and data
library(dplyr)
library(ggplot2)
library(agridat)

# Load datasets
data(yates.oats)
oats <- yates.oats

data(ChickWeight)

################################################################################
# PROBLEM 1: ADVANCED PIPES AND DATA MANIPULATION
################################################################################

# YOUR TURN - Part A:
# Re-write this with a pipe:
# mutate(oats, yield_mean = mean(yield))
oats_w_total_yield_avg <-

# YOUR TURN - Part B:
# Re-write this with a pipe:
# mutate(filter(oats, nitro == 0), yield_mean = mean(yield))
oats_w_total_yield_avg_control <-

# YOUR TURN - Part C:
# Using pipes, create a workflow that compares yield for the higher two treatments
# 1. Starts with the oats data
# 2. Filters to nitrogen levels 0.4 and 0.6 only
# 3. Creates a new column variable "high_n" that is TRUE if nitrogen == 0.6 (mutate)
# 4. Groups by variety and high_n
# 5. Summarizes to get mean yield and count for each group
high_nitrogen_comparison <- 
  
# YOUR TURN - Part D:
# Create a workflow that calculates how much each plot deviates from
# its variety's mean yield. Steps:
# 1. Start with oats
# 2. Group by variety
# 3. Use mutate to add variety_mean = mean(yield)
# 4. Use mutate to add yield_deviation = yield - variety_mean
# 5. Ungroup
# 6. Select variety, yield, variety_mean, yield_deviation
yield_deviations <- 

  
# YOUR TURN - Part E (Challenge):
# Create  a workflow that adds a column for the avg yields per block, the 
# average yields per variety, and the average per nitrogen treatment
# hint: use multiple instances of groups + don't forget ungrouping!
avgs_per_many_groups <- 

  
################################################################################
# PROBLEM 2: BUILDING GGPLOT2 SCATTER PLOTS
################################################################################
# 1. Summarize ChickWeight to get the average weight by diet and time
chick_summary <- 

# 2. Graph a scatter plot with the x-axis as Time, and the y-axis as AVG weight
# Add Labels


# 3. Color the points by diet 
  
  
# 4. Add a dash HORIZONTAL line of the avg weight


# 5. Play around with different customization

################################################################################
# PROBLEM 3: BOX PLOTS AND ERROR BARS
################################################################################
# Create a boxplot with X as the Time, y as the weight, and color by diet
# NOTE: X will need to be x = factor(Time) - bonus stickers if you figure out why


# (skipping error bars due to time)


################################################################################
# PROBLEM 4: FACETING
################################################################################
# Task: Please create a boxplot with:
# x-axis as Time, y-axis as weight, color as Diet
# facet on starting weight being above and below avg 
# (hint: use mutate to create this column)











#################################################################################
# CONGRATULATIONS! 
# You've completed Part 2 - Exploring & Visualizing Data in R <3
################################################################################
