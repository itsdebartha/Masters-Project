Trt2B = Array{Union{Nothing, String}}(nothing, n, 5000)
Suc2B = Array{Union{Nothing, Int64}}(nothing, n, 5000)
for j in 1:size(Trt2B, 2)
        rB = Suc1[findall(Trt1[ : , j] .== "B"), j]
        y = length(rB)
        for i in 1:y
                if i <= n0/2
                        Trt2B[i, j] = "A"
                        Suc2B[i, j] = rand(rng, Geometric(θBA * exp(-β*(rB[i] - 1) ) ) ) + 1
                elseif i <= n0
                        Trt2B[i, j] = "B"
                        Suc2B[i, j] = rand(rng, Geometric(θBB * exp(-β*(rB[i] - 1) ) ) ) + 1
                else
                        θBAhat = (θB + 1) / (mean(Suc2B[Trt2B[:, j] .== "A", j]) * (1 - (1 - θB)*exp(β)) + 2)
                        θBBhat = (θB + 1) / (mean(Suc2B[Trt2B[:, j] .== "B", j]) * (1 - (1 - θB)*exp(β)) + 2)
                        RBA = (2*(θBAhat * exp(-β*(rB[i] - 1) )) - (θBAhat * exp(-β*(rB[i] - 1) ))*(θBBhat * exp(-β*(rB[i] - 1) )) / ((θBAhat * exp(-β*(rB[i] - 1) )) + (θBBhat * exp(-β*(rB[i] - 1) )) - (θBAhat * exp(-β*(rB[i] - 1) ))*(θBBhat * exp(-β*(rB[i] - 1) ))))
                        RBB = 1 - RBA
                        Trt2B[i, j] = sample(rng, ["A", "B"], pweights([RBA, RBB]))
                        Suc2B[i, j] = (Trt2B[i, j] == "A" ? rand(rng, Geometric(θBAhat * exp(-β*(rB[i] - 1) ))) : rand(rng, Geometric(θBBhat * exp(-β*(rB[i] - 1) )))) + 1
                end
        end
end
