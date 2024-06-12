tstatB = Array{Union{Nothing, Float64}}(nothing, 5000)

for j in 1:5000
    NBAnBA = sum(Trt2B[:, j] .== "A")
    NBBnBB = sum(Trt2B[:, j] .== "B")
    nB = NBAnBA + NBBnBB
    XBAnBAbar = mean(Suc2B[Trt2B[:, j] .== "A", j])
    XBBnBBbar = mean(Suc2B[Trt2B[:, j] .== "B", j])
    θBML = (NBAnBA + NBBnBB) / (NBAnBA*XBAnBAbar + NBBnBB*XBBnBBbar)
    tstatB[j] = √nB * (1/XBAnBAbar - 1/XBBnBBbar) / (2*θBML*√(1-θBML))
end
sort(tstatB)[4750]  #to find the critical point
mean(tstatB .> x)  #where x is the critical point
