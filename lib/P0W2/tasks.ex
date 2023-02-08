defmodule Tasks do
  @moduledoc """
  Docs for 2nd week tasks.
  """

  @doc """
  isPrime

  ## Examples

      iex> Tasks.isPrime(13)
      true

      iex> Tasks.isPrime(4)
      false
  """
  def isPrime(x) do
    cond do
      x < 2 -> false
      x >= 2 ->
        from = 2
        to = trunc(:math.sqrt(x))
        n_total = to - from + 1

        n_tried =
          Enum.take_while(from..to, fn i -> rem(x, i) != 0 end)
          |> Enum.count()

        n_total == n_tried
    end
  end

  @doc """
  cylinderArea returns the total area of a cylinder, given its height and radius

  ## Examples

      iex> Tasks.cylinderArea(3, 4)
      175.92918860102841
  """
  def cylinderArea(height, radius) do
    baseArea = :math.pi() * radius * radius
    sideArea = 2 * :math.pi() * radius * height

    sideArea + 2 * baseArea
  end

  @doc """
  reverse returns a reversed list given as input

  ## Example

      iex> Tasks.reverse([1, 2, 3])
      [3, 2, 1]
  """
  def reverse(list) do
    Enum.reverse(list)
  end

  @doc """
  uniqueSum returns the sum of all unique numbers from a list

  ## Examples

      iex> Tasks.uniqueSum([1, 2, 3])
      6

      iex> Tasks.uniqueSum([2, 2, 2])
      2
  """
  def uniqueSum(list) do
    Enum.sum(Enum.uniq(list))
  end

  @doc """
  extractRandomN returns n random numbers from a list
  """
  def extractRandomN(list, n) do
    list |> Enum.shuffle |> Enum.take(n)
  end

  @doc """
  fib returns the Nth fibonacci number

  ## Examples

      iex> Tasks.fib(3)
      2

      iex> Tasks.fib(7)
      13
  """
  def fib(n) do
    cond do
      n <= 2 -> 1
      n > 2 -> fib(n - 1) + fib(n - 2)
    end
  end

  @doc """
  firstFibonacciElements returns a list containing the first N fibonacci number

  ## Examples

      iex> Tasks.firstFibonacciElements(5)
      [1, 1, 2, 3, 5]

      iex> Tasks.firstFibonacciElements(7)
      [1, 1, 2, 3, 5, 8, 13]
  """
  def firstFibonacciElements(n) do
    Enum.map(1..n, fn i -> Tasks.fib(i) end)
  end

  @doc """
  translator replaces the word in a string with the word from a given dictionary

  ## Examples
      iex> dict = %{"mama" => "mother", "papa" => "father"}
      iex> Tasks.translator(dict, "mama is with papa")
      "mother is with father"
  """
  def translator(dictionary, originalString) do
    originalString
      |> String.split(" ")
      |> Enum.map(fn word ->
        if Map.has_key?(dictionary, word) do
          dictionary[word]
        else
          word
        end
      end)
      |> Enum.join(" ")
  end


  @doc """
  smallestNumber returns the smallest number that can be obtained from arranging 3 digits

  ## Examples

      iex> Tasks.smallestNumber(4, 5, 3)
      "345"

      iex> Tasks.smallestNumber(0, 3, 4)
      "304"

  """
  def smallestNumber(a, b, c) do
    digitList = [a, b, c]
    orderedDigits = digitList |> Enum.sort()
    firstNonZeroDigitIdx = orderedDigits |> Enum.find_index(fn digit -> digit != 0 end)

    Enum.join(
      [Enum.at(orderedDigits, firstNonZeroDigitIdx)] ++
      List.delete_at(orderedDigits, firstNonZeroDigitIdx)
    )
  end

  @doc """
  rotateLeft rotates the list to the left by n positions

  ## Examples

      iex> Tasks.rotateLeft([1 , 2 , 4 , 8 , 4], 3)
      [8 , 4 , 1 , 2 , 4]

  """
  def rotateLeft(list, n) do
    Enum.drop(list, rem(n, length(list))) ++ Enum.take(list, rem(n, length(list)))
  end

  @doc """
  lists all pythagorean tuples {a, b, c}, where a and b <= 20
  """
  def listRightAngleTriangle() do
    1..20
    |> Enum.flat_map(fn a ->
      1..20
      |> Enum.map(fn b ->
        c = :math.sqrt(a * a + b * b)

        if trunc(c) == c do
            {a, b, trunc(c)}
        else
            nil
        end
      end)
    end)
    |> Enum.filter(fn tuple -> tuple != nil end)
  end

  @doc """
  this removes the elements from the list that are consecutive duplicates
  https://stackoverflow.com/questions/45204757/removing-elements-that-have-consecutive-dupes-in-elixir-list

  ## Examples

      iex> Tasks.removeConsecutiveDuplicates([1, 2, 2, 2, 4, 8, 4])
      [1, 2, 4, 8, 4]

  """
  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end

  @doc """
  this returns the words that can be typed using only one row of letter from the keyboard

  ## Examples

      iex> Tasks.lineWords(["Hello", "Alaska", "Dad", "Peace"])
      ["Alaska", "Dad"]

  """
  def lineWords(wordList) do
    wordList
      |> Enum.filter(fn word ->
        row1 = "qwertyuiop"
        row2 = "asdfghjkl"
        row3 = "zxcvbnm"

        word
          |> String.downcase()
          |> String.split("")
          |> Enum.all?(fn letter -> String.contains?(row1, letter) end)
        or
        word
          |> String.downcase()
          |> String.split("")
          |> Enum.all?(fn letter -> String.contains?(row2, letter) end)
        or
        word
          |> String.downcase()
          |> String.split("")
          |> Enum.all?(fn letter -> String.contains?(row3, letter) end)
      end)
  end

  @doc """
  this encodes a word using the caesar cipher with a given key

  ## Examples

      iex> Tasks.encode("lorem", 3)
      "oruhp"

  """
  def encode(word, key) do
    originalAlphabet = "abcdefghijklmnopqrstuvwxyz" |> String.split("", trim: true)
    encodedAlphabet =  originalAlphabet |> rotateLeft(key)

    word
      |> String.split("", trim: true)
      |> Enum.map(fn wordLetter ->
        letterIndex = originalAlphabet |> Enum.find_index(fn alphabetLetter ->
          alphabetLetter == wordLetter
        end)

        Enum.at(encodedAlphabet, letterIndex)
      end)
      |> Enum.join("")
  end

  @doc """
  this decodes an encoded word using the caesar cipher with a given key

  ## Examples

      iex> Tasks.decode("oruhp", 3)
      "lorem"

  """
  def decode(word, key) do
    originalAlphabet = "abcdefghijklmnopqrstuvwxyz" |> String.split("", trim: true)
    encodedAlphabet =  originalAlphabet |> rotateLeft(key)

    word
      |> String.split("", trim: true)
      |> Enum.map(fn wordLetter ->
        letterIndex = encodedAlphabet |> Enum.find_index(fn alphabetLetter ->
          alphabetLetter == wordLetter
        end)

        Enum.at(originalAlphabet, letterIndex)
      end)
      |> Enum.join("")
  end

  @doc """
  https://leetcode.com/problems/group-anagrams/solutions/2661488/elixir-solution/?q=elixir&orderBy=most_relevant

  ## Example

      iex> Tasks.groupAnagrams (["eat", "tea", "tan", "ate", "nat", "bat"])
      [{"abt", ["bat"]}, {"aet", ["ate", "eat", "tea"]}, {"ant", ["nat", "tan"]}]

  """
  def groupAnagrams(strings) do
    Enum.group_by(strings, fn string ->
      string
      |> String.graphemes()
      |> Enum.sort()
    end)
    |> Enum.map(fn {key, value} ->
      { key |> Enum.join(""), value |> Enum.sort() }
      # value |> Enum.sort()
    end)
  end
end
