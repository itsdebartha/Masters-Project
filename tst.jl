tstat = Array{Union{Nothing, Float64}}(nothing, 5000)

for j in 1:5000
    NAn = sum(Trt1[:, j] .== "A")
    NBn = sum(Trt1[:, j] .== "B")
    XAnbar = mean(Suc1[Trt1[:, j] .== "A", j])
    XBnbar = mean(Suc1[Trt1[:, j] .== "B", j])
    θML = (NAn + NBn) / (NAn*XAnbar + NBn*XBnbar)
    tstat[j] = √n * (1/XAnbar - 1/XBnbar) / (2*θML*√(1-θML))
end

sort(tstat)[4750]  #for finding the critical point
mean(tstat .> x)  #where x is the critical point
