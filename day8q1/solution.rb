$metaDataNumbers = []

def extractLinesFromFile (fileName)
  return IO.readlines(fileName)[0]
end

def processLine (line)
  return line.split(' ')
end

def processNode (line, start)
  skip = 0
  totalChildNodes = line[start]
  skip += 1
  totalMetadataNodes = line[start+skip]
  skip += 1

  for j in 0..totalChildNodes.to_i-1 do
    skip += processNode(line, start+skip)
  end

  for j in 0..totalMetadataNodes.to_i-1 do
    $metaDataNumbers.push(line[start + skip])
    skip += 1
  end

  return skip
end

def parseLine (line)
  # Process 2 characters (children) (metadata number)
  # if children process first child and return the amount of characters to skip
  # Add the metadata numbers, push the metadata numbers
  # Skip the loop to the appropriate next character

  i = 0
  while i < line.length-1
    totalToSkip = processNode(line, i)
    i += totalToSkip
  end

  total = 0
  for i in 0..$metaDataNumbers.length-1 do
    total += $metaDataNumbers[i].to_i
  end

  return total
end

def main ()
  line = extractLinesFromFile('./input.txt')
  processedLine = processLine(line)
  return parseLine(processedLine)
end

puts main()
