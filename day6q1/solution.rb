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

def processPoints(map, coords)
  markedMap = map.dup
  for i in 0..map.length-1 do
    for j in 0..map[i].length-1 do
      processPoint(map, markedMap, coords, [i, j])
    end
  end

  return markedMap
end

def processPoint(map, markedMap, coords, point)
  closestPoint = -1
  closestDistance = 999
  sharedSpace = false

  for i in 0..coords.length-1 do
    if map[coords[i][0]][coords[i][1]] != -1
      distance = (point[0] - coords[i][0]).abs + (point[1] - coords[i][1]).abs
      if (distance < closestDistance)
        closestPoint = map[coords[i][0]][coords[i][1]]
        closestDistance = distance
        sharedSpace = false
      elsif (distance == closestDistance)
        sharedSpace = true
      end
    end
  end

  if sharedSpace
    markedMap[point[0]][point[1]] = '.'
  elsif
    markedMap[point[0]][point[1]] = closestPoint
  end
end

def getAreaCounts(map, coords)
  hash = {}

  for i in 0..map.length-1 do
    for j in 0..map[i].length-1 do
      if map[i][j] != '.'
        if hash[coords[map[i][j]].join(', ')] != false
          if hash[coords[map[i][j]].join(', ')]
            hash[coords[map[i][j]].join(', ')] += 1
          else
            hash[coords[map[i][j]].join(', ')] = 1
          end
        end

        if i == 0 || i == map.length-1 || j == 0 || j == map.length-1
          hash[coords[map[i][j]].join(', ')] = false
        end
      end
    end
  end

  return hash
end

def checkLargestCount (hash)
  largestArea = -1
  hash.each_value {|val|
    if val && val > largestArea
      largestArea = val
    end
  }

  return largestArea
end

def main ()
  lines = extractLinesFromFile('./input.txt')
  coords = processCoords(lines)
  grid = createGrid()
  map = mapCoords(coords, grid)
  markedMap = processPoints(map, coords)
  countHash = getAreaCounts(markedMap, coords)
  return checkLargestCount(countHash)
end

puts main()