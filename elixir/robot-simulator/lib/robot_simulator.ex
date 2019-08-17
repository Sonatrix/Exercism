defmodule RobotSimulator do
  # better name for the struct
  defmodule Robot, do: defstruct [:position, :direction]

  defguardp is_direction(direction) when direction in [:north, :east, :south, :west]

  defguardp is_position(position) when is_tuple(position) and tuple_size(position) == 2
  and is_integer(elem(position, 0)) and is_integer(elem(position, 1))

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _position) when not is_direction(direction),
    do: {:error, "invalid direction"}
  def create(_direction, position) when not is_position(position),
    do: {:error, "invalid position"}
  def create(direction, position), do: %Robot{position: position, direction: direction}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, ""), do: robot
  def simulate(%Robot{position: {x, y}, direction: direction} = robot, <<"A", rest::binary>>) do
    newpos =
      case direction do
        :north -> {x, y + 1}
        :west -> {x - 1, y}
        :south -> {x, y - 1}
        :east -> {x + 1, y}
      end
    simulate(%Robot{robot | position: newpos}, rest)
  end
  def simulate(%Robot{direction: direction} = robot, <<"L", rest::binary>>) do
    newdir =
      case direction do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end
    simulate(%Robot{robot | direction: newdir}, rest)
  end
  def simulate(%Robot{direction: direction} = robot, <<"R", rest::binary>>) do
    newdir =
      case direction do
        :north -> :east
        :west -> :north
        :south -> :west
        :east -> :south
      end
    simulate(%Robot{robot | direction: newdir}, rest)
  end
  def simulate(_robot, _instructions), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%Robot{direction: direction}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%Robot{position: position}), do: position
end