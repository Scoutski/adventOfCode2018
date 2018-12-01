def processFrequency(lines)
  freq = 0
  allFreqs = []
  repeatedFreqFound = false
  while !repeatedFreqFound do
    loops = loops + 1
    lines.each do |val|
      freq = freq + val.to_i
      if allFreqs.include? freq
        repeatedFreqFound = true
        break
      end
      allFreqs.push(freq)
    end
  end
  return freq
end

def processFileInput (fileName)
  return IO.readlines(fileName)
end

def main()
  return processFrequency(processFileInput("../day1q1/input1.txt"));
end

result = main()
puts result