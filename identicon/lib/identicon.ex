defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def save_image(binary, input) do
    File.write("#{input}.png", binary)
  end
  
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    #generate canvas
    image = :egd.create(250,250)
    #get color
    fill = :egd.color(color)

    #get start = {50, 0} stop = {100, 50}
    Enum.each pixel_map, fn({start, stop}) -> 
      :egd.filledRectangle(image, start, stop, fill)
    end

    #render image
    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) -> 
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      #draw box 
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter(grid, fn({code, _index}) -> 
      rem(code, 2) == 0
    end)

    %Identicon.Image{image | grid: grid}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
      %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _tail] = row;

    # [145, 46, 200, 46, 145]
    row ++ [second, first]
  end

  def pick_color(image) do
   %Identicon.Image{hex: [r, g, b | _tail]} = image
  # Update a MAP with |
   %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end

  # def test(numbers, size) do
  #   count = trunc(length(numbers) / size)
  #   chunk_doido([], numbers, count - 1, size)
  # end

  # @spec chunk_doido(any, [...], any, number) :: no_return
  # defp chunk_doido(acc, numbers, count, size) when count >= 0 do
  #   [a, b, c | tail] = numbers
  #   acc = [[a, b, c] | acc ]

  #   chunk_doido(acc, tail, count - 1, size)
  # end

  # defp chunk_doido(acc, _, _, _) do
  #   acc
  # end


  # def chunk_na_mao(array, size) do
  #   count = trunc(length(array) / size)
  #   do_chunk_na_mao([], array, count - 1, size)
  # end

  # defp do_chunk_na_mao(acc, array, count, size) when count >= 1 do
  #   [a, b, c | tail] = array
  #   acc = [[a, b, c] | acc ]

  #   do_chunk_na_mao(acc, tail, count - 1, size)
  # end

  # defp do_chunk_na_mao(acc, _, _,_), do: acc

#   def chunk_na_mao(array, size) do
#     do_chunk_na_mao([], array, size)
#     |> Enum.reverse()
#   end

#   defp do_chunk_na_mao(acc, [], _size), do: acc

#   defp do_chunk_na_mao(acc, array, size) do
#     {h, t} = split_array(array, size)
#     acc = [h | acc]
#     do_chunk_na_mao(acc, t, size)
#   end

#   defp split_array(array, size) do
#     do_split_array([], array, size)
#   end

#   defp do_split_array(acc, array, 0), do: {acc, array}
#   defp do_split_array(acc, [], _size), do: {acc, []}

#   defp do_split_array(acc, [h | t], size) do
#     acc = [h | acc]
#     do_split_array(acc, t, size - 1)
#   end
# end
# 3
#[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] = [[1,2,3],[4,5,6]...]
