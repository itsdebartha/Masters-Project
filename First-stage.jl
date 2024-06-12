Trt1 = Array{Union{Nothing, String}}(nothing, n, 5000)
Suc1 = Array{Union{Nothing, Int64}}(nothing, n, 5000)
for j in 1:5000
        for i in 1:n
                if i <= n0
                        Trt1[i, j] = "A"
                        Suc1[i, j] = rand(rng, Geometric(θA)) + 1
                elseif i <= 2*n0
                        Trt1[i, j] = "B"
                        Suc1[i, j] = rand(rng, Geometric(θB)) + 1
                else
                        ratioA = sum(Trt1[ : , j] .== "A") / sum(Suc1[Trt1[ : , j] .== "A", j])
                        ratioB = sum(Trt1[ : , j] .== "B") / sum(Suc1[Trt1[ : , j] .== "B", j])
                        θAhat = ratioA == 1 ? (sum(Trt1[ : , j] .== "A") + 0.5) / (sum(Suc1[Trt1[ : , j] .== "A", j]) + 1) : ratioA
                        θBhat = ratioB == 1 ? (sum(Trt1[ : , j] .== "B") + 0.5) / (sum(Suc1[Trt1[ : , j] .== "B", j]) + 1) : ratioB
                        RA = (2θAhat - θAhat * θBhat) / 2(θAhat + θBhat - θAhat * θBhat)
                        RB = 1 - RA
                        Trt1[i, j] = sample(rng, ["A", "B"], pweights([RA, RB]))
                        Suc1[i, j] = (Trt1[i, j] == "A" ? rand(rng, Geometric(θAhat)) : rand(rng, Geometric(θBhat))) + 1
                end
        end
end
