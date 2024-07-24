FROM golang:1.22 as stage
WORKDIR /src
COPY <<EOF main.go
    package main

    import (
        "fmt"
        "net/http"
    )

    func hello(w http.ResponseWriter, req *http.Request) {
        fmt.Fprintf(w, "hello, world\n")
    }

    func main() {
      http.HandleFunc("/hello", hello)
      http.ListenAndServe(":8000", nil)
    }
EOF
COPY go.mod .
RUN CGO_ENABLED=0 go build -o app

FROM scratch
COPY --from=stage /src/app .
CMD ["/app"]
EXPOSE 8000