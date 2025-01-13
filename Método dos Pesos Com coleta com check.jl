using JuMP, NLPModels, NLPModelsJuMP, Clp, Ipopt, LinearAlgebra, PlotlyJS, Plots, BenchmarkTools

include("Problemas.jl")
include("metrica.jl")
include("check pareto critico.jl")

@time begin
# Escolhendo o problema a ser resolvido
problema = 29
funcoes = matriz_de_problemas[problema]
vars = variaveis[problema] #número de variáveis do problema

# Ponto onde queremos calcular o gradiente
a = -1.  # Valor inicial do intervalo do ponto inicial
b = 1. # Valor final do intervalo do ponto inicial

nx0 = 150 #Número de pontos iniciais

x0raw = readdlm("x0.txt",Float64)
x0 = zeros(nx0, vars)

for i in 1:nx0
    for j in 1:vars
        x0[i, j] = a + (b - a) * x0raw[i,j]
    end
end

# Geramos os pesos da soma
p = gerar_pesos(x0raw[1,:],length(funcoes))

# Definimos a função soma
function Fp(x)
    total = 0.0
    for i in 1:length(funcoes)
        total += p[i] * funcoes[i](x)
    end
    return total    
end

#função de coleta de pontos. Coleta o ponto x e o adiciona à lista
function coletar(lista,x)
    l0 = zeros(Float64,1,length(x))
    l0[1,:] .= x
    y = vcat(lista,l0)
    return y
end

function mgrad(x, itmax)
    e = 1.0e-6
    #c = Inf
    c = 1.0e-5
    b = deepcopy(x)
    k = 0
    alpha = 0.01
    btd0 = nothing
    g = gradiente(Fp, b)
    
    # Matriz para armazenar os valores de b durante a busca linear
    b_values = zeros(Float64, 1, length(b))
    b_values[1, :] .= b

    while maximum(abs.(g)) >= e && k < itmax #&& maximum(abs.(g)) <= 100
        g = gradiente(Fp, b)
        d = -1 * g
        t = 1.0
        factor = (g')* d

        # Busca linear com Armijo
        while Fp(b + t * d) > Fp(b) + alpha * t * factor
            t = t / 2
            btd0 = b
            btd = b + t * d
            direction = btd - btd0
            gd = (g')* direction
            max = maximum(gd)
            if maximum(abs.(gradiente(Fp, b))) <= c && max > -10^(-3)
                b_values = coletar(b_values,btd)    
            end
        end
        
        b = b + t * d

        if maximum(abs.(gradiente(Fp, b))) <= c
            b_values = coletar(b_values,b)   
        end    
        k = k + 1
    end
    if maximum(abs.(gradiente(Fp, b))) <= c
        b_values = coletar(b_values,b)
    end
    println("Número de iterações:", k)
    return b, b_values
end



# Parâmetros do método
itmax = 1000

# Tamanho do passo h (pode ser ajustado conforme necessário)
h = 1.0e-6

# Número de funções
num_funcoes = length(funcoes)


pontos_pareto = mgrad(x0[1,:], itmax)[2]


for i in 2:nx0
    global p = gerar_pesos(x0raw[i,:],length(funcoes))
    global pontos_pareto = vcat(pontos_pareto, mgrad(x0[i,:], itmax)[2])
end


paretovar, pontos_pareto = remover_pontos_dominados_var_otimizado(pontos_pareto,funcoes)

check = []

for i in 1:size(paretovar,1)
    push!(check,PLBenar(paretovar[i,:])[2] )
end

indices = verificar_lista(check)

pontospareto = pontos_pareto[indices,:]

paretoorder = zeros(Float64, length(pontospareto), length(pontospareto[1]))


paretoexport = deepcopy(pontospareto)
arquivo_exportacao = "paretofiltro.txt"
writedlm(arquivo_exportacao, paretoexport)

paretoorder = ordenar_colunas(pontospareto)

Ds = Lambda(paretoorder)

println(Ds)

end
