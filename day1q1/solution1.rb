def processFrequency(lines)
  return lines.reduce(0) { |sum, val|
    sum = sum + val.to_i }
end

def processFileInput (fileName)
  return IO.readlines(fileName)
end

def main()
  return processFrequency(processFileInput("./input1.txt"));
end

result = main()
puts result