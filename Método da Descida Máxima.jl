using JuMP, NLPModels, NLPModelsJuMP, CPLEX, GLPK, LinearAlgebra, PlotlyJS, Plots, BenchmarkTools

include("Problemas.jl")
include("metrica.jl")
include("Auxiliar.jl")
@time begin
# Escolhendo problema a ser resolvido
problema = 29
funcoes = matriz_de_problemas[problema]
vars = variaveis[problema] #número de variáveis do problema

# Ponto onde queremos calcular o gradiente
a = -1.  # Valor inicial do intervalo do ponto inicial 
b = 1.  # Valor final do intervalo do ponto inicial

nx0 = 500

#### inicializando o modelo a ser minimizado no problema Linear
A = (JF(zeros(1,vars), h))
m, n = size(A)

# Criando o modelo de otimização
model = Model(CPLEX.Optimizer)
set_silent(model)

# Variáveis de decisão
@variable(model, v[1:n])
@variable(model, z)

# Função objetivo: minimizar z
@objective(model, Min, z)

# Restrições
    for i in 1:m
        @constraint(model,(A * v)[i] <= z)
    end

    @constraint(model, [i=1:n], v[i] <= 1)
    @constraint(model, [i=1:n], v[i] >= -1)

function PLBenar(x0)
    A = (JF(x0, h))
    m, n = size(A)

    # Obtendo todas as restrições do modelo
    for constr in all_constraints(model,include_variable_in_set_constraints=true)
        # Removendo cada restriçã
        delete(model, constr)
    end

    # Restrições
    for i in 1:m
        @constraint(model,(A * v)[i] <= z)
    end

    @constraint(model, [i=1:n], v[i] <= 1)
    @constraint(model, [i=1:n], v[i] >= -1)

    # Resolvendo o modelo
    optimize!(model)

    # Obtendo os resultados
    optimal_v = value.(v)
    optimal_z = value(z)
    return optimal_v, optimal_z
end

function Benar(x0,itmax)
    # Método de Benar
    beta = 0.001
    sigma = 0.5
    k = 0
    xk = deepcopy(x0)
    tao = 1.0e-6
    alpha = -10
    
    while -tao > alpha && k < itmax
        # Cálculo do valor ótimo de (2)
        vk, alpha = PLBenar(xk)

        t = 1
        while leq(F(xk + t * vk), F(xk) + beta * t * JF(xk, h) * vk) == false
            t = t / 2
        end
        
        # Atualização de xk
        xk = xk + t * vk
        k += 1
    end
    
    println("O número final de iterações foi ", k)
    return xk, k
end

# Número de funções
num_funcoes = length(funcoes)


resultados = zeros(nx0, vars)
x0raw = readdlm("x0.txt",Float64)
x0 = zeros(nx0, vars)

for i in 1:nx0
    for j in 1:vars
        x0[i, j] = a + (b - a) * x0raw[i,j]
    end
end


for i in 1:nx0
    result = Benar(x0[i,:],1000)
    resultados[i,:] = result[1]
    println("número atual de calculos:", i)
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
arquivo_exportacao = "paretobenar.txt"
writedlm(arquivo_exportacao, paretoexport)

paretoorder = zeros(Float64, nx0, length(funcoes))

paretoorder = ordenar_colunas(pontospareto)

Ds = Lambda(paretoorder)

println(Ds)

#Plotar fronteira de Pareto

#imagem = zeros(length(pontos_pareto),2)

#xval = range(a, stop=b, length=1000)

#xval = collect(xval)

#yval = zeros(length(xval),2)

#for i in 1:length(pontos_pareto)
#    optimal = [f([pontos_pareto[i]]) for f in funcoes]
#    imagem[i,1] = optimal[1]
#    imagem[i,2] = optimal[2]
#end

#for i in 1:length(xval)
#    optimal = [f([xval[i]]) for f in funcoes]
#    yval[i,1] = optimal[1]
#    yval[i,2] = optimal[2]
#end

#Plots.plot(imagem[:,1], imagem[:,2],seriestype=:scatter, label="Pontos Pareto")
#Plots.plot!(yval[:,1], yval[:,2], xlabel="f1(x)", ylabel="f2(x)", label="Espaço Objetivo")
end
