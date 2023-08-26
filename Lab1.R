library(dplyr)
library(tidyverse)
library(faraway)

# proporção da dose
#doseamt quantidade da dose<-fator
#taxa da dose dose aplicada
#número de cromossomas anormais observados
#cells é o número de células (dentre 1000)
#ca número de anormalidade

data(dicentric, package="faraway")
dicentric <- dicentric|>
  mutate(doseamt = factor(doseamt))
glimpse(dicentric)
rate<-dicentric$ca/dicentric$cells 

#analise descritiva
summary(dicentric)

ggplot(dicentric)+
  aes(x=ca)+
  geom_histogram(bins = 15,color = "gray", fill = "black")+
  labs(x="Número de anormalidades", y = "Frequência")+
  theme_bw()

ggplot(dicentric)+
  aes(x=rate)+
  geom_histogram(bins = 15,color = "gray", fill = "black")+
  labs(x = "Taxa de anormalidades", y = "Frequência")+
  theme_bw()

ggplot()+
  geom_boxplot(aes(y = rate))+
  scale_x_discrete(breaks = NULL)+
  labs(y = "Taxa de anormalidades")+
  theme_bw()

ggplot(dicentric)+
  geom_boxplot(aes(x=doseamt, y=rate))+
  labs(x = "Quantidade da dose", y = "Taxa de anormalidades")+
  theme_bw()

with(dicentric, interaction.plot(doseamt, doserate, ca/cells, legend=TRUE))

#modelagem
fit <- glm(ca~doserate + factor(doseamt) + doserate:factor(doseamt) + 
            offset(log(cells)),family = poisson,dicentric)

model.matrix(fit)
summary(fit)
anova(fit, test="Chisq")



