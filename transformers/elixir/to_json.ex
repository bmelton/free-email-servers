defmodule ToJson do
  def process_file(input_file, output_file) do
    {:ok, infile} = File.open(input_file, [:read])
    {:ok, outfile} = File.open(output_file, [:write])
    process_lines(infile, outfile)

    :ok = File.close(infile)
    :ok = File.close(outfile)
  end

  defp process_lines(infile, outfile) do
    process_lines_recursive(infile, outfile)
  end

  defp process_lines_recursive(infile, outfile) do
    case IO.read(infile, :line) do
      line when is_binary(line) ->
        IO.write(outfile, line)
        process_lines_recursive(infile, outfile)

      :eof ->
        :ok
    end
  end

  def main(args \\ []) do
    ToJson.process_file("../../list_of_free_emails.txt", "output.json")
  end
end
