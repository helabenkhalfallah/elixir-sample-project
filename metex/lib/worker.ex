defmodule Metex.Worker do
  def loop do
    receive do 
      {sender_pid, location} -> 
        send(sender_pid, {:ok, temperature_of(location)})
        _ -> 
          IO.puts "I don't know how to process this message"
      end
      loop
  end

  def temperature_of(location) do
    # data transformation from url to http response to parsing that response
    # pipe : |>
    result = location |> url_for |> HTTPoison.get |> parse_response
    case result do
      {:ok, temp} #case success
          -> "#{location}: #{temp} °C" 
      :error #case error
          -> "#{location} not found"
    end
  end

  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey()}"
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temperature
  end

  defp parse_response(_) do
    :error
  end

  defp compute_temperature(json) do
    try do 
      temp = (json["main"]["temp"] - 273.15) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp apikey do
    "a72ce74f505499dc3d4d8d5752c1935f"
  end
  
end