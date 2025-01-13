include("Problemas.jl")
include("metrica.jl")
include("Auxiliar.jl")

importfiltro = "paretofiltro.txt"
paretofiltro = readdlm(importfiltro, Float64)

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

function verificar_lista(valores)
    # Encontrar os índices dos valores maiores que -10^(-6)
    indices_adequados = findall(x -> x > -10^(-3), valores)

    if length(indices_adequados) == 0
        println("Não foram encontrados indices adequados")
    else
        #println("Valores menores que -10^(-6) encontrados nos índices: ", indices_adequados)
        println("Foram encontrados ", length(indices_adequados), " indices adequados de ", size(paretovar,1)," totais")
    end
    return indices_adequados
end

check = []

