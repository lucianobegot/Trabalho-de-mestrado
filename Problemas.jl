# Definindo os problemas multiobjetivo aqui (em uma estrutura)

struct ProblemMO
    name::String
    nvars::Int
    objectives::Vector{Function}
    lb::Float64  # limites inferiores
    ub::Float64  # limites superiores
end

function make_AP3()
    name   = "AP3"
    nvars  = 2
    # Limites
    lb = -1.0
    ub = 3.0

    f1(x) = 0.25*((x[1]-1)^4 + 2*(x[2]-2)^4)
    f2(x) = (x[2] - x[1]^2)^2 + (1 - x[1])^2

    objectives = [
        (x)->f1(x),
        (x)->f2(x)
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_AP4()
    name   = "AP4"
    nvars  = 3
    # Limites
    lb = -1.0
    ub = 3.0

    objectives = [
        x -> (1/9)*((x[1]-1)^4+2*(x[2]-2)^4+3*(x[3]-3)^4),
        x -> exp((x[1]+x[2]+x[3])/3) + x[1]^2+x[2]^2+x[3]^2,
        x -> (1/12)*(3*exp(-x[1])+4*exp(-x[2])+3*exp(-x[3]))
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_enc()
    name   = "Exponencial não convexo"
    nvars  = 1
    # Limites
    lb = -1.0
    ub = 3.0

    objectives = [
        x -> x[1]^4-2*(x[1])^2+1,
        x -> exp(x[1]^3-2*x[1]^2)
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_SLCDT2()
    name   = "SLCDT2"
    nvars  = 10
    #Limites
    lb = -1.0
    ub = 1.0
    a1 = ones(10)
    a2 = -ones(10)
    a3 = [-(-1)^i for i in 1:10]
    objectives = [
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

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_DGO1()
    name   = "DGO1"
    nvars  = 1
    # Limites
    lb = -10.0
    ub = 13.0

    objectives = [
        x -> sin(x[1]),
        x -> sin(x[1]+0.7)
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_Far1()
    name   = "Far1"
    nvars  = 2
    # Limites
    lb = -1.0
    ub = 1.0

    objectives = [
        x -> -2*exp(15*(-(x[1]-0.1)^2 - x[2]^2)) - exp(20*(-(x[1]-0.6)^2 - (x[2]-0.6)^2)) + exp(20*(-(x[1]+0.6)^2 - (x[2]-0.6)^2)) + exp(20*(-(x[1]-0.6)^2 - (x[2]+0.6)^2)) + exp(20*(-(x[1]+0.6)^2 - (x[2]+0.6)^2)),
        x -> -2*exp(20*(-x[1]^2 - x[2]^2)) + exp(20*(-(x[1]-0.4)^2 - (x[2]-0.6)^2)) - exp(20*(-(x[1]+0.5)^2 - (x[2]-0.7)^2)) - exp(20*(-(x[1]-0.5)^2 - (x[2]+0.7)^2)) + exp(20*(-(x[1]+0.4)^2 - (x[2]+0.8)^2))
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_SSFYY2()
    name   = "SSFYY2"
    nvars  = 1
    # Limites
    lb = -10.0
    ub = 10.0

    objectives = [
        x -> 10 - 10* cos(x[1]*pi/2) + x[1]^2 ,
        x -> (x[1]-4)^2
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_PB()
    name   = "Problema Básico"
    nvars  = 1
    # Limites
    lb = -10.0
    ub = 10.0

    objectives = [
        x -> (x[1]+1)^2 ,
        x -> (x[1]-1)^2
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_DGO1M()
    name   = "DGO1 Modificado"
    nvars  = 1
    # Limites
    lb = -10.0
    ub = 13.0

    objectives = [
        x -> sin(x[1]) + 0.1 * cos(5 * x[1]) * sin(x[1]),
        x -> sin(x[1] + 0.7) + 0.1 * cos(5 * x[1]) * sin(x[1] + 0.7)
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_LOV1()
    name   = "LOV1"
    nvars  = 2
    # Limites
    lb = -10.0
    ub = 10.0

    objectives = [
        x -> 1.05*x[1]^2+0.98*x[2]^2,
        x -> 0.99(x[1]-3)^2+1.03(x[2]-2.5)^2
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_MHHM1()
    name   = "MHHM1"
    nvars  = 2
    # Limites
    lb = 0.0
    ub = 2.0

    objectives = [
        x -> (x[1]-0.8)^2,
        x -> (x[1]-0.85)^2,
        x -> (x[1]-0.9)^2
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_MHHM2()
    name   = "MHHM2"
    nvars  = 2
    # Limites
    lb = 0.0
    ub = 2.0

    objectives = [
        x -> (x[1]-0.8)^2+(x[2]-0.6)^2,
        x -> (x[1]-0.85)^2+(x[2]-0.7)^2,
        x -> (x[1]-0.9)^2+(x[2]-0.6)^2
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_QV1()
    name   = "QV1"
    nvars  = 10
    # Limites
    lb = -5.12
    ub = 5.12

    objectives = [
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

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_MOP2()
    name   = "MOP2"
    nvars  = 15
    # Limites
    lb = -4.0
    ub = 4.0

    objectives = [
        x -> (1 - exp(-sum((x[j] - 1)^2 / 15 for j in 1:15))),
        x -> (1 - exp(-sum((x[j] + 1)^2 / 15 for j in 1:15)))
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_VU1()
    name   = "VU1"
    nvars  = 2
    # Limites
    lb = -3.0
    ub = 3.0

    objectives = [
        x -> 1/(x[1]^2+x[2]^2 + 1),
        x -> x[1]^2+3*x[2]^2 + 1
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_VU2()
    name   = "VU2"
    nvars  = 2
    # Limites
    lb = -3.0
    ub = 3.0

    objectives = [
        x -> x[1]+x[2]+1,
        x -> x[1]^2+2*x[2] - 1
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_mgh26M()
    name   = "mgh26 Modificado"
    nmgh26m = 50
    nvars  = nmgh26m
    # Limites
    lb = -1.0
    ub = 1.0

    objectives = []

    for i in 1:nmgh26m
        push!(objectives, x -> nmgh26m -sum(cos(x[j]) for j in 1:nmgh26m)+ i*(1-cos(x[i]))-sin(x[i]) )
    end

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_JOS1()
    name   = "JOS1"
    nvars  = 100
    # Limites
    lb = -100.0
    ub = 100.0

    function jos(x, shift=0.0)
        return sum((xi - shift)^2/ 100 for xi in x)
    end

    objectives = [
        x -> jos(x),        # Sem deslocamento
        x -> jos(x, 2)    # Com deslocamento de 1.5
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_mgh26()
    name   = "mgh26"
    nmgh26 = 4
    nvars  = nmgh26
    # Limites
    lb = -1.0
    ub = 1.0

    objectives = []

    for i in 1:nmgh26
        push!(objectives, x -> nmgh26 -sum(cos(x[j]) for j in 1:nmgh26)+ i*(1-cos(x[i]))-sin(x[i]))
    end

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_DGO1M2()
    name   = "DGO1 Modificado 2"
    nvars  = 100
    # Limites
    lb = -10.0
    ub = 13.0

    objectives = [
        x -> sum(sin(x[i]) + 0.1 * cos(5 * x[i]) * sin(x[i]) for i in 1:100),
        x -> sum(sin(x[i] + 0.7) + 0.1 * cos(5 * x[i]) * sin(x[i] + 0.7) for i in 1:100)
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_DGO1M3()
    name   = "DGO1 Modificado 3"
    nvars  = 1
    # Limites
    lb = -10.0
    ub = 13.0

    objectives = [x -> sin(x[1] + 0.7 * i) + 0.1 * cos(5 * x[1]) * sin(x[1] + 0.7 * i) for i in 1:100]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_MOP5()
    name   = "MOP5 Viennet"
    nvars  = 2
    # Limites
    lb = -30.0
    ub = 30.0

    objectives = [
        x -> 0.5 * (x[1]^2 + x[2]^2) + sin(x[1]^2 + x[2]^2),
        x -> ((3 * x[1] - 2 * x[2] + 4)^2) / 8 + ((x[1] - x[2] + 1)^2) / 27 + 15,
        x -> 1 / (x[1]^2 + x[2]^2 + 1) - 1.1 * exp(-(x[1]^2 + x[2]^2))
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_MOP5M()
    name   = "MOP5 Modificado "
    nvien = 200
    nvars  = nvien
    # Limites
    lb = -30.0
    ub = 30.0

    objectives = [
        x -> 0.5 * sum(x[i]^2 for i in 1:nvien) + sin(sum(x[i]^2 for i in 1:nvien)),  # f1 adaptada
        x -> (3 * x[1] - 2 * x[2] + 4)^2 / 8 + (x[1] - x[2] + 1)^2 / 27 + 15,      # f2 adaptada
        x -> 1 / (sum(x[i]^2 for i in 1:nvien) + 1) - 1.1 * exp(-sum(x[i]^2 for i in 1:nvien)) # f3 adaptada
    ]

    # Adicionando variações para chegar a 10 funções
    for i in 4:10
        push!(objectives, x -> 0.5 * sum(x[j]^2 for j in 1:nvien) + sin(i * sum(x[j]^2 for j in 1:nvien)) +
                            (3 * x[1] - 2 * x[2] + i)^2 / (8 + i) +
                            (x[1] - x[2] + i)^2 / (27 + i) +
                            1 / (sum(x[j]^2 for j in 1:nvien) + i) - 1.1 * exp(-(sum(x[j]^2 for j in 1:nvien) + i))
        )
    end

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_LOV2()
    name   = "LOV 2"
    nvars  = 2
    # Limites
    lb = -0.75
    ub = 0.75

    objectives = [
        x -> -x[2],
        x -> (x[2]-x[1]^2)/(x[1]+1)
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_LOV3()
    name   = "LOV 3"
    nvars  = 2
    # Limites
    lb = -20.0
    ub = 20.0

    objectives = [
        x -> -x[1]^2-x[2]^2,
        x -> -(x[1]-6)^2+(x[2]+0.3)^2
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_LOV6()
    name   = "LOV 6"
    nvars  = 2
    # Limites
    lb = 1.0
    ub = 4.0

    objectives = [
        x -> 2*sqrt(x[1]),
        x -> (x[1]*(1-x[2])+5)
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_Toi10()
    name   = "Toi10 Rosenbrock"
    nvars  = 4
    # Limites
    lb = -2.0
    ub = 2.0

    objectives = []

    for i in 1:3
        push!(objectives, x -> 100*(x[i+1]-x[i]^2)^2+(x[i+1]-1)^2)
    end

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_Toi8()
    name   = "Toi8 Tridia"
    nvars  = 3
    # Limites
    lb = -1.0
    ub = 1.0

    objectives = []

    for i in 1:3
        push!(objectives, x -> 100*(x[i+1]-x[i]^2)^2+(x[i+1]-1)^2)
    end

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_Toi9()
    name   = "Toi9 Shifted Tridia"
    nvars  = 4
    # Limites
    lb = -1.0
    ub = 1.0

    objectives = []

    push!(objectives, x -> (2*x[1]-1)^2+x[2]^2)

    for i in 2:3
        push!(objectives, x -> i*(2*x[i-1]-x[i])^2-(i-1)*x[i-1]^2+i*x[i]^2)
    end
    
    push!(objectives, x -> 4*(2*x[3]-x[4])^2 -3*x[3]^2)

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_SSFYY1()
    name   = "SSFYY1"
    nvars  = 2
    # Limites
    lb = -100.0
    ub = 100.0

    objectives = [
        x -> x[1]^2 + x[2]^2 ,
        x -> (x[1]-1)^2 + (x[2]-2)^2
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

function make_FF1()
    name   = "FF1"
    nvars  = 3
    # Limites
    lb = -1.0
    ub = 1.0

    objectives = []

    push!(objectives, x -> 1 - exp(-((x[1] - 1)^2 + (x[2] + 1)^2)))

    push!(objectives, x -> 1 - exp(-((x[1] + 1)^2 + (x[2] - 1)^2)))

    return ProblemMO(name, nvars, objectives, lb, ub)
end



##########################################
# Aplicação real RE2-2-4 (A Supplementary File for “An Easy-to-use Real-world Multi-objective Optimization Problem Suite” Ryoji Tanabe, Hisao Ishibuchi∗)
##########################################

function make_RE2_2_4()
    name   = "RE2-2-4"
    nvars  = 2
    # Limites
    lb = 0.5
    ub = 50.0

    # Parâmetros do problema
    sigmab_max = 700.0      # σb,max = 700 kg/cm²
    tau_max    = 450.0      # τmax    = 450 kg/cm
    delta_max  = 1.5        # δmax    = 1.5 cm
    E          = 700000.0   # E = 700000 kg/cm²

    # σk(x) = E*x1^2/100
    function sigma_k(x)
        return (E * x[1]^2)/100.0
    end

    # σb(x) = 4500/(x1*x2)
    function sigma_b(x)
        return 4500.0/(x[1]*x[2])
    end

    # τ(x) = 1800/x2
    function tau(x)
        return 1800.0/x[2]
    end

    # δ(x) = 56.2×10^4 / (E*x1*x2^2)
    function delta_h(x)
        return 56.2e4 / (E * x[1] * x[2]^2)
    end

    # Restrições g1..g4 (≥0):
    # g1(x)=1.0 - (σb/σb_max), g2(x)=1.0 - τ/τmax, g3=1.0 - δ/δmax, g4=1.0 - σb/σk
    function g1_RE224(x)
        return 1.0 - sigma_b(x)/sigmab_max
    end

    function g2_RE224(x)
        return 1.0 - tau(x)/tau_max
    end

    function g3_RE224(x)
        return 1.0 - delta_h(x)/delta_max
    end

    function g4_RE224(x)
        return 1.0 - sigma_b(x)/sigma_k(x)
    end

    # Primeiro objetivo: f1(x) = "minimizar peso da tampa"
    # f1(x)= x1 +120*x2
    function f1_RE224(x)
        return x[1] + 120.0*x[2]
    end

    # Segundo objetivo: f2(x)= ∑ max{-gi(x),0}, i=1..4
    function f2_RE224(x)
        local sum_viol = 0.0
        sum_viol += max(-g1_RE224(x), 0)
        sum_viol += max(-g2_RE224(x), 0)
        sum_viol += max(-g3_RE224(x), 0)
        sum_viol += max(-g4_RE224(x), 0)
        return sum_viol
    end

    # Montar o vetor de funções objetivo:
    objectives = [
        x -> f1_RE224(x),  # Minimizar peso
        x -> f2_RE224(x)   # Minimizar violações
    ]

    return ProblemMO(name, nvars, objectives, lb, ub)
end

################################################
# Lista com todos os problemas
################################################

problems = ProblemMO[]

# 1) AP3
push!(problems, make_AP3())

# 2) AP4
push!(problems, make_AP4())

# 3) Exponencial não convexo
push!(problems, make_enc())

# 4) SLCDT2
push!(problems, make_SLCDT2())

# 5) DGO1
push!(problems, make_DGO1())

# 6) Far1
push!(problems, make_Far1())

# 7) SSFYY2
push!(problems, make_SSFYY2())

# 8) Problema Básico
push!(problems, make_PB())

# 9) DGO1 Modificado
push!(problems, make_DGO1M())

# 10) LOV1
push!(problems, make_LOV1())

# 11) MHHM1
push!(problems, make_MHHM1())

# 12) MHHM2
push!(problems, make_MHHM2())

# 13) QV1
push!(problems, make_QV1())

# 14) MOP2
push!(problems, make_MOP2())

# 15) VU1
push!(problems, make_VU1())

# 16) VU2
push!(problems, make_VU2())

# 17) mgh26 Modificado
push!(problems, make_mgh26M())

# 18) JOS1
push!(problems, make_JOS1())

# 19) mgh26
push!(problems, make_mgh26())

# 20) DGO1 Modificado 2
push!(problems, make_DGO1M2())

# 21) DGO1 Modificado 3
push!(problems, make_DGO1M3())

# 22) MOP5 Viennet
push!(problems, make_MOP5())

# 23) MOP5 Modificado
push!(problems, make_MOP5M())

# 24) LOV2
push!(problems, make_LOV2())

# 25) LOV3
push!(problems, make_LOV3())

# 26) LOV6
push!(problems, make_LOV6())

# 27) Toi10 Rosenbrock
push!(problems, make_Toi10())

# 28) Toi8 Tridia
push!(problems, make_Toi8())

# 29) Toi9 Shifted Tridia
push!(problems, make_Toi9())

# 30) SSFYY1
push!(problems, make_SSFYY1())

# 31) FF1
push!(problems, make_FF1())

# 32) RE2-2-4
push!(problems, make_RE2_2_4())


