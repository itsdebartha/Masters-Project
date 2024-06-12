Trt2A = Array{Union{Nothing, String}}(nothing, n, 5000)
Suc2A = Array{Union{Nothing, Int64}}(nothing, n, 5000)
for j in 1:size(Trt2A, 2)
        rA = Suc1[findall(Trt1[ : , j] .== "A"), j]
        y = length(rA)
        for i in 1:y
                if i <= n0/2
                        Trt2A[i, j] = "A"
                        Suc2A[i, j] = rand(rng, Geometric(θAA * exp(-β*(rA[i] - 1) ) ) ) + 1
                elseif i <= n0
                        Trt2A[i, j] = "B"
                        Suc2A[i, j] = rand(rng, Geometric(θAB * exp(-β*(rA[i] - 1) ) ) ) + 1
                else
                        θAAhat = (θA + 1) / (mean(Suc2A[Trt2A[:, j] .== "A", j]) * (1 - (1 - θA)*exp(β)) + 2)
                        θABhat = (θA + 1) / (mean(Suc2A[Trt2A[:, j] .== "B", j]) * (1 - (1 - θA)*exp(β)) + 2)
                        RAA = (2*(θAAhat * exp(-β*(rA[i] - 1) )) - (θAAhat * exp(-β*(rA[i] - 1) ))*(θABhat * exp(-β*(rA[i] - 1) )) / ((θAAhat * exp(-β*(rA[i] - 1) )) + (θABhat * exp(-β*(rA[i] - 1) )) - (θAAhat * exp(-β*(rA[i] - 1) ))*(θABhat * exp(-β*(rA[i] - 1) ))))
                        RAB = 1 - RAA
                        Trt2A[i, j] = sample(rng, ["A", "B"], pweights([RAA, RAB]))
                        Suc2A[i, j] = (Trt2A[i, j] == "A" ? rand(rng, Geometric(θAAhat * exp(-β*(rA[i] - 1) ))) : rand(rng, Geometric(θABhat * exp(-β*(rA[i] - 1) )))) + 1
                end
        end
end
