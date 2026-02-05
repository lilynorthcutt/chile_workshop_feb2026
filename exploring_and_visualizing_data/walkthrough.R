################################################################################
# AGRICULTURAL DATA ANALYSIS WORKSHOP 
# WALKTHROUGH 
# Exploring & Visualizing Data in R 
################################################################################

# ==============================================================================
# SETUP
# ==============================================================================

# Load required packages
library(dplyr)
library(ggplot2)
library(agridat)

# Load our familiar dataset from Part 1
oats <- yates.oats

# ==============================================================================
# SECTION A: ADVANCED DATA MANIPULATION WITH PIPES
# ==============================================================================
# We want to take the avg yield for each variety
# only when the the grain to straw ratio is over .5

# PROBLEM: Nested code is hard to read
ugly_code <- summarize(group_by(filter(mutate(oats, grain_to_straw = grain /straw), grain_to_straw > .5), gen), avg_yield = mean(yield))

# PROBLEM: Writing everything out can take long, and take up a lot of space
oats_with_grain_to_straw <- mutate(oats, grain_to_straw = grain /straw)
filter_over_half <- filter(oats_with_grain_to_straw, grain_to_straw > .5)
finaly <- summarize(group_by(filter_over_half, gen), avg_yield = mean(yield))

# SOLUTION
pipe_soln <- oats %>% 
  mutate(., grain_to_straw = grain /straw) %>% 
  filter(., grain_to_straw > .5) %>% 
  group_by(., gen) %>% 
  summarize(., avg_yield = mean(yield)) %>% 
  ungroup()

# Example 1: Create categories by high or low treatment, then summarize by group
oats %>%
  mutate(nitrogen_level = case_when(nitro >= 0.4 ~ "Higher N", 
                                    T ~ "Lower or No N")
         ) %>%
  group_by(gen, nitrogen_level) %>%
  summarize(
    mean_yield = mean(yield),
    n = n(),
    .groups = "drop"
  )

# Example 2: 
nitrogen_response <- oats %>%
  # Take only the highest nitrogen treatment and control
  filter(nitro %in% c(0, 0.6)) %>%  
  # Label accordingly
  mutate(treatment = case_when(nitro == 0 ~ "Control", 
                               T ~ "High N")) %>%
  group_by(gen, treatment) %>%
  summarize(mean_yield = mean(yield), .groups = "drop")

nitrogen_response


## GROUP BY BEFORE MUTATE ##
# Add variety mean to each row
oats_with_variety_mean <- oats %>%
  group_by(gen) %>%
  mutate(
    variety_mean = mean(yield),
    diff_from_variety_mean = yield - variety_mean
  ) %>%
  ungroup()
oats_with_variety_mean

## CHALLENGE ##
# variety_nitrogen_effect <- oats %>%
#   filter(nitro %in% c(0, 0.6)) %>%
#   group_by(gen, nitro) %>%
#   summarize(mean_yield = mean(yield), .groups = "drop") %>%
#   mutate(treatment = ifelse(nitro == 0, "Control", "High_N")) %>%
#   select(-nitro) %>%
#   tidyr::pivot_wider(names_from = treatment, values_from = mean_yield) %>%
#   mutate(
#     yield_delta = (High_N - Control) / Control,
#   )

# variety_nitrogen_effect

# -->> STUDENT PROBLEM 1

# ==============================================================================
# SECTION B: INTRODUCTION TO GGPLOT2
# ==============================================================================

# Let's use some new data
data(ChickWeight)
head(ChickWeight)
str(ChickWeight)
summary(ChickWeight)
# This is good as it's time series data, like many experiments 

### BUILDING A SCATTER PLOT ITERATIVELY ###

# ITERATION 1: Most basic scatter plot
plot1 <- ggplot(ChickWeight, aes(x = Time, y = weight)) + 
  geom_point()
plot1


# ITERATION 2: Add labels
plot2 <- ggplot(ChickWeight, aes(x = Time, y = weight)) +
    geom_point() +
    labs(
      title = "Chick Growth Over Time",
      x = "Time (days)",
      y = "Weight (grams)")
plot2

# plot1 + what makes plot2?

# ITERATION 3: Color by Diet
plot3 <- ggplot(ChickWeight, aes(x = Time, y = weight, color = Diet)) +
  geom_point() +
  labs(
    title = "Chick Growth Over Time",
    x = "Time (days)",
    y = "Weight (grams)",
    color = "Diet Type"
    )

plot3

# ITERATION 4: Add vertical line at midpoint
midpoint <- (max(ChickWeight$Time) + min(ChickWeight$Time)) / 2
plot4 <- ggplot(ChickWeight, aes(x = Time, y = weight, color = Diet)) +
  geom_point() +
  geom_vline(xintercept = midpoint, linetype = "dashed", color = "gray55", size = 1) +
  labs(
    title = "Chick Growth Over Time",
    x = "Time (days)",
    y = "Weight (grams)",
    color = "Diet Type"
  )
plot4


# ITERATION 5: Change theme
plot5 <- ggplot(ChickWeight, aes(x = Time, y = weight, color = Diet)) +
  geom_point() +
  geom_vline(xintercept = midpoint, linetype = "dashed", color = "gray55", size = 1) +
  labs(
    title = "Chick Growth Over Time",
    x = "Time (days)",
    y = "Weight (grams)",
    color = "Diet Type"
  ) +
  theme_bw() # see slides for more themes

plot5

# ITERATION 6: Change how its plotted: size and transparency
plot6 <- ggplot(ChickWeight, aes(x = Time, y = weight, color = Diet)) +
  geom_point(size = 3, alpha = 0.5) +
  geom_vline(xintercept = midpoint, linetype = "dashed", color = "gray55", size = 1) +
  labs(
    title = "Chick Growth Over Time",
    x = "Time (days)",
    y = "Weight (grams)",
    color = "Diet Type"
  ) +
  theme_bw()

plot6

# ITERATION 7: Add a trend line
plot7 <- ggplot(ChickWeight, aes(x = Time, y = weight, color = Diet)) +
  geom_point(size = 2, alpha = 0.5) +
  geom_smooth(se = FALSE) + 
  #geom_smooth(method = "lm", se = FALSE) +  # Add linear trend lines
  labs(
    title = "Chick Growth Over Time by Diet",
    x = "Time (days)",
    y = "Weight (grams)",
    color = "Diet Type"
  ) +
  theme_bw()

plot7

# Extra: Customization
extra_plot <- ggplot(ChickWeight, aes(x = Time, y = weight, color = Diet)) +
  geom_point(size = 2.5, alpha = 0.6) +
  labs(
    title = "Chick Growth Over Time by Diet",
    x = "Time (days)",
    y = "Weight (grams)",
    color = "Diet Type"
    ) +
  scale_color_brewer(palette = "Set1") +  # many options to choose from!
  theme_bw() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.position = "right"
    )

extra_plot


### SAVE YOUR PLOT ###
ggsave("chickgrowth_by_diet.png", plot = plot7, 
       width = 6, height = 4, units = "in", dpi = 300)

# -->> STUDENT PROBLEM 2

# ==============================================================================
# SECTION C: BOX PLOTS WITH ERROR BARS
# ==============================================================================
### Classic box
# Subset to final time point
final_weights <- ChickWeight %>%
    filter(Time == 21)
box1 <- ggplot(final_weights, aes(x = Diet, y = weight)) +
  geom_boxplot()

box1

### Color & Customization
box2 <- ggplot(final_weights, aes(x = Diet, y = weight, fill = Diet)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.8, mapping = aes(color = Diet)) +
  labs(
    title = "Final Weight by Diet",
    x = "Diet Type",
    y = "Weight (grams)"
    ) +
  theme_bw() +
  theme(legend.position = "none")

box2

### Error Bars
diet_summary <- final_weights %>%
  group_by(Diet) %>%
  summarize(
    mean_weight = mean(weight),
    se_weight = sd(weight) / sqrt(n()),
    .groups = "drop"
      )
# Create bar plot with error bars
bar_with_errors <- ggplot(diet_summary, aes(x = Diet, y = mean_weight, fill = Diet)) +
  geom_col() +
  geom_errorbar(
    aes(ymin = mean_weight - se_weight, ymax = mean_weight + se_weight),
    width = 0.2
  ) +
  labs(
    title = "Mean Final Weight by Diet",
    subtitle = "Error bars show ± 1 SE",
    x = "Diet Type",
    y = "Mean Weight (grams)"
    ) +
  theme_bw() 
bar_with_errors

# -->> STUDENT PROBLEM 3 


# ==============================================================================
# SECTION D: FACETING
# ==============================================================================

### One Variable
facet_plot <- ggplot(ChickWeight, aes(x = Time, y = weight, color = Diet)) +
  geom_point(size = 3, alpha = 0.5) +
  geom_vline(xintercept = midpoint, linetype = "dashed", color = "gray55", size = 1) +
  labs(
    title = "Chick Growth Over Time",
    x = "Time (days)",
    y = "Weight (grams)",
    color = "Diet Type"
  ) +
  theme_bw() +
  # up until here, this was plot 6
  facet_wrap(. ~ Diet, )

facet_plot
# plot6 + facet_wrap(.~Diet, ncol = 2) 

### Facet Grid
base_box <- ggplot(ChickWeight, aes(x = factor(Time), y = weight, fill = Diet)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Weight Overtime by Diet",
    x = "Time",
    y = "Weight (grams)"
  ) +
  theme_bw() 
base_box

# 1
base_box + facet_grid(. ~ Diet)
# 2 
base_box + facet_grid( Diet ~ .)
# 3
base_box + facet_grid(Diet ~ Time)
base_box + facet_grid(Time ~ Diet)

# -->> STUDENT PROBLEM 4