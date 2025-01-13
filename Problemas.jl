# Definindo os problemas multiobjetivo aqui (em um vetor)

variaveis = []

#AP3 - 2 variáveis
push!(variaveis,2)
prob1 = [
    x -> 0.25*((x[1]-1)^4+2*(x[2]-2)^4),
    x -> (x[2]-x[1]^2)^2 + (1-x[1])^2,
]
#AP4
push!(variaveis,3)
prob2 = [
    x -> (1/9)*((x[1]-1)^4+2*(x[2]-2)^4+3*(x[3]-3)^4),
    x -> exp((x[1]+x[2]+x[3])/3) + x[1]^2+x[2]^2+x[3]^2 ,
    x -> (1/12)*(3*exp(-x[1])+4*exp(-x[2])+3*exp(-x[3]))
]
#Exponencial não convexo
push!(variaveis,1)
prob3 = [
    x -> x[1]^4-2*(x[1])^2+1,
    x -> exp(x[1]^3-2*x[1]^2)
]

#SLCDT2 a = -1 e b = 1
push!(variaveis,10)
a1 = ones(10)
a2 = -ones(10)
a3 = [-(-1)^i for i in 1:10]

prob4 = [
    x -> (x[1] - a1[1])^2 + (x[1] - a1[1])^4 +
         (x[2] - a1[2])^2 + (x[1] - a1[1])^4 +
         (x[3] - a1[3])^2 + (x[1] - a1[1])^4 +
         (x[4] - a1[4])^2 + (x[1] - a1[1])^4 +
         (x[5] - a1[5])^2 + (x[1] - a1[1])^4 +
         (x[6] - a1[6])^2 + (x[1] - a1[1])^4 +
         (x[7] - a1[7])^2 + (x[1] - a1[1])^4 +
         (x[8] - a1[8])^2 + (x[1] - a1[1])^4 +
         (x[9] - a1[9])^2 + (x[1] - a1[1])^4 +
         (x[10] - a1[10])^2 + (x[1] - a1[1])^4,

    x -> (x[1] - a2[1])^2 + (x[2] - a2[2])^4 +
         (x[2] - a2[2])^2 + (x[2] - a2[2])^4 +
         (x[3] - a2[3])^2 + (x[2] - a2[2])^4 +
         (x[4] - a2[4])^2 + (x[2] - a2[2])^4 +
         (x[5] - a2[5])^2 + (x[2] - a2[2])^4 +
         (x[6] - a2[6])^2 + (x[2] - a2[2])^4 +
         (x[7] - a2[7])^2 + (x[2] - a2[2])^4 +
         (x[8] - a2[8])^2 + (x[2] - a2[2])^4 +
         (x[9] - a2[9])^2 + (x[2] - a2[2])^4 +
         (x[10] - a2[10])^2 + (x[2] - a2[2])^4,

    x -> (x[1] - a3[1])^2 + (x[3] - a3[3])^4 +
         (x[2] - a3[2])^2 + (x[3] - a3[3])^4 +
         (x[3] - a3[3])^2 + (x[3] - a3[3])^4 +
         (x[4] - a3[4])^2 + (x[3] - a3[3])^4 +
         (x[5] - a3[5])^2 + (x[3] - a3[3])^4 +
         (x[6] - a3[6])^2 + (x[3] - a3[3])^4 +
         (x[7] - a3[7])^2 + (x[3] - a3[3])^4 +
         (x[8] - a3[8])^2 + (x[3] - a3[3])^4 +
         (x[9] - a3[9])^2 + (x[3] - a3[3])^4 +
         (x[10] - a3[10])^2 + (x[3] - a3[3])^4
]
#DGO1 a= -10 b = 13
push!(variaveis,1)
prob5 = [
    x -> sin(x[1]),
    x -> sin(x[1]+0.7)
]

#Far1 a=-1 b =1
push!(variaveis,2)
prob6 = [
    x -> -2*exp(15*(-(x[1]-0.1)^2 - x[2]^2)) - exp(20*(-(x[1]-0.6)^2 - (x[2]-0.6)^2)) + exp(20*(-(x[1]+0.6)^2 - (x[2]-0.6)^2)) + exp(20*(-(x[1]-0.6)^2 - (x[2]+0.6)^2)) + exp(20*(-(x[1]+0.6)^2 - (x[2]+0.6)^2)),
    x -> -2*exp(20*(-x[1]^2 - x[2]^2)) + exp(20*(-(x[1]-0.4)^2 - (x[2]-0.6)^2)) - exp(20*(-(x[1]+0.5)^2 - (x[2]-0.7)^2)) - exp(20*(-(x[1]-0.5)^2 - (x[2]+0.7)^2)) + exp(20*(-(x[1]+0.4)^2 - (x[2]+0.8)^2))
]

#SSFYY2 a=-100 e b=100
push!(variaveis,1)
prob7 = [
    x -> 10 - 10* cos(x[1]*pi/2) + x[1]^2 ,
    x -> (x[1]-4)^2
]

#Problema Básico
push!(variaveis,1)
prob8 = [
    x -> (x[1]+1)^2 ,
    x -> (x[1]-1)^2
]

#DGO1 modificado a = -10 e b = 13
push!(variaveis,1)
prob9 = [
    x -> sin(x[1]) + 0.1 * cos(5 * x[1]) * sin(x[1]),
    x -> sin(x[1] + 0.7) + 0.1 * cos(5 * x[1]) * sin(x[1] + 0.7)
]

#LOV1 a = -10 b = 10
push!(variaveis,2)
prob10 = [
    x -> 1.05*x[1]^2+0.98*x[2]^2,
    x -> 0.99(x[1]-3)^2+1.03(x[2]-2.5)^2
]

#MHHM1 a = 0 b = 2
push!(variaveis,1)
prob11 = [
    x -> (x[1]-0.8)^2,
    x -> (x[1]-0.85)^2,
    x -> (x[1]-0.9)^2
]

#MHHM2 a = 0 b = 2
push!(variaveis,2)
prob12 = [
    x -> (x[1]-0.8)^2+(x[2]-0.6)^2,
    x -> (x[1]-0.85)^2+(x[2]-0.7)^2,
    x -> (x[1]-0.9)^2+(x[2]-0.6)^2
]

#QV1 a= -5.12 e b = 5.12
push!(variaveis,10)
prob13 = [
    x -> (      ((x[1]^2 - 10*cos(2*pi*x[1]) + 10) / 10)^0.25 +
                ((x[2]^2 - 10*cos(2*pi*x[2]) + 10) / 10)^0.25 +
                ((x[3]^2 - 10*cos(2*pi*x[3]) + 10) / 10)^0.25 +
                ((x[4]^2 - 10*cos(2*pi*x[4]) + 10) / 10)^0.25 +
                ((x[5]^2 - 10*cos(2*pi*x[5]) + 10) / 10)^0.25 +
                ((x[6]^2 - 10*cos(2*pi*x[6]) + 10) / 10)^0.25 +
                ((x[7]^2 - 10*cos(2*pi*x[7]) + 10) / 10)^0.25 +
                ((x[8]^2 - 10*cos(2*pi*x[8]) + 10) / 10)^0.25 +
                ((x[9]^2 - 10*cos(2*pi*x[9]) + 10) / 10)^0.25 +
                ((x[10]^2 - 10*cos(2*pi*x[10]) + 10) / 10)^0.25),

    x -> (      (((x[1] - 1.5)^2 - 10*cos(2*pi*(x[1] - 1.5)) + 10) / 10)^0.25 +
                (((x[2] - 1.5)^2 - 10*cos(2*pi*(x[2] - 1.5)) + 10) / 10)^0.25 +
                (((x[3] - 1.5)^2 - 10*cos(2*pi*(x[3] - 1.5)) + 10) / 10)^0.25 +
                (((x[4] - 1.5)^2 - 10*cos(2*pi*(x[4] - 1.5)) + 10) / 10)^0.25 +
                (((x[5] - 1.5)^2 - 10*cos(2*pi*(x[5] - 1.5)) + 10) / 10)^0.25 +
                (((x[6] - 1.5)^2 - 10*cos(2*pi*(x[6] - 1.5)) + 10) / 10)^0.25 +
                (((x[7] - 1.5)^2 - 10*cos(2*pi*(x[7] - 1.5)) + 10) / 10)^0.25 +
                (((x[8] - 1.5)^2 - 10*cos(2*pi*(x[8] - 1.5)) + 10) / 10)^0.25 +
                (((x[9] - 1.5)^2 - 10*cos(2*pi*(x[9] - 1.5)) + 10) / 10)^0.25 +
                (((x[10] - 1.5)^2 - 10*cos(2*pi*(x[10] - 1.5)) + 10) / 10)^0.25)
]

#MOP2 a=-4 e b =4
push!(variaveis,15)
prob14 = [
    x -> (1 - exp(-sum((x[j] - 1)^2 / 15 for j in 1:15))),
    x -> (1 - exp(-sum((x[j] + 1)^2 / 15 for j in 1:15)))
]

#VU1 a= -3 e b = 3
push!(variaveis,2)
prob15 = [
    x -> 1/(x[1]^2+x[2]^2 + 1),
    x -> x[1]^2+3*x[2]^2 + 1
]

#VU2
push!(variaveis,2)
prob16 = [
    x -> x[1]+x[2]+1,
    x -> x[1]^2+2*x[2] - 1
]

#mgh26 Modificado a = -1 e b = 1
nmgh26m = 50
push!(variaveis,nmgh26m)
prob17 = []
for i in 1:nmgh26m
    push!(prob17, x -> nmgh26m -sum(cos(x[j]) for j in 1:nmgh26m)+ i*(1-cos(x[i]))-sin(x[i]) )
end


#JOS1 a = -100 b = 100
push!(variaveis,100)
function jos(x, shift=0.0)
    return sum((xi - shift)^2/ 100 for xi in x)
end

prob18 = [
    x -> jos(x),        # Sem deslocamento
    x -> jos(x, 2)    # Com deslocamento de 1.5
]

#mgh26 a= -1 e b = 1
nmgh26 = 4
push!(variaveis,nmgh26)
prob19 = []
for i in 1:nmgh26
    push!(prob19, x -> nmgh26 -sum(cos(x[j]) for j in 1:nmgh26)+ i*(1-cos(x[i]))-sin(x[i]) )
end


# DGO Modifcado 2
push!(variaveis,100)

prob20 = [
    x -> sum(sin(x[i]) + 0.1 * cos(5 * x[i]) * sin(x[i]) for i in 1:100),
    x -> sum(sin(x[i] + 0.7) + 0.1 * cos(5 * x[i]) * sin(x[i] + 0.7) for i in 1:100)
]

#DGO Modificado 3
push!(variaveis,1)
prob21 = [x -> sin(x[1] + 0.7 * i) + 0.1 * cos(5 * x[1]) * sin(x[1] + 0.7 * i) for i in 1:100]

# MOP5 Viennet a = -30 e b = 30
push!(variaveis,2)
prob22 = [
    x -> 0.5 * (x[1]^2 + x[2]^2) + sin(x[1]^2 + x[2]^2),
    x -> ((3 * x[1] - 2 * x[2] + 4)^2) / 8 + ((x[1] - x[2] + 1)^2) / 27 + 15,
    x -> 1 / (x[1]^2 + x[2]^2 + 1) - 1.1 * exp(-(x[1]^2 + x[2]^2))
]

# Viennet modificado a = -30 e b = 30
nvien = 200
push!(variaveis,nvien)
prob23 = [
    x -> 0.5 * sum(x[i]^2 for i in 1:nvien) + sin(sum(x[i]^2 for i in 1:nvien)),  # f1 adaptada
    x -> (3 * x[1] - 2 * x[2] + 4)^2 / 8 + (x[1] - x[2] + 1)^2 / 27 + 15,      # f2 adaptada
    x -> 1 / (sum(x[i]^2 for i in 1:nvien) + 1) - 1.1 * exp(-sum(x[i]^2 for i in 1:nvien)) # f3 adaptada
]

# Adicionando variações para chegar a 50 funções
for i in 4:10
    push!(prob23, x -> 0.5 * sum(x[j]^2 for j in 1:nvien) + sin(i * sum(x[j]^2 for j in 1:nvien)) +
                         (3 * x[1] - 2 * x[2] + i)^2 / (8 + i) +
                         (x[1] - x[2] + i)^2 / (27 + i) +
                         1 / (sum(x[j]^2 for j in 1:nvien) + i) - 1.1 * exp(-(sum(x[j]^2 for j in 1:nvien) + i))
    )
end

#LOV2 a= -0.75  b=0.75
push!(variaveis,2)
prob24 = [
    x -> -x[2],
    x -> (x[2]-x[1]^2)/(x[1]+1)
]

#LOV3 a= -20.  b=20
push!(variaveis,2)
prob25 = [
    x -> -x[1]^2-x[2]^2,
    x -> -(x[1]-6)^2+(x[2]+0.3)^2
]

#LOV6 a= 1  b=4
push!(variaveis,2)
prob26 = [
    x -> 2*sqrt(x[1]),
    x -> (x[1]*(1-x[2])+5)
]

#Toi10 Rosenbrock a = -2 e b = 2
push!(variaveis,4)
prob27 = []

for i in 1:3
    push!(prob27, x -> 100*(x[i+1]-x[i]^2)^2+(x[i+1]-1)^2)
end

#Toi8 Tridia a = -1 e b = 1
push!(variaveis,3)
prob28 = []

for i in 1:3
    push!(prob28, x -> 100*(x[i+1]-x[i]^2)^2+(x[i+1]-1)^2)
end

#Toi9 Shifted Tridia a = -1 e b = 1
push!(variaveis,4)
prob29 =[]
push!(prob29, x -> (2*x[1]-1)^2+x[2]^2)

for i in 2:3
    push!(prob29, x -> i*(2*x[i-1]-x[i])^2-(i-1)*x[i-1]^2+i*x[i]^2)
end

push!(prob29, x -> 4*(2*x[3]-x[4])^2 -3*x[3]^2)

# Gaussian a=-2 e b=2
push!(variaveis, 3)

# Definindo os parâmetros t_i e y_i
ti = [(8 - i) / 2 for i in 1:15]
yi = [0.0009, 0.0044, 0.0175, 0.0540, 0.1295, 0.2420, 0.3521, 0.3989]

# Repetindo os valores de y_i conforme necessário (pois m = 15)
yi = vcat(yi, reverse(yi[1:end-1]))

# Lista para armazenar as funções objetivo
prob30 = []

# Adicionando as funções objetivo à lista
for i in 1:15
    push!(prob30, x -> x[1] * exp(-x[2] * (ti[i] - x[3])^2 / 2) - yi[i])
end

#LTDZ a=-0 e b = 1
push!(variaveis, 3)
prob31 = []
push!(prob31, x -> -(3 - (1 + x[3]) * cos(x[1] * pi/2) * cos(x[2] * pi/2)))
push!(prob31, x -> -(3 - (1 + x[3]) * cos(x[1] * pi/2) * sin(x[2] * pi/2)))
push!(prob31, x -> -(3 - (1 + x[3]) * cos(x[1] * pi/2) * sin(x[1] * pi/2)))

#SSFYY1 a=-100 e b=100
push!(variaveis,2)
prob32 = [
    x -> x[1]^2 + x[2]^2 ,
    x -> (x[1]-1)^2 + (x[2]-2)^2
]

#FF1 a=-1 e b=1
push!(variaveis,3)
prob33 = []
push!(prob33, x -> 1 - exp(-((x[1] - 1)^2 + (x[2] + 1)^2)))

push!(prob33, x -> 1 - exp(-((x[1] + 1)^2 + (x[2] - 1)^2)))

# Colocando todos os problemas em uma matriz
matriz_de_problemas = [
    prob1, 
    prob2, 
    prob3, 
    prob4, 
    prob5, 
    prob6, 
    prob7, 
    prob8, 
    prob9, 
    prob10,
    prob11,
    prob12,
    prob13,
    prob14,
    prob15,
    prob16,
    prob17,
    prob18,
    prob19,
    prob20,
    prob21,
    prob22,
    prob23,
    prob24,
    prob25,
    prob26,
    prob27,
    prob28,
    prob29,
    prob30,
    prob31,
    prob32,
    prob33
]
