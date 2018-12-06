def extractLinesFromFile (fileName)
  return IO.readlines(fileName)
end

def processCoords (lines)
  for i in 0..lines.length-1 do
    lines[i] = lines[i].split(', ');
    for j in 0..lines[i].length-1 do
      lines[i][j] = lines[i][j].to_i
    end
  end

  return lines
end

def createGrid ()
  grid = Array.new(355, -1)
  for i in 0..grid.length-1 do
    grid[i] = Array.new(359, -1)
  end

  return grid
end

def mapCoords (coords, grid)
  for i in 0..coords.length-1 do
    grid[coords[i][0]][coords[i][1]] = i
  end

  return grid
end

def calculateTotalDistances (map, coords)
  count = 0
  for i in 0..map.length-1 do
    for j in 0..map.length-1 do
      totalDistance = 0
      for k in 0..coords.length-1 do
        totalDistance += (i - coords[k][0]).abs + (j - coords[k][1]).abs
      end

      if totalDistance < 10000
        count += 1
      end
    end
  end

  return count
end

def main ()
  lines = extractLinesFromFile('../day6q1/input.txt')
  coords = processCoords(lines)
  grid = createGrid()
  map = mapCoords(coords, grid)
  return calculateTotalDistances(map, coords)
end

puts main()