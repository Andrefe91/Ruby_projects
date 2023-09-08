module Chess_methods
  def calculate_movements(position, movements_coordinates)
    valid_movements = []

    movements_coordinates.map do |movement|
      x = movement[0] + position[0]
      y = movement[1] + position[1]

      valid_movements.append([x, y]) if (((0..7).cover?(x)) && ((0..7).cover?(y)))
    end

    return valid_movements
  end
end
