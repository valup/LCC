Edad = c(22, 22, 23, 24, 25, 25, 26, 27, 28, 29, 29, 29, 29, 29,
           31, 31, 32, 33, 34, 35, 35, 35, 36, 38, 39, 39, 42, 42,
           44, 44, 45, 45, 45, 47, 48, 52, 59, 66, 67, 69, 69)

tamMuestra = length(Edad)

media = mean(Edad)
mediana = median(Edad)
moda = mode(Edad)
cuart = quantile(Edad)

rango = range(Edad)
rangoI = cuart["75%"] - cuart["25%"]
desvEst = sd(Edad)
variancia = var(Edad)

perc10 = quantile(Edad, probs = 0.10)
perc50 = cuart["50%"]

info = summary(Edad)
min = info["Min."]
Q1 = info["1st Qu."]
Q2 = info["Median"]
Q3 = info["3rd Qu."]
max = info["Max."]

par(mar = c(3,3,3,3))
boxplot(Edad, horizontal = TRUE, ylim = c(0,70))

hist(Edad, xlim = c(0,70), breaks = c(0,10,20,30,40,50,60,70))


