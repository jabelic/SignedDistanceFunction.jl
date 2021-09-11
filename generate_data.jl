# module Generate
L = 1.5
"""
    generate_array(len, rev)

    array size: len
    reverse sort: rev=true
"""
function generate_array(len::Int=100, rev::Bool=false)
    tmp_length = len * 3

    # tmp = sort(append!([0.0], [rand() for i = 1:tmp_length])) # for debug
    
    if rev
        tmp = sort([rand() * 1.5 for i = 1:tmp_length], rev=true)
    else
        tmp = sort([rand() * 1.5 for i = 1:tmp_length])
    end
    # cutout element > len

    indexs::Array = sort([rand((1:tmp_length)) for j = 1:len])
    tmp = [tmp[indexs[i]] for i = 1:len]
    if !(0.0 in tmp)
        popat!(tmp, rand(1:len))
        if rev 
            tmp = push!(tmp, 0.0)
        else
            tmp = pushfirst!(tmp, 0.0)
        end
    end
    if !(L in tmp)
        popat!(tmp, rand(2:len))
        if rev 
            tmp = pushfirst!(tmp, L)
        else
            tmp = push!(tmp, L)
        end
    end
    return tmp
end


function generate_circle_y(ary::Array, str)
    r = L / 2
    if str == "pos"
        tmp = [(r^2 - (x - r)^2) for x in ary]
    else
        tmp = [-(r^2 - (x - r)^2) for x in ary]
    end
    return tmp
end

using LinearAlgebra
function get_mock_data(L::Float64=1.5, N::Int=100)
    area_x = [i for i = -L:2 * L / N:L] # len:N+1 
    area_y = [i for i = -L:2 * L / N:L] # len:N+1
    data_length = 50
    data_x = append!(generate_array(50), generate_array(50, true))
    data_y = append!(generate_circle_y(data_x[1:data_length], "pos"), generate_circle_y(data_x[data_length + 1:data_length * 2], "neg"))
    # println(typeof(Vector(data_x)))
    # println(reduce(append!, (data_x, data_y), init=Float64[]))

    # println(tmp)
    # tmp = Matrix(data_length * 2, 2)
    tmp = zeros(Float64, data_length * 2, 2)
    for i = 1:data_length * 2
        tmp[i, 1] = data_x[i]
        tmp[i, 2] = data_y[i]
    end
    return tmp
end
println(get_mock_data(1.5, 100))
# generate_array(100)
# end