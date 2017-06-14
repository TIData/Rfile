

# ======================================================================================
# ================================ Basiscommando's =====================================
# ======================================================================================


# Hulp vragen

# Vb voor solve:
help(solve)

# of:
?solve


# Uitvoeren code
source ("commands.R")

# Begin schrijven van output naar een bestand:
sink("records.Rout")

# Stop uitschrijven naar een bestand
sink()

# Alle objecten in de omgeving tonen:
objects()

# Objecten uit de omgeving verwijderen:
rm(object1, object2, ...)


# Lijst/Vector toekennen
x <- c(10.4, 5.6, 2.1)

# Waarde vragen (index begint bij 1, dus dit lever 10.4 op)
x[1]

# Bestanden in huidige directory opvragen
dir()

# CSV bestanden inlezen (met de belangrijkste optionele parameters (alles behalve de naam) hun default waarde meegegeven)
read.csv("naam", header = TRUE, sep = ",", quote = "\"", dec = ".")

# Namen van kolommen opvragen
names(eentabelofdataframehier)

# Alle metadata over een object opvragen (inclusief de kolommen, rijnamen etc.)
attributes(object1)


# ======================================================================================
# =================================== DATA TYPES =======================================
# ======================================================================================

# Getallen toekennen
a <- 3

# Lijst van 10 getallen
a <- numeric(10)

# String toekennen
a <- "hello world"
#of
a <- 'hello world'

# lijst van strings
a <- c("hello", "world")


# Iets een factor maken doe je door er factor() rond te zetten
# hiermee geef je aan dat het een "niveau" is, denk aan verschillende anwoorden op een vraag die een persoon kan kiezen

# Data frames: meerdere types data samenvoegen (meestal voor experimenten enz.)

a <- c(1,2,3,4)
b <- c(2,4,6,8)
levels <- factor(c("A", "B", "C", "A"))
frame1 <- data.frame(first = a, second = b, f = levels)
# De namen first, second en f zijn de namen van de kolommen waarin de data terecht komt


# Logische variabelen
a <- TRUE
b <- FALSE


# Een Tabel maken
a <- factor(c("A", "A", "B", "C", "B", "C", "A"))
result <- table(a)
# Het resultaat is een tabel waarbij voor elk niveau het aantal wordt bijgehouden


# Tabel met meerdere dimensies
a <- c("Soms", "Soms", "Nooit", "Altijd", "Altijd")
b <- c("misschien", "misschien", "nee", "nee", "ja")
result <- table(a, b)
result


# Matrix maken
A <- matrix (c(2,4,3,1,5,7), nrow = 2, ncol = 3, byrow = TRUE)

# Element ophalen tweede rij, derde kolom
A[2,3]

# Tweede rij ophalen
A[2,]

# Eerste en derde kolom ophalen
A[,c(1,3)]


# Eerste rij tweede komom mtcars
mtcars[1,2]

# Aantal rijen en kolommen
dim(mtcars)

# Enkel de data van de cylinders
mtcars$cyl

# Enkel de kolommen mpg en hp overhouden
mtcars[,c("mpg", "hp")]

# Enkel rij met mazda RX4 selecteren
mtcars[c("Mazda RX4"),]


library(DAAG)
# De rijen in rainforest zonder NA, die volledig en compleet zijn
rainforest[complete.cases(rainforest),]

# Het aantal rijen die volledig en compleet zijn
nrow(rainforest[complete.cases(rainforest),])

# ======================================================================================
# ============================= Statistische functies ==================================
# ======================================================================================


# Gemiddelde
mean(price)

# Mediaan
median(price)

# Kwartielen
quantile(price)

# Laagste waarde
min(price)

# Hoogste waarde
max(price)

# Variantie
var(price)

# Standaardafwijking
sd(price)

# Een overzicht van alles
summary(price)


# ======================================================================================
# ================================ Grafieken tekenen ===================================
# ======================================================================================

android_cpu <- read.csv("android_persistence_cpu.csv", sep = ";", dec = ",")
attach(android_cpu)

# Histogram

hist(android_cpu$Tijd, main = "Verdeling van de tijd", xlab="De gemeten CPU tijd")
hist(android_cpu$Tijd, main = "Verdeling van de tijd", xlab="De gemeten CPU tijd", breaks = 2)

# Boxplot

boxplot(x = android_cpu$Tijd)
boxplot(android_cpu$Tijd, main = "Spreiding van de CPU tijd", ylab='Tijd in ms')

# Boxplot voor elke categorie
boxplot(android_cpu$Tijd ~ android_cpu$Datahoeveelheid, main = "Spreiding van de CPU tijd tov datahoeveelheid", ylab="Tijd in ms")


# Ook per persistentietype
boxplot(Tijd ~ PersistentieType * Datahoeveelheid, main = "Spreiding van de CPU tijd", ylab = "Tijd in ms")
# Dit is te druk dus we gaan kiezen om maar één persistentietype te analyseren

# Filteren op persistentietype
greenDAO <- android_cpu[which(android_cpu$PersistentieType == 'GreenDAO'),]
boxplot(greenDAO$Tijd ~ greenDAO$Datahoeveelheid)

# ======================================================================================
# ============================== Steekproefonderzoek ===================================
# ======================================================================================

# Linkerstaartkans berekenen
pnorm(0.75, mean = 0, sd = 1, lower.tail = TRUE)


# Het omgekeerde van pnorm, dus op basis van de kans de waarde berekenen
qnorm(p = 0.05, mean = 0, sd = 1, lower.tail = TRUE)

# De hoogte van de grafiek berekenen
dnorm(x = 2, mean = 0, sd = 1)

# 20 random waarden berekenen uit een normale verdeling
rnorm(20, mean = 0, sd = 1)

# ======================================================================================
# ============================== Toetsingsprocedures ===================================
# ======================================================================================

# TODO

# ======================================================================================
# ============================ Analyse op 2 variabelen =================================
# ======================================================================================

# Kruistabel en Cramer's V maken

# Tabel maken (normaal doe je dit met een freq tabel)
waarderingen_m <- matrix(c(9, 8, 5, 0, 8, 10, 5, 4), ncol = 2)
rownames(waarderingen_m) <- c("Goed", "Voldoende", "Onvoldoende", "Slecht")
colnames(waarderingen_m) <- c("Vrouw", "Man")
waarderingen <- as.table(waarderingen_m)

# Chi-squared berekenen
summ <- summary(waarderingen)
chi_sq <- summ$statistic


k <- min(nrow(waarderingen), ncol(waarderingen))
V <- sqrt(chi_sq / (margin.table(waarderingen) * (k-1))) # we doen hier margin.table om het totaal aantal elementen te vinden

# mosaic plot
plot(t(waarderingen))

# clustered bar plot
barplot(waarderingen, beside = TRUE)

# Stacked percentage chart
waarderingen_pct <- prop.table(waarderingen, 2)
barplot(waarderingen_pct, horiz = TRUE)


# Nog simpeler:


winkel <- read.csv("MuziekWijn.csv")
table(winkel)
library(gmodels)
CrossTable(winkel$Muziek, winkel$Wijn)

# de nulhypothese is dat er geen verband is
# de alternatieve hyopthese is dat er wel een verband

chisq.test(winkel$Muziek, winkel$Wijn)

library(lsr)
cramersV(winkel$Muziek, winkel$Wijn)


# nog een voorbeeld

aardbevingen <- read.csv("Aardbevingen.csv")

table(aardbevingen$Type, aardbevingen$Source)

chisq.test(aardbevingen$Type, aardbevingen$Source)

cramersV(aardbevingen$Type, aardbevingen$Source)

hist(aardbevingen$Magnitude)



# Regressielijn maken

gewichtstoename <- read.csv('santa.txt', sep="")
attach(gewichtstoename)

# plotten van de gegevens
plot(x, y, main = "Gewichtstoename", xlab = "eiwitgehalte (%)", ylab = "gewichtstoename (g)")

# regressie berekenen
regr <- lm(y ~ x)
abline(regr, col = "red")




# Pearsons product-momentcorrelatiecoëfficient

# Regressie berekenen en de coëfficient van Pearson  en de determinatiecoëfficient

cats <- read.csv("Cats.csv")
regressie <- lm(cats$Hwt ~ cats$Bwt)
regressie
plot(cats$Bwt,cats$Hwt)
abline(regressie)
per <- cor(cats$Hwt,cats$Bwt, method = "pearson")
per       # Pearson
per * per # determinatiecoefficient


# Nog een voorbeeldje

pizza <- read.csv("Pizza.csv")
regressie <- lm(pizza$Rating  ~ pizza$CostPerSlice)

regressie

plot(pizza$CostPerSlice,pizza$Rating)
abline(regressie)

per <- cor(pizza$Rating,pizza$CostPerSlice, method = "pearson")
per
per * per


# ======================================================================================
# =================================== De chi2 toets ====================================
# ======================================================================================


# De grenswaarde berekenen met significantieniveau 0.05 en 4 vrijheidsgraden
qchisq(1-0.05, df = 4)
# De rest kan je vinden met chisq.test, zie eerder



# ======================================================================================
# ==================================== Tijdsreeksen ====================================
# ======================================================================================

Budget <- read.csv("Budget.csv")

series <- ts(Budget$Omzet, frequency = 4, start=c(1981,03)) # timeseries definieren
plot(series)

# Als gamma FALSE is, dan wordt het non-seasonal model gebruikt
# als beta FALSE is wordt expenentiele smoothing gebruikt
budgetForecast <- HoltWinters(series, beta=TRUE, gamma=TRUE) # Holt-Winters calculation
plot(budgetForecast)

library("TTR")

SMA(series, 5) # De Smallest? Moving Average berekenen

library("forecast")

budgetForecast2 <- forecast.HoltWinters(budgetForecast, 8) # Doe een voorspelling van 8 periodes
plot(budgetForecast2)
