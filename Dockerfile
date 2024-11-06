# Use the official Python image from the Python Docker Hub repository as the base image
FROM python:3.12-slim-bullseye

# Set the working directory to /app in the container
WORKDIR /Homework7

# Create a non-root user named 'myuser' with a home directory
RUN groupadd -g 1000 josh336 && \
    useradd -r -u 1000 -g josh336 josh336 && \
    apt-get update && apt-get install -y curl

# Copy the requirements.txt file to the container to install Python dependencies
COPY requirements.txt ./

# Install the Python packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Before copying the application code, create the logs and qr_codes directories
# and ensure they are owned by the non-root user
RUN mkdir logs qr_codes && chown josh336:josh336 logs qr_codes

# Copy the rest of the application's source code into the container, setting ownership to 'myuser'
COPY --chown=josh336:josh336 . .

# Switch to the 'myuser' user to run the application
USER josh336

# Use the Python interpreter as the entrypoint and the script as the first argument
# This allows additional command-line arguments to be passed to the script via the docker run command

# this sets a default argument, its also set in the program but this just illustrates how to use cmd and override it from the terminal
CMD ["curl", "--url","https://github.com/joshua31324324"]
