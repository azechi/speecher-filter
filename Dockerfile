FROM julia:alpine AS builder
COPY Manifest.toml Project.toml install.jl ./
RUN julia --cpu-target="skylake-avx512" --project=. install.jl

# app
FROM julia:alpine

COPY --from=builder /root/.julia/artifacts /root/.julia/artifacts
COPY --from=builder /root/.julia/compiled /root/.julia/compiled
COPY --from=builder /root/.julia/packages /root/.julia/packages

WORKDIR /root/work

COPY Manifest.toml Project.toml ./

COPY main.jl ./


ENTRYPOINT ["julia", "--project=.", "--cpu-target=skylake-avx512"]
CMD ["main.jl"]
