library(dplyr)
library(tidyverse)
library(faraway)

data(dicentric, package="faraway")
summary(dicentric)
glimpse(dicentric)
rate<-dicentric$ca/dicentric$cells 

#analise descritiva




