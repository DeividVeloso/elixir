defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
    |> List.flatten
    |> Enum.with_index
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
