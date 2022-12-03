f = open("Input.txt", "r");
function RockPaperScissors(left, right)
    if left == right #Equal
        return 3 + right + 1
    elseif mod(left + 1, 3) == right #Win
        return 6 + right + 1
    else
        return 0 + right + 1
    end

end

global SignToScore = Dict{String,Integer}("A" => 0, "B" => 1, "C" => 2)
global SignToDiff = Dict{String,Integer}("X" => -1, "Y" => 0, "Z" => +1)
global SignToMatch = Dict{String,String}("A" => "X", "B" => "Y", "C" => "Z")

global resultingScore = 0
while !eof(f)
    line = readline(f)
    a = split(line, " ")
    value = SignToScore[a[1]]
    winloss = SignToDiff[a[2]]
    values = [value, mod(value + winloss, 3)]
    result = RockPaperScissors(values[1], values[2])
    println("$line : $values -> $result")
    global resultingScore += result
end
println(resultingScore)
close(f);