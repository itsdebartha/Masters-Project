tstatA = Array{Union{Nothing, Float64}}(nothing, 5000)

for j in 1:5000
    NAAnAA = sum(Trt2A[:, j] .== "A")
    NABnAB = sum(Trt2A[:, j] .== "B")
    nA = NAAnAA + NABnAB
    XAAnAAbar = mean(Suc2A[Trt2A[:, j] .== "A", j])
    XABnABbar = mean(Suc2A[Trt2A[:, j] .== "B", j])
    θAML = (NAAnAA + NABnAB) / (NAAnAA*XAAnAAbar + NABnAB*XABnABbar)
    tstatA[j] = √nA * (1/XAAnAAbar - 1/XABnABbar) / (2*θAML*√(1-θAML))
end
sort(tstatA)[4750]  #to find the critical point
mean(tstatA .> x)  #where x is the critical point
