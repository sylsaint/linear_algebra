
function normalize(x)
    x / sqrt(x' * x)
end

function findPerpendicularPart(x, y)
    y - x' * y * x / (x' * x)
end

function gramSchmdit(xs...)
    qs = Array{Array{Float64,1}}(undef, length(xs))
    i = 1 
    for x ∈ xs
        setindex!(qs, x,  i)
        i += 1
    end
    i = 1
    qsLen = length(qs)
    for x ∈ qs 
        if i != 1
            for j in range(i, qsLen, step = 1)
                setindex!(qs, findPerpendicularPart(getindex(qs, i - 1), getindex(qs, j)), j)
            end
        end
        i += 1
    end
    i = 1
    for x ∈ qs
        setindex!(qs, normalize(x),  i)
        i += 1
    end
    return qs
end

a = [1;2;3;0]
b = [2;3;1;0]
c = [3;2;1;0]
d = [0;0;0;1]

qs = gramSchmdit(a, b, c, d)
println(qs)