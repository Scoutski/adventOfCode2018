def extractLinesFromFile (fileName)
  return IO.readlines(fileName)
end

def getCoordsAndSize (lines)
  regex = /(\d*),(\d*): (\d*)x(\d*)/
  formatted = []
  for i in 0..lines.length - 1 do
    if lines[i].is_a? String
      matches = lines[i].scan(regex)
      formatted.push(matches.flatten)
    end
  end

  return formatted
end

def createGrid ()
  grid = Array.new(1000, 0)
  for i in 0..grid.length-1 do
    grid[i] = Array.new(1000, 0)
  end

  return grid
end

# [146,196,19,14]
def fillInGrid (formattedLines, grid)
  filledInGrid = grid.dup
  for i in 0..formattedLines.length do
    if formattedLines[i].kind_of?(Array)
      xStart = formattedLines[i][0].to_i-1
      xFinish = formattedLines[i][0].to_i-1 + formattedLines[i][2].to_i-1
      yStart = formattedLines[i][1].to_i-1
      yFinish = formattedLines[i][1].to_i-1 + formattedLines[i][3].to_i-1

      for j in yStart..yFinish do
        for k in xStart..xFinish do
          # puts filledInGrid[j][k]
          # puts "HELLO"
          # puts "#{j}, #{k}"

          if filledInGrid[j][k] == 'x'
            # do nothing
          elsif filledInGrid[j][k] != 0
            filledInGrid[j][k] = 'x'
          else
            filledInGrid[j][k] = i + 1
          end
        end
      end
    end
  end

  return filledInGrid
end

def countOverlappingFields (formattedGrid)
  count = 0
  for i in 0..formattedGrid.length-1 do
    for j in 0..formattedGrid[i].length-1 do
      if formattedGrid[i][j] == 'x'
        count += 1
      end
    end
  end

  return count
end

def main()
  lines = extractLinesFromFile('./input.txt')
  formattedLines = getCoordsAndSize(lines)
  grid = createGrid()
  formattedGrid = fillInGrid(formattedLines, grid)

  # To display entire grid
  # (WARNING: DO THIS WITH SMALLER GRIDS, e.g. 10x10)
  # puts formattedGrid.map { |a| a.map { |i| i.to_s.rjust(3) }.join }

  return countOverlappingFields(formattedGrid)
end


puts Time.now #start time
count = main()
puts "There are #{count} overlapping fields"
puts Time.now #finish time