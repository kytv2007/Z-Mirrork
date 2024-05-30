# Final Dockerfile to run the application
FROM dawn001/z_mirror:latest

# Install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clone the GitLab repository
RUN git clone -b hk_deploy https://gitlab.com/Dawn-India/Z-Mirror /usr/src/app/Z-Mirror

# Set the working directory to the newly cloned repository
WORKDIR /usr/src/app/Z-Mirror

# Make sure permissions are set properly for the application directory
RUN chmod 777 /usr/src/app/Z-Mirror

# Use the base image specified in the GitLab Dockerfile
FROM dawn001/z_mirror:hk_latest

# Set the working directory as per the GitLab Dockerfile
WORKDIR /usr/src/app

# Ensure permissions
RUN chmod 777 /usr/src/app

# Copy the contents from the cloned repository to the container
COPY --from=0 /usr/src/app/Z-Mirror .

# Expose the port the application is expected to listen on
EXPOSE 8080

# Run the application
CMD ["bash", "start.sh"]
