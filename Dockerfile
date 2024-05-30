# Use a specific base image instead of "latest" to ensure consistency
FROM dawn001/z_mirror:latest

# Set the working directory
WORKDIR /usr/src/app

# Make sure permissions are set properly for the application directory
RUN chmod 777 /usr/src/app

# Copy requirements.txt first and install dependencies to utilize Docker cache efficiently
COPY requirements.txt .

# Install dependencies. If dependencies haven't changed, Docker will use the cached layer.
# Using --no-cache-dir flag to prevent caching pip packages which can save disk space.
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port your application listens on
EXPOSE 6800

# Specify the command to run the application. Using CMD instead of ENTRYPOINT for flexibility.
CMD ["bash", "start.sh"]
