using HTTP

HTTP.listen("0.0.0.0", 8080) do http::HTTP.Stream
  @show http.message
  @show HTTP.header(http, "Content-Type")
  while !eof(http)
    println("body data:", String(readavailable(http)))
  end
  HTTP.setstatus(http, 404)
  HTTP.setheader(http, "Foo-Header" => "basr")
  HTTP.startwrite(http)
  write(http, "response body")
  write(http, "more response")
end

