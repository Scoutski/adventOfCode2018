def processFileInput (fileName)
  return IO.readlines(fileName)
end

def processLine(line)
  cont = {}
  for i in 0..line.length-2
    if cont[line[i]]
      cont[line[i]] += 1
    else
      cont[line[i]] = 1
    end
  end

  twoOf = cont.has_value?(2) ? 1 : 0
  threeOf = cont.has_value?(3) ? 1 : 0

  return twoOf, threeOf
end

def main()
  lines = processFileInput("./input.txt")
  checkSum = [0, 0]
  for i in 0..lines.length-1
    lineResult = processLine(lines[i])
    checkSum[0] += lineResult[0]
    checkSum[1] += lineResult[1]
  end

  return checkSum[0] * checkSum[1]
end

result = main()
puts result