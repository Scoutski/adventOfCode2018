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

  return preReqs
end

def getLetterOffset(letter)
  # A starts at 65 and every letter has an offset of 60
  return letter.ord - 64 + 60
end

def calculateTime (hash)
  completedLetters = []
  workers = [false,false,false,false,false]
  workerTimeRemaining = [0, 0, 0, 0, 0]
  timePassed = 0

  keys = hash.keys
  while completedLetters.length != keys.length
    availableTasks = []
    # timePassed += 1
    for i in 0..workers.length-1 do
      if workers[i] != false
        # puts "Worker ##{i} is working on #{workers[i]} and has #{workerTimeRemaining[i]} seconds remaining..."
        workerTimeRemaining[i] -= 1

        if workerTimeRemaining[i] == 0
          # puts "Worker ##{i} has finished #{workers[i]}!"
          completedLetters.push(workers[i])
          workers[i] = false
        end
      end
    end

    break if completedLetters.length == keys.length
    timePassed += 1

    for i in 0..keys.length-1 do
      # Check that it hasn't already been added
      if !completedLetters.include?(keys[i])
        # Check if the letter has incomplete prereqs
        hasPrereqs = false
        for j in 0..hash[keys[i]].length-1 do
          if !completedLetters.include?(hash[keys[i]][j])
            hasPrereqs = true
          end
        end

        if !hasPrereqs
          availableTasks.push(keys[i])
        end
      end
    end

    availableTasks.sort!

    for i in 0..availableTasks.length-1 do
      for j in 0..workers.length-1 do
        if (!workers.include?(availableTasks[i]) && workers[j] == false)
          workers[j] = availableTasks[i]
          workerTimeRemaining[j] = getLetterOffset(availableTasks[i])
          j = workers.length-1
        end
      end
    end

    availableTasks = []
  end

  return timePassed;
end

def main ()
  lines = extractLinesFromFile('../day7q1/input.txt')
  letterPrereqs = getPrereqsForLines(lines)
  return calculateTime(letterPrereqs)
end

puts main()