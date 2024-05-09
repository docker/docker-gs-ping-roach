##
## THe build image
##

FROM golang:1.19-bookworm AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o /docker-gs-ping-roach

##
## The runtime image
##

FROM gcr.io/distroless/base-debian12

WORKDIR /

COPY --from=build /docker-gs-ping-roach /docker-gs-ping-roach

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/docker-gs-ping-roach"]
