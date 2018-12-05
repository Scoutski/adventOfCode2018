def extractLinesFromFile (fileName)
  return IO.readlines(fileName)
end

def processLine (line)
  noMatches = false
  while !noMatches
    changeMade = false
    for i in 0..(line.length-1) do
      if (i <= line.length-1 && line[i].is_a?(String) && line[i+1].is_a?(String))
        if (line[i].upcase == line[i+1].upcase && line[i] != line[i+1])
          changeMade = true
          line.slice!(i..i+1)
        end
      end
    end

    if !changeMade
      noMatches = true
    end
  end

  return line
end

def main ()
  line = extractLinesFromFile('./input.txt')[0]
  return processLine(line)
end

puts main().length