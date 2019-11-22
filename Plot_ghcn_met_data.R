library(dplyr)
library(lubridate)
library(ggplot2)

# Load RDS file
dat <- readRDS("AugustaME_1973_2019.rds")

# Summarize data
summary(dat)

# Plot RH yearly median
dat %>% select(time, rh) %>%  na.omit %>% 
  group_by(year = year(time)) %>% summarise(rh = median(rh, na.rm=TRUE)) %>% 
  ggplot(aes(x=year, y=rh)) + geom_point() + 
  geom_smooth(method = loess, method.args = list(family="symmetric", span=0.6) )

# Plot yearly boxplots
dat %>% select(time, rh) %>% mutate(year = year(time)) %>% na.omit() %>% 
  ggplot(aes(x=as.factor(year), y=rh)) + geom_boxplot() + 
  geom_hline(yintercept = c(65,70,75))

# Plot temp yearly median
dat %>% select(time, temp) %>%  na.omit %>% 
  group_by(year = year(time)) %>% summarise(temp = median(temp, na.rm=TRUE)) %>% 
  ggplot(aes(x=year, y=temp)) + geom_point() + 
  geom_smooth(method = loess, method.args = list(family="symmetric") )

# Plot wind yearly median
dat %>% select(time, ws) %>%  na.omit %>% 
  group_by(year = year(time)) %>% summarise(ws = mean(ws, na.rm=TRUE)) %>% 
  ggplot(aes(x=year, y=ws)) + geom_point() + 
  geom_smooth(method = loess, method.args = list(family="symmetric") )

# Plot yearly precip amounts
dat %>% select(time, aa1_2) %>%  filter(aa1_2 != 999.9) %>% na.omit %>% 
  group_by(year = year(time)) %>% summarise(precip = sum(aa1_2, na.rm=TRUE)) %>% 
  ggplot(aes(x=year, y=precip)) + geom_point() + 
  geom_smooth(method = loess, method.args = list(family="symmetric") )
