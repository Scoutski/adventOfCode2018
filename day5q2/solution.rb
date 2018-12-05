def extractLinesFromFile (fileName)
  return IO.readlines(fileName)
end

def testCharacters (line)
  shortestPolymer = 999999999
  testedChars = []

  for i in 0..(line.length-1) do
    if line[i].is_a?(String)
      if !testedChars.include? line[i]
        testedChars.push(line[i].downcase, line[i].upcase)
        lineTest = line.dup.tr("#{line[i].downcase}#{line[i].upcase}", "")
        processedLine = processLine(lineTest)
        if processedLine.length < shortestPolymer
          puts "New length is #{processedLine.length}"
          shortestPolymer = processedLine.length
        end
      end
    end
  end

  return shortestPolymer
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
  return testCharacters(line)
end

puts main()