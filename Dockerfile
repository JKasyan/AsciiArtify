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
RUN go build -o ./hello ./main.go

FROM scratch
COPY --from=stage /src/hello .
CMD ["./hello"]
EXPOSE 8000