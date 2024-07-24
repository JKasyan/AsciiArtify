FROM golang:1.22 as stage
WORKDIR /src
COPY <<EOF main.go
    package main

    import "fmt"

    func main() {
      fmt.Println("hello, world")
    }
EOF
RUN go build -o ./hello ./main.go

FROM scratch
COPY --from=stage /src/hello .
CMD ["./hello"]