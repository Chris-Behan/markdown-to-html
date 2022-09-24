defmodule MarkdownToHtml do
  @moduledoc """
  Documentation for `MarkdownToHtml`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MarkdownToHtml.hello()
      :world

  """
  def hello do
    :world
  end

  def get_file_contents!(file_path) when is_binary(file_path) do
    File.read!(file_path)
  end

  def get_lines(content) when is_binary(content) do
    new_line_delimiters = ["\r\n", "\n", "\r"]
    String.split(content, new_line_delimiters)
  end

  @doc """
  Checks whether or not a line of text is an h1 element.
  Returns a tuple whose first element is whether or not the text is an h1 element
  and whose second element is the contents of the h1 element.
  """
  def is_h1(line) do
    # Start of string is # followed by a single whitespace,
    # Then capture any characters after that.
    regex = ~r/^#\s{1}(\s*.*)/
    result = Regex.run(regex, line, capture: :all_but_first)

    unless result == nil do
      {true, hd(result)}
    else
      {false, ""}
    end
  end

  @doc """
  Checks whether or not a line of text is an h2 element.
  Returns a tuple whose first element is whether or not the text is an h2 element
  and whose second element is the contents of the h2 element.
  """
  def is_h2(line) do
    # Start of string is ## followed by a single whitespace,
    # Then capture any characters after that.
    regex = ~r/^##\s{1}(\s*.*)/
    result = Regex.run(regex, line, capture: :all_but_first)

    unless result == nil do
      {true, hd(result)}
    else
      {false, ""}
    end
  end

  @doc """
  Checks whether or not a line of text is an h3 element.
  Returns a tuple whose first element is whether or not the text is an h3 element
  and whose second element is the contents of the h3 element.
  """
  def is_h3(line) do
    # Start of string is ### followed by a single whitespace,
    # Then capture any characters after that.
    regex = ~r/^###\s{1}(\s*.*)/
    result = Regex.run(regex, line, capture: :all_but_first)

    unless result == nil do
      {true, hd(result)}
    else
      {false, ""}
    end
  end

  @doc """
  Checks whether or not a line of text is an h4 element.
  Returns a tuple whose first element is whether or not the text is an h4 element
  and whose second element is the contents of the h4 element.
  """
  def is_h4(line) do
    # Start of string is #### followed by a single whitespace,
    # Then capture any characters after that.
    regex = ~r/^####\s{1}(\s*.*)/
    result = Regex.run(regex, line, capture: :all_but_first)

    unless result == nil do
      {true, hd(result)}
    else
      {false, ""}
    end
  end

  @doc """
  Checks whether or not a line of text is an h5 element.
  Returns a tuple whose first element is whether or not the text is an h5 element
  and whose second element is the contents of the h5 element.
  """
  def is_h5(line) do
    # Start of string is ##### followed by a single whitespace,
    # Then capture any characters after that.
    regex = ~r/^#####\s{1}(\s*.*)/
    result = Regex.run(regex, line, capture: :all_but_first)

    unless result == nil do
      {true, hd(result)}
    else
      {false, ""}
    end
  end

  @doc """
  Checks whether or not a line of text is an h6 element.
  Returns a tuple whose first element is whether or not the text is an h6 element
  and whose second element is the contents of the h6 element.
  """
  def is_h6(line) do
    # Start of string is ###### followed by a single whitespace,
    # Then capture any characters after that.
    regex = ~r/^######\s{1}(\s*.*)/
    result = Regex.run(regex, line, capture: :all_but_first)

    unless result == nil do
      {true, hd(result)}
    else
      {false, ""}
    end
  end
end
