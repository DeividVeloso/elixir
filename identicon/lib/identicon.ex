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

  def test(numbers, size) do 
    IO.puts numbers
    count = trunc(length(numbers) / size)
    chunk_doido(numbers, count - 1, size)
  end

  def chunk_doido(numbers, count, size) when count >= 1 do
    [a, b, c | _tail] = numbers
    numbers = Enum.drop(numbers, size)
    test(numbers, size)
  end

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

  def chunk_na_mao(array, size) do
    do_chunk_na_mao([], array, size)
    |> Enum.reverse()
  end

  defp do_chunk_na_mao(acc, [], _size), do: acc
  
  defp do_chunk_na_mao(acc, array, size) do
    {h, t} = split_array(array, size)
    acc = [h | acc]
    do_chunk_na_mao(acc, t, size)
  end

  defp split_array(array, size) do
    do_split_array([], array, size)
  end

  defp do_split_array(acc, array, 0), do: {acc, array}
  defp do_split_array(acc, [], _size), do: {acc, []}

  defp do_split_array(acc, [h | t], size) do
    acc = [h | acc]
    do_split_array(acc, t, size - 1)
  end


end
# 3
#[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] = [[1,2,3],[4,5,6]...]
