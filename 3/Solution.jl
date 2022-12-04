
    function CharacterToPriority(character::Char)::Int8
        rawValue = Int(character) - 64
        if rawValue < 33
            rawValue += 26
        elseif rawValue >= 33
            rawValue -= 32
        end
        return rawValue
    end
    
    function CompareStrings(strings::Vector{String})::Int64
        output = 0
        PriorityBitFlags::Vector{Int64} = zeros(length(strings))
    
        for index in eachindex(strings)
            for character in strings[index]
                Priority = CharacterToPriority(character)
                PriorityBitFlag::Int64 = 1 << (Priority - 1) #-1 So that a -> 1, b -> 2, rather than a -> 2, b -> 4
                PriorityBitFlags[index] |= PriorityBitFlag #Equal to itself bitwise or with the new flag
            end
        end
        ResultingBitFlag::Int64 = PriorityBitFlags[1]
        for PriorityBitFlag in PriorityBitFlags
            ResultingBitFlag &= PriorityBitFlag
        end
        flag = 1
        for index in 1:57
            if (ResultingBitFlag & flag) > 0
                output += index
            end
            flag <<= 1
        end
        return output
    end
    
    function Part2(File)::Int32
        result = 0
        while !eof(File) #We haven't reached the end of file
            lines = string.(1:3) #Initialize empty string vector of size 3
            for i in 1:3
                lines[i] = readline(File)
            end
    
            value = CompareStrings(lines)
            result += value
        end
        return result
    end
    
    function Part1(File)::Int32
    
        result = 0
        while !eof(File)
            line = readline(File)
            lineLength = length(line)
            firstHalf = 1:Int(lineLength / 2)
            secondHalf = Int(lineLength / 2 + 1):lineLength
            value = CompareStrings([line[firstHalf], line[secondHalf]])
            result += value
        end
        return result
    end
    
    #ENTRY POINT------------------------------------------------------
    f = open(ARGS[1], "r")
    @time begin
        a = Part1(f)
    end
    println(a)
    seek(f,0)
    @time begin
        a = Part2(f)
    end
    println(a)
    close(f)