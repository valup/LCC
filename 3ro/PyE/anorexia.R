datos <- read.table("anorexia.data", header = TRUE, col.names = c("Signo","Sexo","Edad","Visitas"))
attach(datos)

frecAbsV = table(Visitas)
frecRel = frecAbsV / sum(frecAbsV)
frecRAcumV = round(cumsum(frecRel),digits = 4)
frecRel = round(frecRel,digits = 4)
frecAAcum = cumsum(frecAbsV)
tVisitas = cbind(frecAbsV, frecRel, frecAAcum, frecRAcumV)
colnames(tVisitas) = c("Frecuencia Absoluta","Frecuencia Relativa",
                       "Frecuencia Absoluta Acumulada","Frecuencia Relativa Acumulada")


intervalos = cut(Edad, seq(11, 35, 3),right = FALSE)
frecAbs = table(intervalos)
frecRel = frecAbs / sum(frecAbs)
frecRAcum = round(cumsum(frecRel), digits = 4)
frecRel = round(frecRel, digits = 4)
frecAAcum = cumsum(frecAbs)
tEdad = cbind(frecAbs, frecRel, frecAAcum, frecRAcum)
colnames(tEdad) = c("Frecuencia Absoluta","Frecuencia Relativa",
                    "Frecuencia Absoluta Acumulada","Frecuencia Relativa Acumulada")

signoSexo = table(Signo, Sexo)
totalSigno = apply(signoSexo,1,sum)
tSigno = cbind(signoSexo, totalSigno)
totalSexo = apply(tSigno,2,sum)
tSigno = rbind(tSigno,totalSexo)
colnames(tSigno) = c("Mujeres","Hombres","Total")
signosT = c("Dieta Severa","Hiperactividad","Uso de laxantes","Uso de ropa holgada","Total")
rownames(tSigno) = signosT

contSignos = table(Signo)
porcentajes = paste(round(contSignos / sum(contSignos) * 100, digits = 2),"%")
signos = signosT[1:4]
par(mar = c(4,4,4,4))
pieSignos = pie(table(Signo), labels = paste(signos,porcentajes,sep = "\n"), clockwise = TRUE,
                main = nombre, cex = 0.7, radius = 1)
mtext("Fuente: Asociacion de Lucha contra la Bulimia y la Anorexia", side = 1, line = 2,
      adj = 0, cex = 0.7)

sortSignos = sort(contSignos, decreasing = TRUE)
signos = c("Hiperactividad","Uso de laxantes","Uso de ropa holgada","Dieta Severa")
par(mar = c(6,6.5,5,5))
barplot(height = sortSignos, names.arg = signos, axes = TRUE, axisnames = TRUE, las = 1,
        horiz = TRUE, main = nombre,  xlab = "Numero de pacientes", ylab = "Signo", 
        xlim = c(0,20), cex.axis = 0.9, cex.names = 0.65, cex.lab = 0.7, font.lab = 2)
mtext("Fuente: Asociacion de Lucha contra la Bulimia y la Anorexia", side = 1, line = 4,
      adj = -0.7, cex = 0.6)

sexoSigno = table(Sexo,Signo)[,c("1","2","3","0")]
barplot(height = sexoSigno, names.arg = signos, axes = TRUE, axisnames = TRUE, las = 1,
        horiz = TRUE, beside = TRUE, main = nombre,  xlab = "Numero de pacientes", ylab = "Signo", 
        xlim = c(0,14), cex.axis = 0.9, cex.names = 0.65, cex.lab = 0.7, font.lab = 2, 
        col = c("dark green","magenta"), legend.text = TRUE)
mtext("Fuente: Asociacion de Lucha contra la Bulimia y la Anorexia", side = 1, line = 4,
      adj = -0.7, cex = 0.6)

#frecAbsV["6"] = 0
#frecAbsV = rev(frecAbsV)
#frecAbsV["0"] = 0
#frecAbsV = rev(frecAbsV)
nombre = "NUMERO DE VISITAS POR PACIENTE\nARGENTINA, OCTUBRE 2012"
plot(frecAbsV, main = nombre, xlab = "Numero de visitas", ylab = "Frecuencia absoluta", 
     cex.axis = 0.9, cex.lab = 0.7, font.lab = 2, ylim = c(0,25), xlim = c(0,6))
mtext("Fuente: Asociacion de Lucha contra la Bulimia y la Anorexia", side = 1, line = 4,
      adj = -0.7, cex = 0.6)

#frecRAcumV = append(append(frecRAcumV,0,0),1,6)
plot(frecRAcumV, main = nombre, xlab = "Numero de visitas", ylab = "Frecuencia relativa acumulada",
     type = "s", las = 1, cex.axis = 0.7, cex.lab = 0.7, font.lab = 2, ylim = c(0,1.0), 
     xlim = c(0,6))
mtext("Fuente: Asociacion de Lucha contra la Bulimia y la Anorexia", side = 1, line = 4,
      adj = -0.7, cex = 0.6)
abline(h = c(0,0.2,0.4,0.6,0.8,1.0), lwd = 0.5, lty = 2)

hist(frecAbs, breaks = 8)
