defmodule TasksTest do
  use ExUnit.Case
  doctest Tasks

  test "is prime function" do
    assert Tasks.isPrime(13) == true
    assert Tasks.isPrime(4) == false
  end

  test "cylinder area function should return total area of cylinder" do
    assert Tasks.cylinderArea(3, 4) == 175.92918860102841
  end

  test "revese function should reverse the order of item in a list" do
    assert Tasks.reverse([3, 2, 1]) == [1, 2, 3]
    assert Tasks.reverse([4, 4, 5, 1, 2]) == [2, 1, 5, 4, 4]
    assert Tasks.reverse([1, 1, 1]) == [1, 1, 1]
  end

  test "uniqueSum calculates the sum of all unique numbers" do
    assert Tasks.uniqueSum([1, 2, 3]) == 6
    assert Tasks.uniqueSum([2, 2, 2]) == 2
  end

  test "extractRandomN return a new list with random numbers from the original list" do
    elementsCount = 3
    numbers = [4, 2, 8, 6, 6, 3]
    randomElements = Tasks.extractRandomN(numbers, elementsCount)

    assert length(randomElements) == elementsCount and Enum.all?(randomElements, fn x -> x in numbers end)
  end

  test "firstFibonacciElements returns a list containing the first N fibonacci numbers" do
    assert Tasks.firstFibonacciElements(3) == [1, 1, 2]
    assert Tasks.firstFibonacciElements(6) == [1, 1, 2, 3, 5, 8]
  end

  test "translator replaces the words in a string" do
    dict = %{"mama" => "mother", "papa" => "father"}
    assert Tasks.translator(dict, "mama is with papa")
  end

  test "smallestNumber returns the correct order of the digits" do
    assert Tasks.smallestNumber(4, 3, 5) === "345"
    assert Tasks.smallestNumber(3, 0, 2) === "203"
  end

  test "rotateLeft rotates the list to the left by the correct number of elements" do
    assert Tasks.rotateLeft([1 , 2 , 4 , 8 , 4], 3) === [8 , 4 , 1 , 2 , 4]
  end

  test "remove consecutive duplicates from list" do
    assert Tasks.removeConsecutiveDuplicates([1, 2, 2, 2, 4, 8, 4]) === [1, 2, 4, 8, 4]
    assert Tasks.removeConsecutiveDuplicates([1, 1, 1, 1]) === [1]
  end
end
