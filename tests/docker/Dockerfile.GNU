# Use a minimal Ubuntu image
FROM ubuntu:22.04

# Install gfortran
RUN apt-get update && apt-get install -y gfortran libopenmpi-dev libfftw3-dev && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy your code into the container
COPY . /workspace

# Default command to compile your Fortran code
CMD ["make libs && make"]
