# Use a specific base image instead of "latest" to ensure consistency
FROM dawn001/z_mirror:latest

# Install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clone the GitLab repository
RUN git clone -b hk_deploy https://gitlab.com/Dawn-India/Z-Mirror /usr/src/app/Z-Mirror

# Set the working directory to the newly cloned repository
WORKDIR /usr/src/app/Z-Mirror

# Make sure permissions are set properly for the application directory
RUN chmod 777 /usr/src/app/Z-Mirror

# Install dependencies using the requirements.txt from the cloned repository
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose the port your application listens on
EXPOSE 8080

# Add a health check to ensure the application is running and listening on the correct port
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Specify the command to run the application. Using CMD instead of ENTRYPOINT for flexibility.
CMD ["bash", "start.sh"]
