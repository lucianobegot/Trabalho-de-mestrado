using JuMP, NLPModels, NLPModelsJuMP, Clp, Ipopt, LinearAlgebra, PlotlyJS, Plots, BenchmarkTools

include("Problemas.jl")
include("metrica.jl")
include("Auxiliar.jl")

# Escolhendo o problema a ser resolvido
problema = 29
funcoes = matriz_de_problemas[problema]
vars = variaveis[problema] #número de variáveis do problema

# Ponto onde queremos calcular o gradiente
a = -1.  # Valor inicial do intervalo do ponto inicial 
b = 1.  # Valor final do intervalo do ponto inicial

#Número de Pontos iniciais
nx0 = 500

x0raw = readdlm("x0.txt",Float64)
x0 = zeros(nx0, vars)

for i in 1:nx0
    for j in 1:vars
        x0[i, j] = a + (b - a) * x0raw[i,j]
    end
end

p = gerar_pesos(x0raw[1,:],length(funcoes))



# Definimos a função soma
function F(x)
    total = 0.0
    for i in 1:length(funcoes)
        total += p[i] * funcoes[i](x)
    end
    return total    
end

function mgrad(x, itmax)
    e = 1.0e-6
    b = deepcopy(x)
    k = 0
    alpha = 0.01
    
    while maximum(abs.(gradiente(F, b))) >= e && k < itmax
        g = gradiente(F, b)
        d = -1 * g
        t = 1.0
        factor = g'*d
        while F(b + t * d) > F(b) + alpha * t * factor
            t = t / 2
        end
        #println(maximum(abs.(gradiente(F, b))))
        b = b + t * d
        k = k + 1
    end
    
    println("Número de iterações:", k)
    return b
end

# Parâmetros do método
itmax = 1000

# Número de funções
num_funcoes = length(funcoes)

resultados = zeros(nx0, vars)

for i in 1:nx0
    resultados[i,:] = mgrad(x0[i,:],itmax)
    global p = gerar_pesos(x0raw[i,:],length(funcoes))
end


pontos_pareto = deepcopy(resultados)

pontospareto = zeros(Float64, nx0, length(funcoes))

for i in 1:nx0
    for j in 1:length(funcoes)
        pontospareto[i,j] = funcoes[j](pontos_pareto[i,:])
    end
end

pontospareto = remover_pontos_dominados(pontospareto)

paretoexport = deepcopy(pontospareto)
arquivo_exportacao = "paretopeso.txt"
writedlm(arquivo_exportacao, paretoexport)

paretoorder = zeros(Float64, nx0, length(funcoes))

paretoorder = ordenar_colunas(pontospareto)

Ds = Lambda(paretoorder)

print(Ds)

