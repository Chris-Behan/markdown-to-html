defmodule MarkdownToHtmlTest do
  use ExUnit.Case
  use ExUnit.Parameterized
  doctest MarkdownToHtml

  test "greets the world" do
    assert MarkdownToHtml.hello() == :world
  end

  test "reads file contents" do
    path = "text1.txt"
    contents = "hello\nworld"
    File.write(path, contents)
    # Call back that runs, deleting the test file, when test exits.
    on_exit(fn -> File.rm!(path) end)
    assert MarkdownToHtml.get_file_contents!(path) == contents
  end

  test "assert error when file dne" do
    assert_raise File.Error, fn ->
      MarkdownToHtml.get_file_contents!("dne.txt")
    end
  end

  test "splits on newlines" do
    one = "hello"
    two = "there"
    three = "my dear friend"
    four = "how are you?"

    content = "#{one}\n#{two}\r#{three}\r\n#{four}"
    expected = [one, two, three, four]

    assert MarkdownToHtml.get_lines(content) == expected
  end

  test_with_params "is h1",
                   fn line, expected_is, expected_capture ->
                     {is_h1, capture} = MarkdownToHtml.is_h1(line)
                     assert is_h1 == expected_is
                     assert capture == expected_capture
                   end do
    [
      {"# title", true, "title"},
      {" # title with leading space", false, ""},
      {"#title with no space after", false, ""},
      {"# ", true, ""},
      {"# #", true, "#"},
      {" #", false, ""},
      {"# hello ####", true, "hello ####"},
      {"#  space", true, " space"}
    ]
  end

  test_with_params "is h2",
                   fn line, expected_is, expected_capture ->
                     {is_h2, capture} = MarkdownToHtml.is_h2(line)
                     assert is_h2 == expected_is
                     assert capture == expected_capture
                   end do
    [
      {"## title", true, "title"},
      {" ## title with leading space", false, ""},
      {"##title with no space after", false, ""},
      {"## ", true, ""},
      {"## #", true, "#"},
      {" ##", false, ""},
      {"## hello ####", true, "hello ####"}
    ]
  end

  test_with_params "is h3",
                   fn line, expected_is, expected_capture ->
                     {is_h3, capture} = MarkdownToHtml.is_h3(line)
                     assert is_h3 == expected_is
                     assert capture == expected_capture
                   end do
    [
      {"### title", true, "title"},
      {" ### title with leading space", false, ""},
      {"###title with no space after", false, ""},
      {"### ", true, ""},
      {"### #", true, "#"},
      {" ###", false, ""},
      {"### hello ####", true, "hello ####"},
      {"###  space", true, " space"}
    ]
  end

  test_with_params "is h4",
                   fn line, expected_is, expected_capture ->
                     {is_h4, capture} = MarkdownToHtml.is_h4(line)
                     assert is_h4 == expected_is
                     assert capture == expected_capture
                   end do
    [
      {"#### title", true, "title"},
      {" #### title with leading space", false, ""},
      {"####title with no space after", false, ""},
      {"#### ", true, ""},
      {"#### #", true, "#"},
      {" ####", false, ""},
      {"#### hello ####", true, "hello ####"},
      {"####  space", true, " space"}
    ]
  end

  test_with_params "is h5",
                   fn line, expected_is, expected_capture ->
                     {is_h5, capture} = MarkdownToHtml.is_h5(line)
                     assert is_h5 == expected_is
                     assert capture == expected_capture
                   end do
    [
      {"##### title", true, "title"},
      {" ##### title with leading space", false, ""},
      {"#####title with no space after", false, ""},
      {"##### ", true, ""},
      {"##### #", true, "#"},
      {" #####", false, ""},
      {"##### hello ####", true, "hello ####"},
      {"#####  space", true, " space"}
    ]
  end

  test_with_params "is h6",
                   fn line, expected_is, expected_capture ->
                     {is_h6, capture} = MarkdownToHtml.is_h6(line)
                     assert is_h6 == expected_is
                     assert expected_capture == capture
                   end do
    [
      {"###### title", true, "title"},
      {" ###### title with leading space", false, ""},
      {"######title with no space after", false, ""},
      {"###### ", true, ""},
      {"###### #", true, "#"},
      {" ######", false, ""},
      {"###### hello ####", true, "hello ####"},
      {"######  space", true, " space"}
    ]
  end
end
