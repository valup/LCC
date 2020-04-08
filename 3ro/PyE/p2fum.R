fum = c(69.3, 56.0, 22.1, 47.6, 53.2, 48.1, 52.7, 34.4, 60.2, 43.8, 23.2, 13.8)
noFum = c(28.6, 25.1, 26.4, 34.9, 29.8, 28.4, 38.5, 30.2, 30.6, 31.8, 41.6, 21.1, 36.0, 37.9, 13.9)

mediaF = mean(fum)
mediaN = mean(noFum)

desvF = sd(fum)
desvN = sd(noFum)

par(mar = c(5,5,5,5))
boxplot(fum, noFum, horizontal = TRUE, ylim = c(0,70), names = c("Fumadores", "No fumadores"),
        axes = TRUE, axisnames = TRUE, cex.axis = 0.65, las = 1)

