# Sort lines in correct order

def extractLinesFromFile (fileName)
  return IO.readlines(fileName)
end

def sortLines (lines)
  regex = /\d*-(\d*)-(\d*) (\d*):(\d*)/

  return lines.sort do |a, b|
    aTime = a.scan(regex)[0]
    bTime = b.scan(regex)[0]

    aa = Time.new(2018, aTime[0], aTime[1], aTime[2], aTime[3])
    bb = Time.new(2018, bTime[0], bTime[1], bTime[2], bTime[3])

    aa <=> bb
  end
end

def processLines (lines)
  res = {}
  guardRegex = /Guard #(\d*)/
  currentGuard = -1

  for i in 0..lines.length-1 do
    guardNumber = lines[i].scan(guardRegex)[0]
    if (guardNumber && guardNumber.length > 0)
      currentGuard = guardNumber[0]
    end

    if (lines[i].match(/falls asleep/))
      minuteOfSleep = lines[i].scan(/:(\d*)/)[0][0]
      minuteOfWake = lines[i+1].scan(/:(\d*)/)[0][0]

      for j in minuteOfSleep.to_i..(minuteOfWake.to_i-1) do
        if (!res[currentGuard])
          res[currentGuard] = {}
        end

        if res[currentGuard][j]
          res[currentGuard][j] += 1
        else
          res[currentGuard][j] = 1
        end
      end
    end
  end

  return res
end

def findHighest (hash)
  guardNumbers = hash.keys
  highestNumber = -1
  highestMinute = -1
  highestGuard = -1

  for i in 0..guardNumbers.length-1 do
    minutesRecorded = hash[guardNumbers[i]].keys
    for j in 0..minutesRecorded.length-1 do
      if hash[guardNumbers[i]][minutesRecorded[j]] > highestNumber
        highestNumber = hash[guardNumbers[i]][minutesRecorded[j]]
        highestMinute = minutesRecorded[j]
        highestGuard = guardNumbers[i]
      end
    end
  end

  return highestGuard, highestMinute
end

def calculateSolution (hash, guardNumber)
  minuteKeys = hash.keys
  highestMinute = -1

  for i in 0..minuteKeys.length-1 do
    if hash[minuteKeys[i]] > highestMinute
      highestMinute = minuteKeys[i]
    end
  end

  return guardNumber.to_i * highestMinute.to_i
end

def main ()
  lines = extractLinesFromFile('../day4q1/input.txt')
  sortedLines = sortLines(lines)
  processedHash = processLines(sortedLines)
  highestGuard = findHighest(processedHash)
  return highestGuard[0].to_i * highestGuard[1].to_i
end

puts main()
