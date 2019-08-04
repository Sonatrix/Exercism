defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_year 31557600
  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    case planet do
      :earth -> compute_earth(seconds)
      :mercury -> seconds / (0.2408467 * @earth_year)
      :venus -> seconds / (0.61519726 * @earth_year)
      :mars -> seconds / (1.8808158 * @earth_year)
      :saturn -> seconds / (29.447498 * @earth_year)
      :uranus -> seconds / (84.016846 * @earth_year)
      :neptune -> seconds / (164.79132 * @earth_year)
      :jupiter -> seconds / (11.862615 * @earth_year)
      _ -> seconds
    end
  end

  @spec compute_earth(pos_integer) :: float
  defp compute_earth(seconds) do
    seconds/(365.25*24*60*60)
  end
end
