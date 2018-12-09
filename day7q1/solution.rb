def extractLinesFromFile (fileName)
  return IO.readlines(fileName)
end

def extractLetters (line)
  regex = /Step ([A-Z]).*step ([A-Z])/
  scanned = line.scan(regex)[0]
  # puts scanned
  return scanned
end

def getPrereqsForLines (lines)
  preReqs = {}
  boop = []
  for i in 0..lines.length-1 do
    processedLine = extractLetters(lines[i])
    if (!preReqs[processedLine[0]])
      preReqs[processedLine[0]] = []
    end

    if (!preReqs[processedLine[1]])
      preReqs[processedLine[1]] = []
    end

    preReqs[processedLine[1]].push(processedLine[0])
  end

  puts preReqs
  return preReqs
end

def determineOrder (hash)
  finalOrder = []
  nextLetter = ''

  keys = hash.keys
  while finalOrder.length != keys.length
    for i in 0..keys.length-1 do
      # Check that it hasn't already been added
      if !finalOrder.include?(keys[i])
        # Check if the letter has incomplete prereqs
        hasPrereqs = false
        for j in 0..hash[keys[i]].length-1 do
          if !finalOrder.include?(hash[keys[i]][j])
            hasPrereqs = true
          end
        end

        if !hasPrereqs
          if nextLetter == '' || keys[i] < nextLetter
            nextLetter = keys[i]
          end
        end
      end
    end

    finalOrder.push(nextLetter)
    nextLetter = ''
  end

  return finalOrder.join('')
end

def main ()
  lines = extractLinesFromFile('./input.txt')
  letterPrereqs = getPrereqsForLines(lines)
  return determineOrder(letterPrereqs)
end

puts main()