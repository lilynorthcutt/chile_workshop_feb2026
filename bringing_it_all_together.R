################################################################################
# BRINGING IT ALL TOGETHER
################################################################################

############# QUESTION 1 ############# 
# Did any locations in the field have higher yields?

# Food for thought before tackling:
# - Why does this matter?
# - Which columns can we use for this?
# - There are other factors at play here, such as variety and nitrogen
ggplot(oats, aes(x = col, y = yield))+
  geom_point(aes(color = gen)) + 
  geom_smooth(
    aes(group = 1),
    method = 'lm',
    se = FALSE,
    color = 'black'
  ) + 
  labs(
    title = "Yield vs. Sub-Plot Column",
    x = "Column",
    y = "Yield",
    color = 'Genotype'
  ) +
  theme_bw()+
  facet_wrap(.~nitro)

ggplot(oats, aes(x = row, y = yield))+
  geom_point(aes(color = gen)) + 
  geom_smooth(
    aes(group = 1),
    method = 'lm',
    se = FALSE,
    color = 'black'
  ) + 
  labs(
    title = "Yield vs. Sub-Plot Row",
    x = "Row",
    y = "Yield",
    color = 'Genotype'
  ) +
  theme_bw()+
  facet_wrap(.~nitro)

# Can you change it to facet on variety and color based on nitrogen treatment?



############# QUESTION 2 ############# 
# You are asked to give a recommendation for varieties/y and nitrogen treatment(s),
# what is your recommendation for the best performing ? 

# Food for thought before tackling:
# - May have many successful or NO successful combinations for treatment
# - once you get your answers, how can you communicate it in the best way?

ggplot(oats, aes(x = block, y = yield, fill = block)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.8, mapping = aes(color = block)) +
  labs(
    title = "Yield by Block",
    x = "Block",
    y = "Yield"
  ) +
  theme_bw() +
  theme(legend.position = "none")

ggplot(oats, aes(x = gen, y = yield, fill = gen)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.8, mapping = aes(color = gen)) +
  labs(
    title = "Yield by Genotype",
    x = "Genotype",
    y = "Yield"
  ) +
  theme_bw() +
  theme(legend.position = "none")

ggplot(oats, aes(x = factor(nitro), y = yield, fill = nitro)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.8, mapping = aes(color = nitro)) +
  labs(
    title = "Yield by Nitrogen Treatment",
    x = "Nitrogen",
    y = "Yield"
  ) +
  theme_bw() +
  theme(legend.position = "none")

# Can you change the color and/or facet to give us more information?