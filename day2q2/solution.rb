def processFileInput (fileName)
  return IO.readlines(fileName)
end

def processLine(lines, currentIndex)
  solution = ""
  for i in 0..lines.length-1
    if (currentIndex != i)
      diff = 0
      position = -1
      for j in 0..lines[currentIndex].length-2
        if (lines[currentIndex][j] != lines[i][j])
          diff += 1
          position = j
        end
      end
      if (diff == 1)
        solution = lines[currentIndex]
        solution.slice!(position)
      end
    end
  end

  return solution
end

def main()
  lines = processFileInput("../day2q1/input.txt")
  for i in 0..lines.length-1
    lineResult = processLine(lines, i)
    if (lineResult != "")
      return lineResult
    end
  end
end

result = main()
puts result