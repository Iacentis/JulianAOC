

function GetBestGroups(nBestValues)
    f = open("Input.txt", "r");
    BestGroupValues = zeros(3)
    group = 0
    groupValue = 0
    while !eof(f)
        line = readline(f)
        if isempty(line)
            for i in 1:nBestValues
                if groupValue > BestGroupValues[i]
                    BestGroupValues[i] = groupValue
                    break
                end
            end
            groupValue = 0
            group += 1
            continue
        end
        value = parse(Int32, line)
        groupValue += value
    end
    return sum(BestGroupValues)
    close(f)
end
println(GetBestGroups(0))
@time begin
    println(GetBestGroups(1))
    println(GetBestGroups(3))
end