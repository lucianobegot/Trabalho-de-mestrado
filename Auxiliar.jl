using DelimitedFiles
using Distributions
using ForwardDiff

# Funções Auxiliares

# Tamanho do passo h (pode ser ajustado conforme necessário)
h = 1.0e-6

function derivada_numerica(f, x, h, i)
    # Calcula a derivada parcial numérica da função f no ponto x
    # com relação à i-ésima variável
    x_plus_h = copy(x)
    x_minus_h = copy(x)
    x_plus_h[i] += h
    x_minus_h[i] -= h
    return (f(x_plus_h) - f(x_minus_h)) / (2 * h)
end

function gradienten(f, x, h)
    # Calcula o gradiente de uma função f em um ponto x
    num_var = length(x)
    grad = zeros(num_var)
    for i in 1:num_var
        grad[i] = derivada_numerica(f, x, h, i)
    end
    return grad
end

function gradiente(f, x)
    # Calcula o gradiente de uma função f em um ponto x usando ForwardDiff
    return ForwardDiff.gradient(f, x)
end

function JF(x, h)
    # Calcula a matriz dos gradientes
    num_funcoes = length(funcoes)
    p = zeros(num_funcoes, length(x))
    for i in 1:num_funcoes
        p[i, :] = gradienten(funcoes[i], x,h)
    end
    return p
end

function F(x)
    # Calcula o vetor de funções
    a = zeros(Float64, length(funcoes))
    for i in 1:length(funcoes)
        a[i] = funcoes[i](x)
    end
    return a
end

function fx(x, v)
    # Calcula a função fx
    a = maximum((JF(x, h)) * v)
    return a
end

function norma_2(vetor)
    # Calcula a norma-2 de um vetor
    soma_quadrados = sum(x -> x^2, vetor)
    norma = sqrt(soma_quadrados)
    return norma
end

function norma_infinito(vetor)
    max_val = abs(vetor[1])
    for i in 2:length(vetor)
        if abs(vetor[i]) > max_val
            max_val = abs(vetor[i])
        end
    end
    return max_val
end

function fmin(x, v)
    # Calcula a função fmin
    a = fx(x, v) + 0.5 * (norma_2(v))^2
    return a
end

function leq(vetor1, vetor2)
    # Verifica se todos os componentes de vetor1 são menores ou iguais aos componentes de vetor2
    return all(vetor1 .<= vetor2)
end

function ordenar_colunas(matriz)
    n_linhas, n_colunas = size(matriz)
    
    for j in 1:n_colunas
        matriz[:, j] = sort(matriz[:, j])
    end
    
    return matriz
end

#Função que verifica se um ponto A domina um ponto B
function domina(A, B)
    return all(a <= b for (a, b) in zip(A, B)) && any(a < b for (a, b) in zip(A, B))
end

function atualizar_lista_pontos(pontos, novo_ponto, funcoes)
    # Remover todos os pontos dominados pelo novo ponto
    pontos = filter(p -> !domina([i(novo_ponto) for i in funcoes], [i(p) for i in funcoes]), pontos)

    # Verificar se o novo ponto é dominado por algum ponto existente
    if any(p -> domina([i(p) for i in funcoes], [i(novo_ponto) for i in funcoes]), pontos)
        return pontos  # Se o novo ponto for dominado, não o adiciona
    else
        push!(pontos, novo_ponto)  # Caso contrário, adiciona o novo ponto
        return pontos
    end
end

# Função para remover pontos dominados de uma matriz e retornar uma matriz bidimensional
function remover_pontos_dominados(pontos)
    n_pontos = size(pontos, 1)
    não_dominados = []

    for i in 1:n_pontos
        dominado = false
        for j in 1:n_pontos
            if i != j && domina(pontos[j, :], pontos[i, :])
                dominado = true
                break
            end
        end
        if !dominado
            push!(não_dominados, pontos[i, :])
        end
    end

    # Convertendo a lista de pontos não dominados em uma matriz bidimensional
    return hcat(não_dominados...)'
end

# Função para remover pontos dominados de uma matriz e retornar uma matriz bidimensional
function remover_pontos_dominados_var_otimizado(pontos,funcoes)
    n_pontos = size(pontos, 1)
    n_funcoes = length(funcoes)
    
    # Prealocar a matriz para armazenar os valores das funções objetivo para todos os pontos
    valores_objetivo = zeros(n_pontos, n_funcoes)
    
    # Calcular os valores das funções objetivo uma vez
    for i in 1:n_pontos
        valores_objetivo[i, :] = [f(pontos[i, :]) for f in funcoes]
    end

    não_dominadosvar = []
    não_dominados = []
    
    for i in 1:n_pontos
        dominado = false
        b = valores_objetivo[i, :]
        
        for j in 1:n_pontos
            a = valores_objetivo[j, :]
            if i != j && domina(a, b)
                dominado = true
                break
            end
        end

        if !dominado
            push!(não_dominadosvar, pontos[i, :])
            push!(não_dominados, b)
        end
    end

    # Convertendo a lista de pontos não dominados em uma matriz bidimensional
    ret1 = hcat(não_dominadosvar...)'
    ret2 = hcat(não_dominados...)'
    return ret1, ret2
end


# Função para remover pontos dominados de uma matriz e retornar uma matriz bidimensional
function remover_pontos_dominados_var(pontos)
    n_pontos = size(pontos, 1)
    não_dominadosvar = []
    não_dominados = []


    for i in 1:n_pontos
        dominado = false
        b = [f(pontos[i, :]) for f in funcoes]
        for j in 1:n_pontos
            a = [f(pontos[j, :]) for f in funcoes]
            if i != j && domina(a, b)
                dominado = true
                break
            end
        end
        if !dominado
            push!(não_dominadosvar, pontos[i, :])
            push!(não_dominados,b)
        end
    end

    # Convertendo a lista de pontos não dominados em uma matriz bidimensional
    ret1 = hcat(não_dominadosvar...)'
    ret2 = hcat(não_dominados...)'
    return ret1, ret2
end

function remover_pontos_repetidos(matriz)
    # Conjunto para armazenar os pontos únicos
    pontos_unicos = Set{Vector{Float64}}()
    
    # Itera sobre cada linha da matriz
    for i in 1:size(matriz, 1)
        ponto = matriz[i, :]
        # Adiciona o ponto ao conjunto se não for repetido
        push!(pontos_unicos, ponto)
    end
    
    # Converte o conjunto de pontos únicos de volta para uma matriz
    matriz_unica = hcat(collect(pontos_unicos)...)
    return transpose(matriz_unica)
end

function num_vars(func)
    # Tenta inferir o número de variáveis usando um vetor de teste
    test_vec = [0.0]  # Começa com um vetor de um elemento
    while true
        try
            func(test_vec)
            return length(test_vec)
        catch e
            if isa(e, BoundsError)
                push!(test_vec, 0.0)  # Aumenta o tamanho do vetor de teste
            else
                rethrow(e)
            end
        end
    end
end

function maxvars(funcs)
    max_vars = 0
    for func in funcs
        num = num_vars(func)
        if num > max_vars
            max_vars = num
        end
    end
    return max_vars
end

#Função que gera os pesos
function gerar_pesos(x0,m)
    n = m-1
    soma = 0
    phi = zeros(n)
    x = zeros(n+1)
    for i in 1:n
        phi[i] = x0[i]
        x[i] = (1 - soma)*(1 - phi[i]^(1/(n+1-i)))
        soma = soma + x[i]
    end
    x[n+1] = 1- soma
    return x
end